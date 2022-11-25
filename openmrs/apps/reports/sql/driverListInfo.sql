SELECT DISTINCT
    patient_identifier.identifier                                                         as `Patient Identifier`,
    concat_ws(' ',pivoted_person_attributes.first_name,
                  pivoted_person_attributes.middle_name,
                  pivoted_person_attributes.last_name)                                          as `Patient Name (Arabic)`,
    pivoted_person_attributes.patient_phone_number_1                                            as `Phone number  1`,
    pivoted_person_attributes.patient_phone_number_2                                            as `Phone number  2`,
    total_passengers.passengers                                                               as `Total passengers`,
    CAST(pa.start_time AS TIME)                                                                 as `Start Time`,
    aps.service_3d                                                                              as `3D`,
    aps.service_sedation                                                                        as `Sedation`,
    aps.service                                                                                 as `Service`,
    person_address.county_district                                                              as `Area`,
    person_address.address1                                                                     as `Address (text)`,
    pa.comments                                                                                 as `Notes`,
    l.name                                                                                      as `Location`
FROM patient_identifier
     JOIN person p ON p.person_id = patient_identifier.patient_id AND p.voided IS FALSE
     JOIN(SELECT person_id,
            group_concat(first_name)                                    AS first_name,
            group_concat(middle_name)                                   AS middle_name,
            group_concat(last_name)                                     AS last_name,
            group_concat(patient_phone_number_1)                                      AS patient_phone_number_1,
            group_concat(patient_phone_number_2)                                      AS patient_phone_number_2
           FROM (
              (SELECT person_attribute.person_id,
                      person_attribute.value,
                      CASE WHEN person_attribute_type.name = 'givenNameLocal' THEN value END            as first_name,
                      CASE WHEN person_attribute_type.name = 'middleNameLocal' THEN value END           as middle_name,
                      CASE WHEN person_attribute_type.name = 'familyNameLocal' THEN value END           as last_name,
                      CASE WHEN person_attribute_type.name = 'phoneNumber 1' THEN value END             as patient_phone_number_1,
                      CASE WHEN person_attribute_type.name = 'phoneNumber 2' THEN value END             as patient_phone_number_2
              FROM person_attribute
                       join person_attribute_type
                         on person_attribute.person_attribute_type_id = person_attribute_type.person_attribute_type_id where voided=0) as person_attributes_with_name
                          )
                          group by person_id) as pivoted_person_attributes
                          on pivoted_person_attributes.person_id = patient_identifier.patient_id
                        JOIN(select patient_id,
                                          comments,
                                          appointment_service_id,
                                          location_id,
                                          voided,
                                          MIN(start_date_time) as start_time
                                          from patient_appointment
                                          where status NOT IN ('Cancelled')
                                          and date(start_date_time) >= '#startDate#' and date(end_date_time) <= '#endDate#'
                                          GROUP BY patient_id, CAST(start_date_time as DATE)
                                          ) as pa
                        ON pa.patient_id = patient_identifier.patient_id
                        JOIN(SELECT
                                CASE WHEN appointment_service.name = '3D' THEN 'Yes' ELSE NULL END as service_3d,
                                CASE WHEN appointment_service.name = 'Session under sedation' THEN appointment_service_type.name ELSE NULL END as service_sedation,
                                CASE WHEN appointment_service.name !='3D' and appointment_service.name !='Session under sedation' THEN appointment_service.name ELSE NULL END as service,
                                appointment_service.*
                             FROM appointment_service
                             join appointment_service_type
                             on appointment_service.appointment_service_id = appointment_service_type.appointment_service_type_id
                              ) as aps
                               ON pa.appointment_service_id = aps.appointment_service_id
                        LEFT JOIN location l ON l.location_id = pa.location_id AND l.retired IS FALSE AND pa.voided IS FALSE
                         join person_address on person_address.person_id = pa.patient_id AND person_address.voided is false
                         join obs o on o.person_id = patient_identifier.patient_id
                         JOIN encounter e ON o.encounter_id = e.encounter_id AND o.voided is false and e.voided is false
                         JOIN concept c ON o.concept_id = c.concept_id AND c.retired IS FALSE
                         JOIN(
                         select obs.person_id,
                                obs.encounter_id,
                                obs.concept_id,
                                max(obs.obs_datetime) as max_encounter_datetime
                                from obs
                                join patient_program as pp on obs.person_id = pp.patient_id
                                join encounter on obs.encounter_id = encounter.encounter_id and obs.voided = FALSE and encounter.voided = FALSE
                               JOIN(select concept_name.concept_id,
                                        concept_name.name,
                                        concept_name.concept_name_type,
                                        concept_name.voided
                                  from concept_name
                                  ) as obs_question
                                   ON obs.concept_id = obs_question.concept_id
                                  JOIN concept_name coded_concept on coded_concept.concept_id = obs.value_coded
                                  and coded_concept.name IN('Ambulance', 'Car', 'Discharge')
                                  AND coded_concept.concept_name_type="SHORT" AND coded_concept.voided is false
                                WHERE obs_question.name IN('IMA, Transportation need', 'PPN, Transportation need')
                                and (obs_question.name='PPN, Type of visit' OR pp.outcome_concept_id IS NOT NULL)
                                and obs_question.concept_name_type="FULLY_SPECIFIED" and obs_question.voided = 0
                                GROUP BY obs.person_id, obs.encounter_id) as latest_encounter
                                on latest_encounter.max_encounter_datetime = e.encounter_datetime
                        LEFT OUTER JOIN(
                         select
                                obs.encounter_id,
                                obs.concept_id,
                                obs.person_id,
                                obs.value_numeric as passengers
                                from obs
                                join encounter on obs.encounter_id = encounter.encounter_id and obs.voided = FALSE and encounter.voided = FALSE
                                JOIN concept_name numeric_concept ON numeric_concept.concept_id = obs.concept_id
                                 and numeric_concept.voided is false
                                 AND numeric_concept.name IN('IMA, Number of passengers', 'PPN, Number of passengers')
                                 and numeric_concept.concept_name_type ="FULLY_SPECIFIED"
                                  group by person_id) as total_passengers
                               ON patient_identifier.patient_id = total_passengers.person_id
                          WHERE patient_identifier.identifier_type = (SELECT patient_identifier_type_id FROM patient_identifier_type where name = 'Patient Identifier')
                     order by l.name, person_address.state_province, person_address.county_district;