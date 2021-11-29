set @concept_id = 0;
set @concept_short_id = 0;
set @concept_full_id = 0;
set @count = 0;
set @uuid = NULL;

#Add Parent Concepts
#Add Date Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Date","Date","Date","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Date of Injury","Date of Injury","Date","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Estimated date of delivery","Estimated date of delivery","Date","Question",false);

#Add Text Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Other injury, specify","Other injury, specify","Text","Finding",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Trauma/injury history comment","Trauma/injury history comment","Text","Finding",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Other cause of injury, specify","Other cause of injury, specify","Text","Finding",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Other cause of burn, specify","Other cause of burn, specify","Text","Finding",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Detailed location information","Detailed location information","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Procedure performed","Procedure performed","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Procedure date","Procedure date","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Details of medical treatment provided","Details of medical treatment provided","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Past medical history, comment","Past medical history, comment","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, History of surgery, comment","History of surgery, comment","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Date of event","Date of event","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Currently taking medication","Currently taking medication","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Dose and frequency","Dose and frequency","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Type of drug","Type of drug","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Reaction to drug","Reaction to drug","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Allergy details","Allergy details","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Additional patient history","Additional patient history","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Joint description","Joint description","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Description of burn","Description of burn","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Injury site, Other","Injury site, Other","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Other trauma","Other trauma","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Fracture site, Other","Fracture site, Other","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Description of injury","Description of injury","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Other associated injury, specify","Other associated injury, specify","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Description of associated injury","Description of associated injury","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Radiology findings","Radiology findings","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Provisional diagnosis","Provisional diagnosis","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Physiotherapy frequency","Physiotherapy frequency","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Free text comment","Free text comment","Text","Finding",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Counselling frequency","Counselling frequency","Text","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Wound Dressing frequency","Wound Dressing frequency","Text","Question",false);

#Add Coded Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Type of injury","Type of injury","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Cause of injury","Cause of injury","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Cause of burn","Cause of burn","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Location of first treatment","Location of first treatment","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, History of hospitalisation","History of hospitalisation","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, History of surgery","History of surgery","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Medical treatment provided","Medical treatment provided","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Past medical history diagnosis","Past medical history diagnosis","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Currently pregnant","Currently pregnant","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Currently breast-feeding","Currently breast-feeding","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, History of allergy","History of allergy","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Smoking status","Smoking status","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Burn site","Burn site","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Burn position","Burn position","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Burn side","Burn side","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Circumferential burn","Circumferential burn","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Degree of burn","Degree of burn","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Injury site","Injury site","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Type of trauma","Type of trauma","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Fracture site","Fracture site","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Fracture management","Fracture management","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Associated injury","Associated injury","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Radiology results available","Radiology results available","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Transportation need","Transportation need","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Prescription","Prescription","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Specialised consultation","Specialised consultation","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Patient sent to IPD","Patient sent to IPD","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Informed consent","Informed consent","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Orthopaedic consultation timing","Orthopaedic consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Osteomyelitis consultation timing","Osteomyelitis consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Pain management consultation timing","Pain management consultation timing","Coded","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Plastic consultation timing","Plastic consultation timing","Coded","Question",false);

#Add Numeric Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Weight at admission","Weight at admission","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, TBSA","TBSA","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Total TBSA","Total TBSA","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, FLACC Scale","FLACC Scale","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Visual analog scale","Visual analog scale","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, DN4","DN4","Numeric","Question",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"IMA, Length of stay","Length of stay","Numeric","Question",false);

#Add Numeric concepts to concept Numeric Table
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "IMA, Weight at admission" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),1000,NULL,NULL,1,NULL,NULL,"Kg",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "IMA, TBSA" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),100,NULL,100,0,NULL,0,"%",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "IMA, Total TBSA" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),NULL,NULL,NULL,NULL,NULL,NULL,"%",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "IMA, FLACC Scale" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,10,0,NULL,0,"",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "IMA, Visual analog scale" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,10,0,NULL,0,"",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "IMA, DN4" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,10,0,NULL,0,"",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "IMA, Length of stay" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),NULL,NULL,NULL,NULL,NULL,NULL,"days",1,1);

#Add Child Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Drugs","Drugs","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"K-wire","K-wire","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Never smoker","Never smoker","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Counselling","Counselling","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Buttock","Buttock","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Wound dressing","Wound dressing","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Car","Car","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Diabetes","Diabetes","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Foot","Foot","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Open wound","Open wound","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"NGO facility","NGO facility","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Smoker","Smoker","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Food","Food","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Right","Right","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior","Anterior","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"External fixation","External fixation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Genital region","Genital region","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Cardiovascular disease","Cardiovascular disease","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Upper arm","Upper arm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Radiation","Radiation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ex-smoker","Ex-smoker","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Closed fracture","Closed fracture","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Tendon injury","Tendon injury","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ulna","Ulna","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Suspicion of Osteomyelitis","Suspicion of Osteomyelitis","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lateral","Lateral","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Tibia","Tibia","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Traffic accident","Traffic accident","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Amputation","Amputation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Metacarpal bone","Metacarpal bone","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Face","Face","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Physiotherapy","Physiotherapy","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Radius","Radius","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Posterior","Posterior","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Epilepsy","Epilepsy","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hand","Hand","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Trunk","Trunk","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Metatarsal bone","Metatarsal bone","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Assault","Assault","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"None","None","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Neck","Neck","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ambulance","Ambulance","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Plastic consultation","Plastic consultation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Femur","Femur","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Chemical","Chemical","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Humerus","Humerus","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Forearm","Forearm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Thigh","Thigh","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Gun shot","Gun shot","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Soft tissue injury","Soft tissue injury","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Asthma","Asthma","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Electrocuted","Electrocuted","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"COPD","COPD","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Unintentional injury","Unintentional injury","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hypertension","Hypertension","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Medial","Medial","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Fibula","Fibula","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Superficial second degree burn","Superficial second degree burn","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Burn unit Naser","Burn unit Naser","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Left","Left","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Orthopaedic consultation","Orthopaedic consultation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Internal fixation","Internal fixation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Vascular injury","Vascular injury","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Contact with hot surface","Contact with hot surface","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Nerve injury","Nerve injury","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"First degree burn","First degree burn","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Open fracture","Open fracture","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Explosion","Explosion","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Burn unit Shiffa","Burn unit Shiffa","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hot liquid burn","Hot liquid burn","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Deep second degree burn","Deep second degree burn","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lower leg","Lower leg","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Joint","Joint","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Pain management consultation","Pain management consultation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Peptic Ulcer","Peptic Ulcer","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Mental health disorder","Mental health disorder","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Osteomyelitis consultation","Osteomyelitis consultation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Open flame","Open flame","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Scalp","Scalp","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Application of cast","Application of cast","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Third degree burn","Third degree burn","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Non urgent","Non urgent","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Urgent","Urgent","N/A","Misc",false);

#Add Help Text to Concepts
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, Trauma/injury history comment" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"Describe history and symptoms (e.g. itching, pain, etc)","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, Currently taking medication" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"e.g. medication for chronic disease","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, Smoking status" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"If yes, specify pack-year history","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, Description of burn" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"e.g. colour, texture, presence of blisters, signs of infection, ...","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, Description of associated injury" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"If gun shot injury, describe the entry and exit wound.","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, FLACC Scale" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"for patients younger than 7 years","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, Visual analog scale" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"for adults","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, DN4" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"if suspicion of neuropathic pain","en",1,now(),NULL,NULL,uuid());
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "IMA, Informed consent" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"Patient consented to data sharing with other organisations","en",1,now(),NULL,NULL,uuid());
