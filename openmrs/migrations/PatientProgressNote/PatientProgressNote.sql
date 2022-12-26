set @concept_id = 0;
set @concept_short_id = 0;
set @concept_full_id = 0;
set @count = 0;
set @uuid = NULL;

#Add Parent Concepts
#Add Date Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Date","Date","Date","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Date of suture removal","Date of suture removal","Date","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Date of clips removal","Date of clips removal","Date","Question",false);

#Add Coded Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Type of visit","Type of visit","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Type of Pain","Type of Pain","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Examination findings","Examination findings","Coded","Finding",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Transportation need","Transportation need","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Pain management","Pain management","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Wound management","Wound management","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Physiotherapy frequency","Physiotherapy frequency","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Wound dressing frequency","Wound dressing frequency","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Specialised consultation","Specialised consultation","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Orthopaedic consultation timing","Orthopaedic consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Osteomyelitis consultation timing","Osteomyelitis consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Pain management consultation timing","Pain management consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Plastic consultation timing","Plastic consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, MH consultation timing","MH consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Patient sent to IPD","Patient sent to IPD","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Discharge status","Discharge status","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Referral location","Referral location","Coded","Question",false);

#Add Numeric Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, FLACC scale","FLACC scale","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Visual analog scale","Visual analog scale","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, DN4","DN4","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Number of passengers","Number of passengers","Numeric","Question",false);

#Add Numeric concepts to concept Numeric Table
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "PPN, FLACC scale" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,NULL,-0.1,NULL,NULL,"",0,0);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "PPN, Visual analog scale" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,NULL,-0.1,NULL,NULL,"",0,0);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "PPN, DN4" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,NULL,-0.1,NULL,NULL,"",0,0);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "PPN, Number of passengers" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),3,NULL,NULL,1,NULL,NULL,"",0,0);

#Add Text Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Examination comments","Examination comments","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Treatment plan comment","Treatment plan comment","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Comment on process of care","Comment on process of care","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Comment on process of discharge","Comment on process of discharge","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PPN, Patient Complain","Patient Complain","Text","Question",false);

#Add Child Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Clips removal","Clips removal","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Wound intact and healing","Wound intact and healing","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Suture removal","Suture removal","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Second level pain reliever","Second level pain reliever","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Dressing","Dressing","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sedation","Sedation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Procedural pain","Procedural pain","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lab request","Lab request","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Background pain","Background pain","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Open non-healing wound","Open non-healing wound","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"TENS","TENS","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Wound infection","Wound infection","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Follow-up","Follow-up","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"SSI","SSI","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PTI","PTI","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Surgical procedure","Surgical procedure","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"EMONO","EMONO","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"First level pain reliever","First level pain reliever","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Trigger Point","Trigger Point","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Third level pain reliever","Third level pain reliever","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Local analgesia","Local analgesia","N/A","Misc",false);

#Add Help Text to Concepts
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "PPN, FLACC scale" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"for patients younger than 7 years","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "PPN, Visual analog scale" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"for adults","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "PPN, DN4" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"if suspicion of neuropathic pain","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "PPN, Number of passengers" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"Including the Patient","en",1,now(),NULL,NULL,uuid());
