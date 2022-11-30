SELECT DISTINCT
    patient_identifier.identifier                                                               as `Patient Identifier`,
    concat_ws(' ',pivoted_person_attributes.first_name,
                  pivoted_person_attributes.middle_name,
                  pivoted_person_attributes.last_name)                                          as `Patient Name (Arabic)`,
    pivoted_person_attributes.patient_phone_number_1                                            as `Phone number  1`,
    pivoted_person_attributes.patient_phone_number_2                                            as `Phone number  2`,
    total_passengers.passengers                                                                 as `Total passengers`,
    pa.start_time                                                                               as `Start time`,
    aps.service_3d                                                                              as `3D`,
    aps.service_sedation                                                                        as `Sedation`,
    aps.service                                                                                 as `Service`,
    person_address.city_village                                                                 as `Area`,
    person_address.address1                                                                     as `Address (text)`,
    pa.comments                                                                                 as `Notes`,
    l.name                                                                                      as `Location`
FROM patient_identifier
     JOIN person p ON p.person_id = patient_identifier.patient_id AND p.voided IS FALSE
     JOIN(SELECT person_id,
            group_concat(first_name)                                                            as first_name,
            group_concat(middle_name)                                                           as middle_name,
            group_concat(last_name)                                                             as last_name,
            group_concat(patient_phone_number_1)                                                as patient_phone_number_1,
            group_concat(patient_phone_number_2)                                                as patient_phone_number_2
           FROM (
              (SELECT person_attribute.person_id,
                      person_attribute.value,
                      CASE WHEN person_attribute_type.name = 'givenNameLocal' THEN value END        as first_name,
                      CASE WHEN person_attribute_type.name = 'middleNameLocal' THEN value END       as middle_name,
                      CASE WHEN person_attribute_type.name = 'familyNameLocal' THEN value END       as last_name,
                      CASE WHEN person_attribute_type.name = 'phoneNumber 1' THEN value END         as patient_phone_number_1,
                      CASE WHEN person_attribute_type.name = 'phoneNumber 2' THEN value END         as patient_phone_number_2
              FROM person_attribute
              JOIN person_attribute_type
              ON person_attribute.person_attribute_type_id = person_attribute_type.person_attribute_type_id
              WHERE voided=0) as person_attributes_with_name
              )
              GROUP BY person_id) as pivoted_person_attributes
              ON pivoted_person_attributes.person_id = patient_identifier.patient_id

              JOIN obs o ON o.person_id = patient_identifier.patient_id
              JOIN encounter e ON o.encounter_id = e.encounter_id AND o.voided IS FALSE AND e.voided IS FALSE
              JOIN concept c ON o.concept_id = c.concept_id AND c.retired IS FALSE
              JOIN(
              SELECT obs.person_id,
                    obs.encounter_id,
                    obs.concept_id,
                    MAX(obs.encounter_id) as max_encounter_id
                    FROM obs
                    JOIN patient_program as pp ON obs.person_id = pp.patient_id
                    JOIN encounter ON obs.encounter_id = encounter.encounter_id AND obs.voided = FALSE AND encounter.voided = FALSE
                    JOIN(SELECT concept_name.concept_id,
                            concept_name.name,
                            concept_name.concept_name_type,
                            concept_name.voided
                         FROM concept_name
                      ) as obs_question
                    ON obs.concept_id = obs_question.concept_id
                    AND obs_question.concept_name_type="FULLY_SPECIFIED" AND obs_question.voided = 0
                    JOIN concept_name as coded_concept ON coded_concept.concept_id = obs.value_coded
                    AND coded_concept.concept_name_type="FULLY_SPECIFIED" AND coded_concept.voided IS FALSE
                        WHERE ((obs_question.name IN('IMA, Transportation need', 'PPN, Transportation need')
                        AND (coded_concept.name = 'Ambulance' OR coded_concept.name = 'Car'))
                        AND pp.outcome_concept_id IS NULL)
                        OR ((obs_question.name = 'IMA, Transportation need' OR (obs_question.name = 'PPN, Transportation need' and obs_question.name = 'PPN, Type of visit'))
                        and ((coded_concept.name = 'Ambulance' and (coded_concept.name != 'Discharge' OR pp.outcome_concept_id IS NULL))
                        OR  (coded_concept.name = 'Car' and (coded_concept.name != 'Discharge' OR pp.outcome_concept_id IS NULL)))
                    )

              GROUP BY person_id) as latest_encounter
                    ON latest_encounter.max_encounter_id = e.encounter_id
            LEFT OUTER JOIN(
             SELECT
                    obs.encounter_id,
                    obs.concept_id,
                    obs.person_id,
                    SUM(obs.value_numeric) as passengers
                    FROM obs
                    JOIN encounter ON obs.encounter_id = encounter.encounter_id AND obs.voided = FALSE AND encounter.voided = FALSE
                    JOIN concept_name numeric_concept ON numeric_concept.concept_id = obs.concept_id
                     AND numeric_concept.voided IS FALSE
                     AND numeric_concept.name IN('IMA, Number of passengers', 'PPN, Number of passengers')
                     AND numeric_concept.concept_name_type ="FULLY_SPECIFIED"
                    GROUP BY person_id, encounter_id) as total_passengers
                    ON latest_encounter.max_encounter_id = total_passengers.encounter_id
                    JOIN(SELECT patient_id,
                               comments,
                               appointment_service_id,
                               location_id,
                               voided,
                               MIN(CAST(start_date_time AS TIME)) as start_time
                               FROM patient_appointment
                               WHERE status NOT IN ('Cancelled')
                               AND date(start_date_time) >= '#startDate#' and date(end_date_time) <= '#endDate#'
                               GROUP BY patient_id, CAST(start_date_time as DATE)
                               ) as pa
                 ON pa.patient_id = latest_encounter.person_id
                 JOIN(SELECT
                         CASE WHEN appointment_service.name = '3D' THEN 'Yes' ELSE NULL END as service_3d,
                         CASE WHEN appointment_service.name = 'Session under sedation' THEN appointment_service_type.name ELSE NULL END as service_sedation,
                         CASE WHEN appointment_service.name !='3D' and appointment_service.name !='Session under sedation' THEN appointment_service.name ELSE NULL END as service,
                         appointment_service.*
                      FROM appointment_service
                      JOIN appointment_service_type
                      ON appointment_service.appointment_service_id = appointment_service_type.appointment_service_type_id
                       ) as aps
                      ON pa.appointment_service_id = aps.appointment_service_id
                 LEFT JOIN location l ON l.location_id = pa.location_id AND l.retired IS FALSE AND pa.voided IS FALSE
                  JOIN person_address ON person_address.person_id = pa.patient_id AND person_address.voided IS FALSE

WHERE patient_identifier.identifier_type = (SELECT patient_identifier_type_id FROM patient_identifier_type WHERE name = 'Patient Identifier')
ORDER BY l.name, person_address.state_province, person_address.city_village;