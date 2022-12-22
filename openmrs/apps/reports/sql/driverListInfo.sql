SELECT DISTINCT
    patient_identifier.identifier                                                               as `Patient Identifier`,
    concat_ws(' ',pivoted_person_attributes.first_name,
                  pivoted_person_attributes.middle_name,
                  pivoted_person_attributes.last_name)                                          as `Patient Name (Arabic)`,
    pivoted_person_attributes.patient_phone_number_1                                            as `Phone number  1`,
    pivoted_person_attributes.patient_phone_number_2                                            as `Phone number  2`,
    total_passengers.passengers                                                                 as `Total passengers`,
    pa.start_time                                                                               as `Start time`,
    (CASE WHEN EXISTS (SELECT appointment_service_id FROM appointment_service as1
        WHERE name = '3D' and as1.voided = 0
        AND appointment_service_id IN (SELECT DISTINCT appointment_service_id
        FROM patient_appointment pa1
        WHERE as1.appointment_service_id=pa1.appointment_service_id
        AND pa1.patient_id = pa.patient_id
        AND pa1.voided = 0
        AND date(pa1.start_date_time)=date(pa.start_date_time))) THEN 'Yes' ELSE NULL END)       as `3D`,
    (SELECT name FROM appointment_service_type ast
        WHERE ast.voided = 0
        and appointment_service_id IN(SELECT DISTINCT appointment_service_id
        FROM appointment_service as1
        WHERE as1.name = 'Session under sedation' AND as1.voided = 0)
        AND appointment_service_type_id IN (CASE WHEN EXISTS (SELECT appointment_service_type_id
        FROM patient_appointment pa1
        WHERE ast.appointment_service_id=pa1.appointment_service_id
        AND ast.appointment_service_type_id=pa1.appointment_service_type_id
        AND pa1.patient_id = pa.patient_id
        AND pa1.voided = 0
        AND date(pa1.start_date_time)=date(pa.start_date_time))
        THEN appointment_service_type_id ELSE NULL END))                                        as `Sedation`,
    pa.service                                                                                  as `Service`,
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
              JOIN person_address ON person_address.person_id = patient_identifier.patient_id AND person_address.voided IS FALSE
              JOIN(select
                   MIN(start_time),
                   patientApp.appointment_service_id,
                   patientApp.appointment_service_type_id,
                   patientAppointment.comments,
                   patientApp.start_time,
                   patientApp.location_id,
                   patientAppointment.patient_id,
                   patientAppointment.voided,
                   patientApp.service,
                   patientAppointment.start_date_time
                   from patient_appointment as patientAppointment
                   JOIN(select
                           patient_appointment.patient_appointment_id,
                           patient_appointment.appointment_service_id,
                           patient_appointment.appointment_service_type_id,
                           patient_appointment.comments,
                           patient_appointment.location_id,
                           MIN(CAST(patient_appointment.start_date_time AS TIME)) as start_time,
                           appServiceName,
                           appServiceTypeName,
                           service
                           FROM patient_appointment
                               LEFT JOIN(SELECT
                               appService.appointment_service_id,
                               appServiceType.appointment_service_type_id,
                               appService.name as appServiceName,
                               appServiceType.name as appServiceTypeName,
                               CASE WHEN appService.name !='3D' and appService.name !='Session under sedation' THEN appServiceType.name ELSE NULL END as service
                               from appointment_service as appService
                                   LEFT JOIN appointment_service_type as appServiceType
                                   on appService.appointment_service_id = appServiceType.appointment_service_id
                                   and appServiceType.voided IS FALSE
                                   WHERE appService.voided=0) as aps
                                   ON  aps.appointment_service_id = patient_appointment.appointment_service_id
                                   AND  aps.appointment_service_type_id = patient_appointment.appointment_service_type_id
                            where status NOT IN ('Cancelled')
                            and date(start_date_time) >= '#startDate#'
                            and date(end_date_time) <= '#endDate#'
                            group by start_date_time, patient_id)as patientApp
                            on patientApp.patient_appointment_id = patientAppointment.patient_appointment_id
                            group by patient_id, CAST(start_date_time AS DATE)
                             ) as pa
                         ON pa.patient_id = patient_identifier.patient_id and pa.voided IS FALSE
                    JOIN location l ON pa.location_id = l.location_id AND l.retired IS FALSE AND pa.voided IS FALSE

              JOIN obs o ON o.person_id = patient_identifier.patient_id
              JOIN encounter e ON o.encounter_id = e.encounter_id AND o.voided IS FALSE AND e.voided IS FALSE
              JOIN concept c ON o.concept_id = c.concept_id AND c.retired IS FALSE
              JOIN(
              SELECT obs.person_id,
                    obs.concept_id,
                    obs.obs_datetime
                    FROM obs
                    JOIN patient_program as pp ON obs.person_id = pp.patient_id and pp.voided IS FALSE
                    JOIN encounter e ON obs.encounter_id = e.encounter_id AND obs.voided IS FALSE AND e.voided IS FALSE
                    JOIN concept_name obs_question on obs_question.concept_id = obs.concept_id
                    AND obs_question.concept_name_type="FULLY_SPECIFIED" AND obs_question.voided IS FALSE
                    JOIN concept_name as coded_concept ON coded_concept.concept_id = obs.value_coded
                    AND coded_concept.concept_name_type="FULLY_SPECIFIED" AND coded_concept.voided IS FALSE
                        WHERE obs.obs_datetime = (select max(encounter_datetime) from encounter where encounter.patient_id = obs.person_id)
                        and (((obs_question.name IN('IMA, Transportation need', 'PPN, Transportation need')
                        AND (coded_concept.name = 'Ambulance' OR coded_concept.name = 'Car'))
                        AND pp.outcome_concept_id IS NULL)
                        OR ((obs_question.name = 'IMA, Transportation need' OR (obs_question.name = 'PPN, Transportation need' and obs_question.name = 'PPN, Type of visit'))
                        and ((coded_concept.name = 'Ambulance' and (coded_concept.name != 'Discharge' AND pp.outcome_concept_id IS NULL))
                        OR  (coded_concept.name = 'Car' and (coded_concept.name != 'Discharge' AND pp.outcome_concept_id IS NULL)))))
              ) as latest_encounter
                    ON latest_encounter.person_id = e.patient_id
            LEFT OUTER JOIN(
             SELECT
                    obs.obs_datetime,
                    obs.concept_id,
                    obs.person_id,
                    obs.value_numeric as passengers
                    FROM obs
                    JOIN encounter ON obs.encounter_id = encounter.encounter_id AND obs.voided IS FALSE AND encounter.voided IS FALSE
                    JOIN concept_name numeric_concept ON numeric_concept.concept_id = obs.concept_id
                    AND numeric_concept.concept_name_type ="FULLY_SPECIFIED"
                    AND numeric_concept.voided IS FALSE
                    WHERE obs.obs_datetime = (select max(encounter_datetime) from encounter where encounter.patient_id = obs.person_id)
                    AND numeric_concept.name IN('IMA, Number of passengers', 'PPN, Number of passengers')
                   ) as total_passengers
                    ON total_passengers.obs_datetime = latest_encounter.obs_datetime


WHERE patient_identifier.identifier_type = (SELECT patient_identifier_type_id FROM patient_identifier_type WHERE name = 'Patient Identifier')
and patient_identifier.voided = 0
ORDER BY l.name, person_address.state_province, person_address.city_village;
