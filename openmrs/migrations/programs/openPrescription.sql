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
  personData.name AS 'Patient Name',
  personData.age  AS 'Age',
  latest_obs.Specialty AS 'Speciality',
  latest_obs.`Name of Surgeon`,
  bed.bed_allocation AS 'Bed Allocation',
  medications.prescriber AS 'Prescriber',
  medications.drugName AS 'Medications',
  DATE_FORMAT(medications.date_activated,'%d/%m/%Y') AS 'Start Date',
  DATE_FORMAT(medications.date_created, '%d/%m/%Y %r') AS 'Prescribed/Updated Time',
  medications.durartion_units AS 'Duration & Units',
  personData.uuid,
  personData.programUuid,
  personData.enrollment
FROM
  (SELECT
     p.uuid                                                                                                     AS uuid,
     prog.uuid                                                                                                  AS programUuid,
     pp.uuid                                                                                                    AS enrollment,
     pp.date_enrolled,
     concat(pn.given_name, ' ', pn.family_name)                                                                 AS name,
     floor(DATEDIFF(CURDATE(), p.birthdate) / 365)                                                              AS age,
     pi.identifier                                                                                              AS identifier,
     p.person_id                                                                                                AS person_id
   FROM person p
     JOIN patient_identifier pi ON p.person_id = pi.patient_id AND p.voided IS FALSE AND pi.voided IS FALSE
     JOIN patient_program pp ON pp.patient_id = p.person_id AND pp.voided IS FALSE AND pp.date_completed IS NULL
     JOIN program prog ON prog.program_id = pp.program_id  AND prog.retired IS FALSE
     JOIN person_name pn ON p.person_id = pn.person_id AND pn.voided IS FALSE
   GROUP BY p.person_id) personData
  LEFT JOIN (
              SELECT
                obs.person_id,
                GROUP_CONCAT(DISTINCT (IF(c_name = 'FV, Name (s) of Surgeon 1',
                                          COALESCE(coded_fscn.name, coded_scn.name), NULL))) AS 'Name of Surgeon',
                GROUP_CONCAT(DISTINCT (IF(c_name = 'FSTG, Specialty determined by MLO',
                                          COALESCE(coded_fscn.name, coded_scn.name), NULL))) AS 'Specialty'
              FROM (SELECT
                      cn.name             AS c_name,
                      o.person_id,
                      max(e.encounter_datetime) AS latest_encounter_datetime,
                      o.concept_id
                    FROM obs o
                      JOIN concept_name cn ON cn.name IN
                                              ('FV, Name (s) of Surgeon 1',
                                               'FSTG, Specialty determined by MLO')
                                              AND cn.concept_id = o.concept_id AND cn.voided IS FALSE AND
                                              o.voided IS FALSE
                      JOIN encounter e ON e.encounter_id = o.encounter_id AND e.voided IS FALSE
                    GROUP BY person_id, concept_id) result
                JOIN encounter e ON e.encounter_datetime = result.latest_encounter_datetime AND result.person_id = e.patient_id AND e.voided IS FALSE
                JOIN obs ON obs.concept_id = result.concept_id  AND result.person_id = obs.person_id AND e.encounter_id = obs.encounter_id AND
                            obs.voided IS FALSE
                LEFT JOIN concept_name coded_fscn ON coded_fscn.concept_id = obs.value_coded
                                                     AND coded_fscn.concept_name_type = 'FULLY_SPECIFIED'
                                                     AND coded_fscn.voided IS FALSE
                LEFT JOIN concept_name coded_scn ON coded_scn.concept_id = obs.value_coded
                                                    AND coded_fscn.concept_name_type = 'SHORT'
                                                    AND coded_scn.voided IS FALSE
              GROUP BY obs.person_id
            ) latest_obs ON latest_obs.person_id = personData.person_id
  INNER JOIN (
               SELECT
                 p.patient_id,
                 CONCAT(pn.given_name, ' ', pn.family_name) AS 'prescriber',
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
  LEFT OUTER JOIN (
                    SELECT
                      p.patient_id,
                      concat(location.name,'(',bed.bed_number,')') AS bed_allocation,
                      bed.bed_number,
                      location.name,
                      bpam.date_created
                    FROM patient p
                      LEFT JOIN bed_patient_assignment_map bpam on bpam.patient_id = p.patient_id AND
                                                                   bpam.date_stopped IS NULL
                      INNER JOIN bed on bed.bed_id = bpam.bed_id
                      INNER JOIN bed_location_map blm on blm.bed_id = bed.bed_id
                      INNER JOIN location on location.location_id = blm.location_id
                    GROUP BY bpam.patient_id
                  ) bed on bed.patient_id = personData.person_id
ORDER BY medications.date_created DESC;",
    'Open Prescriptions',
    @uuid
  );