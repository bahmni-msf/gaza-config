CREATE PROCEDURE add_new_drug (drug_name NVARCHAR(255),
                             drug_strength VARCHAR(255),
                             dosage_form_name VARCHAR(255),
                             concept_locale_proc VARCHAR(255))
BEGIN
 DECLARE user_id_proc INT;
 DECLARE drug_concept_id INT;
 DECLARE dosage_form_id INT;
 DECLARE new_drug_id INT;
 DECLARE new_concept_id INT;

SELECT count(distinct concept_name_id) into @concept_count from concept_name WHERE name = drug_name AND concept_name_type = "FULLY_SPECIFIED" AND locale = concept_locale_proc AND voided = 0;
  IF @concept_count = 0 THEN
  set @concept_name_short_id = 0;
  set @concept_name_full_id = 0;
  set @concept_datatype_coded = 0;
  SELECT MAX(concept_id) INTO new_concept_id FROM concept;
  call add_new_concept(@new_concept_id, @concept_name_short_id, @concept_name_full_id, drug_name, drug_name, null, 'N/A', 'Drug', concept_locale_proc, false);
END IF;

SELECT count(distinct concept_name_id) into @drug_name_count from concept_name WHERE name = dosage_form_name AND concept_name_type = "FULLY_SPECIFIED" AND locale = concept_locale_proc AND voided = 0;
  IF @drug_name_count = 0 THEN
  set @concept_name_short_id = 0;
  set @concept_name_full_id = 0;
  set @concept_datatype_coded = 0;
  SELECT MAX(concept_id) INTO new_concept_id FROM concept;
  call add_new_concept(@new_concept_id, @concept_name_short_id, @concept_name_full_id, dosage_form_name, dosage_form_name, null, 'N/A', 'Misc', concept_locale_proc, false);
END IF;

 SELECT concept_id INTO drug_concept_id FROM concept_name
 WHERE name = drug_name AND concept_name_type = "FULLY_SPECIFIED" AND locale = concept_locale_proc AND voided = 0;

 SELECT concept_id INTO dosage_form_id FROM concept_name
 WHERE name = dosage_form_name AND concept_name_type = "FULLY_SPECIFIED" AND locale = concept_locale_proc AND voided = 0;

 SELECT count(distinct drug_id) into @drug_count from drug where name = drug_name;
 IF @drug_count > 0 THEN
   SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Drug Already Exists';
 ELSE
   SELECT user_id into user_id_proc FROM users WHERE system_id = "admin";
   INSERT INTO drug (concept_id,name,combination,dosage_form,maximum_daily_dose,minimum_daily_dose,route,creator,date_created,retired,changed_by,date_changed,retired_by,date_retired,retire_reason,uuid,strength) VALUES
   (drug_concept_id,drug_name,0,dosage_form_id,NULL,NULL,NULL,user_id_proc,now(),0,NULL,NULL,NULL,NULL,NULL,uuid(),drug_strength);
 END IF;
END;