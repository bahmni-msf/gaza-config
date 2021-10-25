DELETE
FROM global_property
where property = 'emrapi.sqlSearch.activePrograms';
select uuid()
into @uuid;
INSERT INTO global_property (`property`, `property_value`, `description`, `uuid`)
VALUES ('emrapi.sqlSearch.activePrograms', "select
pi.identifier,
concat(ifnull(pn.given_name,''), ' ', ifnull(pn.middle_name,''),' ', ifnull(pn.family_name,'')) as PATIENT_LISTING_QUEUES_PATIENT_NAME_IN_ENGLISH
from patient_program pp
join patient_identifier pi on pp.patient_id=pi.patient_id
join person p on p.person_id = pp.patient_id
join person_name pn on pn.person_id = pp.patient_id
where date_completed IS NULL and pp.voided = 0 and outcome_concept_id IS NULL and pn.voided=0 and pi.voided=0
and pi.identifier_type IN (select patient_identifier_type_id from patient_identifier_type where name='Patient Identifier') order by pi.identifier;",
  'List of Patients Enrolled to a program',
  @uuid
);