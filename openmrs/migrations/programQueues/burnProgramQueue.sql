DELETE
FROM global_property
where property = 'emrapi.sqlSearch.activeBurnProgram';
select uuid()
into @uuid;
INSERT INTO global_property (`property`, `property_value`, `description`, `uuid`)
VALUES ('emrapi.sqlSearch.activeBurnProgram', "select
identifier,
concat(ifnull(GivenNameArabic,' '), '', ifnull(MiddleNameArabic, ' '),'',ifnull(FamilyNameArabic, '')) as PATIENT_LISTING_QUEUES_PATIENT_NAME_IN_ARABIC,
concat(ifnull(given_name,''), ' ', ifnull(middle_name, ''),' ', ifnull(family_name, '')) as PATIENT_LISTING_QUEUES_PATIENT_NAME_IN_ENGLISH,
DATE_FORMAT(date_enrolled, '%d %b %Y') as PATIENT_LISTING_QUEUES_DATE_OF_ENROLLMENT,
name as PATIENT_LISTING_QUEUES_PROGRAM_STATE,
uuid
from
(select
identifier,
personName.given_name,
personName.family_name,
personName.middle_name,
date_enrolled,
cn.name,
pp.patient_id,
p.uuid
from patient_program pp
join person p on p.person_id = pp.patient_id
 join program pg on pg.program_id =pp.program_id
join  patient_state programstate on programstate.patient_program_id = pp.patient_program_id and programstate.end_date IS NULL and pp.date_completed IS NULL
join program_workflow_state programWorkFlowState on programstate.state = programWorkFlowState.program_workflow_state_id
join concept_name cn on programWorkFlowState.concept_id = cn.concept_id
join patient_identifier patientIdentifier on pp.patient_id = patientIdentifier.patient_id
join person_name personName on personName.person_id = pp.patient_id
where (patientIdentifier.identifier_type IN (select patient_identifier_type_id from patient_identifier_type where name ='Patient Identifier'))
AND pg.name = 'Burn' AND pp.outcome_concept_id IS NULL AND pp.voided is false AND pp.date_voided is null AND cn.concept_name_type='FULLY_SPECIFIED' AND cn.locale='en'
)pu

LEFT JOIN
(
    SELECT      value as 'GivenNameArabic', person_id
    FROM        person_attribute
    WHERE       person_attribute_type_id = (SELECT person_attribute_type_id from person_attribute_type where name = 'givenNameLocal')
)pag
on pu.patient_id= pag.person_id

LEFT JOIN
(
    SELECT      value as 'MiddleNameArabic', person_id
    FROM        person_attribute
    WHERE       person_attribute_type_id = (SELECT person_attribute_type_id from person_attribute_type where name = 'middleNameLocal')
)pam
on pu.patient_id= pam.person_id

LEFT JOIN
(
    SELECT      value as 'FamilyNameArabic', person_id
    FROM        person_attribute
    WHERE       person_attribute_type_id = (SELECT person_attribute_type_id from person_attribute_type where name = 'familyNameLocal')
)paf
on pu.patient_id= paf.person_id order by identifier;",
'Patients enrolled in Burn Program',
@uuid);