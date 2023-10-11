set @concept_id = 0;
set @concept_short_id = 0;
set @concept_full_id = 0;
set @count = 0;
set @uuid = NULL;

#Add Parent Concepts
#Add Date Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Date","Date","Date","Misc",false);

#Add Coded Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Consultation type","Consultation type","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Obtaining and using toilet supplies","Obtaining and using toilet supplies","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Managing clothes before and after toileting","Managing clothes before and after toileting","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Washing (including hair)","Washing (including hair)","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Drying","Drying","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Turning taps","Turning taps","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Managing hair","Managing hair","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Use nail clipper","Use nail clipper","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Cleaning teeth","Cleaning teeth","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Perfuming","Perfuming","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Washing hands","Washing hands","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Shaving","Shaving","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Fastening buttons","Fastening buttons","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Fastening zippers","Fastening zippers","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Put on and remove pants","Put on and remove pants","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Put on and remove shirts","Put on and remove shirts","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Fastening belts","Fastening belts","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Put on shoe and tie laces","Put on shoe and tie laces","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Tie head scarf/cap","Tie head scarf/cap","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Holding cutlery","Holding cutlery","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Kitchen tasks","Kitchen tasks","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Bread activity","Bread activity","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Helping with household jobs","Helping with household jobs","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Using work appliances","Using work appliances","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Using door handle an electric tool","Using door handle an electric tool","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Using writing tools","Using writing tools","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Using keyboard and mouse","Using keyboard and mouse","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Driving","Driving","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Play/leisure","Play/leisure","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Shopping and carry grocery bags","Shopping and carry grocery bags","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Left: Unilateral bilateral reach","Left: Unilateral bilateral reach","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Right: Unilateral bilateral reach","Right: Unilateral bilateral reach","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Left: Spherical grasp","Left: Spherical grasp","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Right: Spherical grasp","Right: Spherical grasp","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Left: Hook","Left: Hook","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Right: Hook","Right: Hook","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Left: Release","Left: Release","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Right: Release","Right: Release","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Left: Tripod prehension","Left: Tripod prehension","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Right: Lateral pinch prehension","Right: Lateral pinch prehension","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Bilateral hand use","Bilateral hand use","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Follow up needed","Follow up needed","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, End of OCT treatment","End of OCT treatment","Coded","Misc",false);

#Add Numeric Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Activity living task score","Activity living task score","Numeric","Misc",false);

#Add Numeric concepts to concept Numeric Table
INSERT INTO concept_numeric (concept_id,hi_absolute,hi_critical,hi_normal,low_absolute,low_critical,low_normal,units,precise,display_precision)
VALUES ((select concept_id from concept_name where name = "OTS, Activity living task score" and concept_name_type = "FULLY_SPECIFIED"  and locale = "en"  and voided = 0),NULL,NULL,NULL,NULL,NULL,NULL,"",1,1);

#Add Text Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Treatment goal","Treatment goal","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Treatment plan","Treatment plan","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"OTS, Outcome of service, other","Outcome of service, other","Text","Misc",false);

#Add Child Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Complete dependent/Unable to do","Complete dependent/Unable to do","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Independent with severe difficulties","Independent with severe difficulties","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Exit for no improvement since the last assessment","Exit for no improvement since the last assessment","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Left against medical advise (LAMA)","Left against medical advise (LAMA)","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Referred to external Facility","Referred to external Facility","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Difficult","Difficult","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Initial assessment","Initial assessment","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"No","No","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Independent with mild difficulties","Independent with mild difficulties","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Normal","Normal","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Independent","Independent","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Re-assessment","Re-assessment","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Yes","Yes","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Defaulter","Defaulter","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Other","Other","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Final assessment","Final assessment","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Independent with mild difficulties","Independent with mild difficulties","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Full recovery / goals met","Full recovery / goals met","N/A","Misc",false);
