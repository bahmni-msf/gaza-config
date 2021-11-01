set @concept_id = 0;
set @concept_short_id = 0;
set @concept_full_id = 0;
set @count = 0;
set @uuid = NULL;

#Add Parent Concepts
#Add Date Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Date","Date","Date","Misc",false);

#Add Text Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Other injury, specify","Other injury, specify","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Other referral location, specify","Other referral location, specify","Text","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Free text comment","Free text comment","Text","Misc",false);

#Add Coded Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Source of initial patient referral","Source of initial patient referral","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, MoH facility","MoH facility","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, UNRWA facility","UNRWA facility","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, NGO facility","NGO facility","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Private facility type","Private facility type","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Type of injury","Type of injury","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Admission status","Admission status","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Reason of rejection","Reason of rejection","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Out of criteria","Out of criteria","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Patient sent to another actor?","Patient sent to another actor?","Coded","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"FC, Referral location:","Referral location:","Coded","Misc",false);

#Add Child Concepts
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Deir al Balah","Deir al Balah","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ma'an","Ma'an","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"MOH","MOH","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Private health care clinic/facility","Private health care clinic/facility","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Al Aqsa","Al Aqsa","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Shabbourah","Shabbourah","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"MSFOCB","MSFOCB","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"self-referred","self-referred","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Nuseirat West","Nuseirat West","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"WHO","WHO","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Rafah","Rafah","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Burn","Burn","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Ahli Arabi","Ahli Arabi","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Gaza Medina","Gaza Medina","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Beit Hanoun","Beit Hanoun","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Clinic","Clinic","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Maghazi","Maghazi","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Out of criteria","Out of criteria","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Japanees","Japanees","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Others","Others","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Um Nasser","Um Nasser","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Indonesian","Indonesian","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Naser","Naser","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Shiffa","Shiffa","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"MAP-UK","MAP-UK","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Followed by another actor","Followed by another actor","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Quds Hospital","Quds Hospital","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Readmission","Readmission","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Rejection","Rejection","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Jabalia","Jabalia","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Shokah","Shokah","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Tal as Sultan","Tal as Sultan","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"UNRWA","UNRWA","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Fakhora","Fakhora","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Shatea","Shatea","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"NGO","NGO","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Traumatic injury","Traumatic injury","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"ALPC","ALPC","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Others 5622","Others 5622","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Nuseirat","Nuseirat","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Simple wound","Simple wound","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sheikh Radwan","Sheikh Radwan","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"European","European","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Najjar","Najjar","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Patient refuses the plan","Patient refuses the plan","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Other health facility","Other health facility","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"No documentation","No documentation","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Saftawi","Saftawi","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Government-run health clinic/facility","Government-run health clinic/facility","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Khan Younis","Khan Younis","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"MOH Clinic","MOH Clinic","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Hospital","Hospital","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Remal","Remal","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Sabra","Sabra","N/A","Misc",false);
call add_concept(@concept_id,@concept_short_id,@concept_full_id,"Bureij","Bureij","N/A","Misc",false);
