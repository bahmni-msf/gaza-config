set @concept_id = 0;
set @concept_short_id = 0;
set @concept_full_id = 0;
set @count = 0;
set @uuid = NULL;

#Add Parent Concepts
#Add Date Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PSN, Date","Date","Date","Misc",false);

#Add Coded Concepts
#Add Numeric Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PSN, Pain score","Pain score","Numeric","Misc",false);

#Add Numeric concepts to concept Numeric Table
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "PSN, Pain score" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,NULL,-0.1,NULL,NULL,"",0,0);

#Add Text Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PSN, SOAP notes","SOAP notes","Text","Misc",false);

#Add Child Concepts
#Add Help Text to Concepts
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "PSN, Pain score" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"For children under 4 years, use FLAC. Above 5 years, use VAS pain scale","en",1,now(),NULL,NULL,uuid());
