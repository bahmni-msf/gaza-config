SELECT
    patient_identifier.identifier                                                         as `Patient Identifier`,
    concat_ws(' ',pivoted_person_attributes.first_name,
                  pivoted_person_attributes.middle_name,
                  pivoted_person_attributes.last_name)                                          as `Patient Name (Arabic)`,
    pivoted_person_attributes.patient_phone_number_1                                            as `Phone number  1`,
    pivoted_person_attributes.patient_phone_number_2                                            as `Phone number  2`,
    CAST(pa.start_date_time as TIME)                                                            as `Start Time`,
    person_address.county_district                                                              as `Area`,
    person_address.address1                                                                     as `Address (text)`
FROM patient_identifier
        JOIN person_name on person_name.person_id = patient_identifier.patient_id
        JOIN(SELECT person_id,
                    group_concat(first_name)                                    as first_name,
                    group_concat(middle_name)                                   as middle_name,
                    group_concat(last_name)                                     as last_name,
                    group_concat(patient_phone_number_1)                                      as patient_phone_number_1,
                    group_concat(patient_phone_number_2)                                      as patient_phone_number_2
              FROM (
              (SELECT person_attribute.person_id,
                      person_attribute.value,
                      case when person_attribute_type.name = 'givenNameLocal' then value end            as first_name,
                      case when person_attribute_type.name = 'middleNameLocal' then value end           as middle_name,
                      case when person_attribute_type.name = 'familyNameLocal' then value end           as last_name,
                      case when person_attribute_type.name = 'phoneNumber 1' then value end             as patient_phone_number_1,
                      case when person_attribute_type.name = 'phoneNumber 2' then value end             as patient_phone_number_2
                   from person_attribute
                       join person_attribute_type
                         on person_attribute.person_attribute_type_id = person_attribute_type.person_attribute_type_id where voided=0) as person_attributes_with_name
                          )
                          group by person_id) as pivoted_person_attributes
                          on pivoted_person_attributes.person_id = patient_identifier.patient_id
                        JOIN patient_appointment pa
                        ON pa.patient_id = patient_identifier.patient_id
                         join person_address on person_address.person_id = patient_identifier.patient_id

                    WHERE patient_identifier.identifier_type = (SELECT patient_identifier_type_id FROM patient_identifier_type where name = 'Patient Identifier')
                     order by person_address.state_province, person_address.county_district desc;