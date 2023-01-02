DELETE FROM
  global_property
where
  property = 'emrapi.sqlSearch.openPrescription';

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
    'emrapi.sqlSearch.openPrescription',
    "SELECT
  personData.identifier,
  personData.arabicName AS 'Patient Name in Arabic',
  personData.name AS 'Patient Name in English',
  personData.age  AS 'Age',
  (select l.name from location l where l.location_id = (select location_id from patient_appointment where patient_id = personData.person_id order by date_created DESC limit 1)) AS 'Clinic',
  medications.prescriber AS 'Prescriber',
  (select DATE_FORMAT(v.date_started, '%d/%m/%Y') from visit v where v.patient_id = personData.person_id and date(v.date_started) <= date(medications.updated_time) and (v.date_stopped is NULL or date(v.date_stopped) >= date(medications.updated_time)) limit 1) AS 'Visit Date',
  DATE_FORMAT(medications.date_activated,'%d/%m/%Y') AS 'Start Date',
  medications.durartion_units AS 'Duration & Units'
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
                 IF(drug_code.code IS NOT NULL, drug.name, drug_order.drug_non_coded)                         AS 'drugName',
                 orders.date_created,
                 orders.date_activated,
                 CONCAT(drug_order.duration,' ',durationUnitscn.name) AS 'durartion_units'
               FROM patient p
                 JOIN patient_program pp ON pp.patient_id = p.patient_id AND pp.voided IS FALSE
                 JOIN encounter e ON e.patient_id = p.patient_id AND e.voided IS FALSE
                 JOIN orders ON orders.patient_id = pp.patient_id AND orders.encounter_id = e.encounter_id AND
                                orders.voided IS FALSE AND orders.order_action != 'DISCONTINUE' AND (orders.auto_expire_date IS NULL or orders.auto_expire_date> now())
                                AND orders.date_stopped IS NULL
                                AND EXISTS (Select obs.order_id from obs where obs.concept_id = ( SELECT concept_id FROM concept_name WHERE name = 'Dispensed' ) AND obs.order_id = orders.order_id AND obs.voided IS FALSE)
                                AND DATEDIFF((Select obs.date_created from obs where obs.concept_id = ( SELECT concept_id FROM concept_name WHERE name = 'Dispensed' ) AND obs.order_id = orders.order_id AND obs.voided IS FALSE), now())<=5
                 JOIN users on users.user_id = orders.creator
                 JOIN person on person.person_id = users.person_id
                 JOIN person_name pn on pn.person_id = person.person_id
                 LEFT JOIN obs ON obs.order_id = orders.order_id AND obs.voided IS FALSE AND obs.concept_id = (SELECT concept_id FROM concept_name WHERE name = 'Dispensed' )
                 LEFT JOIN orders stopped_order ON stopped_order.patient_id = pp.patient_id AND stopped_order.voided = 0 AND
                                                   stopped_order.order_action = 'DISCONTINUE' AND
                                                   stopped_order.previous_order_id = orders.order_id
                 JOIN concept c on c.concept_id = orders.concept_id AND c.retired IS FALSE
                 LEFT JOIN drug_order drug_order ON drug_order.order_id = orders.order_id
                 LEFT JOIN concept_name durationUnitscn ON durationUnitscn.concept_id = drug_order.duration_units AND durationUnitscn.concept_name_type = 'FULLY_SPECIFIED' AND durationUnitscn.voided = 0
                 LEFT JOIN drug ON drug.concept_id = orders.concept_id
                 LEFT JOIN concept_reference_term_map_view drug_code ON drug_code.concept_id = drug.concept_id and drug_code.concept_reference_source_name='MSF-INTERNAL' and drug_code.concept_map_type_name= 'SAME-AS'
             ) medications on medications.patient_id = personData.person_id
ORDER BY medications.date_created DESC;",
    'Dispensed Medications',
    @uuid
  );