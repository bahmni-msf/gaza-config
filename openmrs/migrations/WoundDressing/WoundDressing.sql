set @concept_id = 0;
set @concept_short_id = 0;
set @concept_full_id = 0;
set @count = 0;
set @uuid = NULL;

#Add Parent Concepts
#Add Date Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Date of dressing","Date of dressing","Date","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Date of next dressing","Date of next dressing","Date","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Date of discharge","Date of discharge","Date","Misc",false);

#Add Coded Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Dressing station","Dressing station","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Wound location","Wound location","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Wound location laterality","Wound location laterality","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Tissue healing","Tissue healing","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Wound status","Wound status","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Exudate quantity","Exudate quantity","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Exudate type","Exudate type","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Odor","Odor","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Edge description","Edge description","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Peri wound aspect","Peri wound aspect","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Wound cleansing","Wound cleansing","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Debridement technique","Debridement technique","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Disinfection","Disinfection","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Dressing","Dressing","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Peri wound protection","Peri wound protection","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Type of pain","Type of pain","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Pain medication received","Pain medication received","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Follow-up needed","Follow-up needed","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Service outcome","Service outcome","Coded","Misc",false);

#Add Numeric Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Length","Length","Numeric","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Width","Width","Numeric","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Depth","Depth","Numeric","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, FLACC","FLACC","Numeric","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, VAS","VAS","Numeric","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Numeric","Numeric","Numeric","Misc",false);

#Add Numeric concepts to concept Numeric Table
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "WD, Length" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),99.999999999,NULL,NULL,-0.0000000001,NULL,NULL,"cm",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "WD, Width" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),99.999999999,NULL,NULL,-0.0000000001,NULL,NULL,"cm",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "WD, Depth" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),99.999999999,NULL,NULL,-0.0000000001,NULL,NULL,"cm",1,1);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "WD, FLACC" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,NULL,-0.1,NULL,NULL,"",0,0);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "WD, VAS" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,NULL,-0.1,NULL,NULL,"",0,0);
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "WD, Numeric" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),10,NULL,NULL,-0.1,NULL,NULL,"",0,0);

#Add Text Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Edge, other","Edge, other","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Peri wound aspect, other","Peri wound aspect, other","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Removal foreign materials","Removal foreign materials","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Peri wound protection, other","Peri wound protection, other","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Pain medication note","Pain medication note","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WD, Planned treatment","Planned treatment","Text","Misc",false);

#Add Child Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Infected","Infected","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ca Alginate","Ca Alginate","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Care-related","Care-related","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"EMONO room","EMONO room","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sanguinolent","Sanguinolent","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Rolled","Rolled","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Paraffin gauzes","Paraffin gauzes","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hypergranulation","Hypergranulation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Healed wound","Healed wound","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Silver dressing","Silver dressing","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Eczema","Eczema","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"5% soap","5% soap","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Epithelialization","Epithelialization","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Haemorrhagic","Haemorrhagic","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Macerated","Macerated","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Fucidin cream","Fucidin cream","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Normal","Normal","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Not healing","Not healing","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Heavy","Heavy","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Irrigation NaCl 0","Irrigation NaCl 0","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Referred","Referred","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"9%","9%","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PVI 4% soap diluted","PVI 4% soap diluted","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Granulation","Granulation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Undermined","Undermined","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Intermittent","Intermittent","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Moderate","Moderate","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Serous","Serous","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Necrosis","Necrosis","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Silver Sulfadiazine","Silver Sulfadiazine","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Mechanical (curette, blade)","Mechanical (curette, blade)","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Serosanguinous","Serosanguinous","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Continuous","Continuous","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hyperkeratinized","Hyperkeratinized","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Zinc Oxide 10% ointment","Zinc Oxide 10% ointment","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Irritated","Irritated","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Dressing room","Dressing room","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sterile gauzes","Sterile gauzes","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Haemopurulent","Haemopurulent","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Seropurulent","Seropurulent","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PVI 7","PVI 7","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Healing-not infected","Healing-not infected","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Crusts","Crusts","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PVI 10% gel","PVI 10% gel","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Fibrin","Fibrin","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Dry","Dry","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PVI 10% sol.","PVI 10% sol.","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Absorbent dressing","Absorbent dressing","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Purulent","Purulent","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Itchy","Itchy","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hydrogel","Hydrogel","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sedation room","Sedation room","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Low","Low","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Edema","Edema","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"blade)","blade)","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Autolytic","Autolytic","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hydrocortisone cream","Hydrocortisone cream","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"PVI 10% sol. Diluted","PVI 10% sol. Diluted","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Mechanically by NaCl 0.9 % and Gauze","Mechanically by NaCl 0.9 % and Gauze","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Erythema","Erythema","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Fibrinous","Fibrinous","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Posterior pillar of the shoulder","Posterior pillar of the shoulder","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Mouth","Mouth","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Upper limb","Upper limb","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Dorsal aspect of wrist","Dorsal aspect of wrist","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Dorsum of foot","Dorsum of foot","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Upper lip","Upper lip","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Elbow, antecubital fossa","Elbow, antecubital fossa","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Little finger","Little finger","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Eye","Eye","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Medial condylar surface of elbow","Medial condylar surface of elbow","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Posterior surface of lower leg","Posterior surface of lower leg","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ankle","Ankle","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Side of neck","Side of neck","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lateral surface of forearm","Lateral surface of forearm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Stump","Stump","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior patellar region","Anterior patellar region","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Palm hand","Palm hand","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lower back","Lower back","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Posterior elbow","Posterior elbow","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior surface of lower leg","Anterior surface of lower leg","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior surface of shoulder","Anterior surface of shoulder","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lateral surface of lower leg","Lateral surface of lower leg","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Dorsum of hand","Dorsum of hand","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hip","Hip","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Knee, popliteal fossa","Knee, popliteal fossa","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Gluteal region","Gluteal region","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Thumb","Thumb","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Elbow","Elbow","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Wrist","Wrist","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior surface of forearm","Anterior surface of forearm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lateral trunk","Lateral trunk","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Posterior surface of forearm","Posterior surface of forearm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Nose","Nose","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Posterior surface of thigh","Posterior surface of thigh","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior surface of ankle","Anterior surface of ankle","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Posterior surface of upper arm","Posterior surface of upper arm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior surface of upper arm","Anterior surface of upper arm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Pubis","Pubis","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Front of neck","Front of neck","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sacrum","Sacrum","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lateral condylar surface of elbow","Lateral condylar surface of elbow","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Medial surface of forearm","Medial surface of forearm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ear","Ear","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Toe","Toe","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lower limb","Lower limb","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Scapula","Scapula","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lower lip","Lower lip","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Breast","Breast","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Cheek","Cheek","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Back of the neck","Back of the neck","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Volar surface of wrist","Volar surface of wrist","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ring finger","Ring finger","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Forehead","Forehead","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Chin","Chin","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Perineum","Perineum","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Head","Head","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Deltoid region","Deltoid region","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Shoulder","Shoulder","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Upper eyelid","Upper eyelid","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Upper back","Upper back","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Genital organ","Genital organ","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Medial surface of upper arm","Medial surface of upper arm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Axilla","Axilla","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Thorax","Thorax","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Knee","Knee","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ankle posterior","Ankle posterior","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sole of foot","Sole of foot","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lower eyelid","Lower eyelid","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Abdomen","Abdomen","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lateral surface of upper arm","Lateral surface of upper arm","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Medial surface of lower leg","Medial surface of lower leg","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Anterior surface of thigh","Anterior surface of thigh","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Index finger","Index finger","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Medial surface of knee","Medial surface of knee","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Middle finger","Middle finger","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Lateral surface of knee","Lateral surface of knee","N/A","Misc",false);


#Add Help Text to Concepts
INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid)
VALUES ((select concept_id from concept_name where name = "WD, Pain medication note" and concept_name_type = "FULLY_SPECIFIED" and locale = "en" and voided = 0),
"Pain medication taken before the visit","en",1,now(),NULL,NULL,uuid());
