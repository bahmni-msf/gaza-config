DELETE FROM
  global_property
where
  property = 'emrapi.sqlSearch.dispensedMedications';

select
  uuid() into @uuid;

INSERT INTO
  global_property (
    `property`,
    `property_value`,
    `description`,
    `uuid`
  )
VALUES
  (
    'emrapi.sqlSearch.dispensedMedications',
    "SELECT
  personData.identifier,
  personData.arabicName AS 'Patient Name in Arabic',
  personData.name AS 'Patient Name in English',
  personData.age  AS 'Age',
  medications.drugName AS 'Drug Name',
  (select l.name from location l where l.location_id = (select location_id from visit where patient_id = personData.person_id order by date_created DESC limit 1)) AS 'Clinic',
  medications.prescriber AS 'Prescriber',
  DATE_FORMAT(medications.visit_date, '%d/%m/%Y') AS 'Visit Date',
  DATE_FORMAT(medications.date_activated,'%d/%m/%Y') AS 'Start Date',
  medications.duration_units AS 'Duration & Units',
  personData.uuid,
  personData.programUuid,
  personData.enrollment
FROM
  (
    SELECT
      p.uuid AS uuid,
      prog.uuid AS programUuid,
      pp.uuid AS enrollment,
      pp.date_enrolled,
      concat_ws(
        ' ',
        pivoted_person_attributes.first_name,
        pivoted_person_attributes.last_name
      ) AS 'arabicName',
      concat(pn.given_name, ' ', pn.family_name) AS name,
      floor(DATEDIFF(CURDATE(), p.birthdate) / 365) AS age,
      pi.identifier AS identifier,
      p.person_id AS person_id
    FROM
      person p
      JOIN patient_identifier pi ON p.person_id = pi.patient_id
      AND pi.preferred=1
      AND p.voided IS FALSE
      AND pi.voided IS FALSE
      JOIN patient_program pp ON pp.patient_id = p.person_id
      AND pp.voided IS FALSE
      AND pp.date_completed IS NULL
      JOIN program prog ON prog.program_id = pp.program_id
      AND prog.retired IS FALSE
      JOIN person_name pn ON p.person_id = pn.person_id
      AND pn.voided IS FALSE
      JOIN(
        SELECT
          person_id,
          group_concat(first_name) as first_name,
          group_concat(last_name) as last_name
        FROM
          (
            (
              SELECT
                person_attribute.person_id,
                CASE
                  WHEN person_attribute_type.name = 'givenNameLocal' THEN value
                END as first_name,
                CASE
                  WHEN person_attribute_type.name = 'familyNameLocal' THEN value
                END as last_name
              FROM
                person_attribute
                JOIN person_attribute_type ON person_attribute.person_attribute_type_id = person_attribute_type.person_attribute_type_id
              WHERE
                voided = 0
            ) as person_attributes_with_name
          )
        GROUP BY
          person_id
      ) as pivoted_person_attributes ON pivoted_person_attributes.person_id = p.person_id
    GROUP BY
      p.person_id
  ) personData
  INNER JOIN (
               SELECT
                 p.patient_id,
                 CONCAT(pn.given_name, ' ', pn.family_name) AS 'prescriber',
                 COALESCE(orders.date_stopped, orders.date_created) AS 'updated_time',
                 IF(drug.name IS NOT NULL, drug.name, drug_order.drug_non_coded)                         AS 'drugName',
                 orders.date_created,
                 orders.date_activated,
                 (select v.date_started from visit v where visit_id=(select visit_id from encounter where encounter_id=orders.encounter_id) limit 1) AS 'visit_date',
                 CONCAT(drug_order.duration,' ',durationUnitsConceptName.name) AS 'duration_units',
                 pp.uuid AS 'pgmUuid'
               FROM patient p
                 JOIN patient_program pp ON pp.patient_id = p.patient_id AND pp.voided IS FALSE
                 JOIN encounter e ON e.patient_id = p.patient_id AND e.voided IS FALSE
                 JOIN orders ON orders.patient_id = pp.patient_id AND orders.encounter_id = e.encounter_id AND
                                orders.voided IS FALSE AND orders.order_action != 'DISCONTINUE' AND (orders.auto_expire_date IS NULL or orders.auto_expire_date> now())
                                AND orders.date_stopped IS NULL
                                AND EXISTS (Select obs.order_id from obs where obs.concept_id = ( SELECT concept_id FROM concept_name WHERE name = 'Dispensed' ) AND obs.order_id = orders.order_id AND obs.voided IS FALSE)
                                AND DATEDIFF(now(),(Select obs.date_created from obs where obs.concept_id = ( SELECT concept_id FROM concept_name WHERE name = 'Dispensed' )
                                AND obs.order_id = orders.order_id AND obs.voided IS FALSE)) <= 5
                 JOIN users on users.user_id = orders.creator
                 JOIN person on person.person_id = users.person_id
                 JOIN person_name pn on pn.person_id = person.person_id
                 LEFT JOIN obs ON obs.order_id = orders.order_id AND obs.voided IS FALSE AND obs.concept_id = (SELECT concept_id FROM concept_name WHERE name = 'Dispensed' )
                 LEFT JOIN orders stopped_order ON stopped_order.patient_id = pp.patient_id AND stopped_order.voided = 0 AND
                                                   stopped_order.order_action = 'DISCONTINUE' AND
                                                   stopped_order.previous_order_id = orders.order_id
                 JOIN concept c on c.concept_id = orders.concept_id AND c.retired IS FALSE
                 LEFT JOIN drug_order drug_order ON drug_order.order_id = orders.order_id
                 LEFT JOIN concept_name durationUnitsConceptName ON durationUnitsConceptName.concept_id = drug_order.duration_units AND durationUnitsConceptName.concept_name_type = 'FULLY_SPECIFIED' AND durationUnitsConceptName.voided = 0
                 LEFT JOIN drug ON drug.concept_id = orders.concept_id
             ) medications on medications.patient_id = personData.person_id and personData.enrollment = medications.pgmUuid ORDER BY Clinic, medications.visit_date desc;",
    'Dispensed Medications',
    @uuid
  );