CREATE PROCEDURE add_new_concept (INOUT new_concept_id INT,
                             INOUT concept_name_short_id INT,
                             INOUT concept_name_full_id INT,
                             name_of_concept NVARCHAR(255),
                             concept_short_name NVARCHAR(255),
                             concept_description VARCHAR(500),
                             data_type_name VARCHAR(255),
                             class_name VARCHAR(255),
                             locale VARCHAR(11),
                             is_set BOOLEAN)
BEGIN
 DECLARE data_type_id INT;
 DECLARE class_id INT;
 DECLARE is_set_val TINYINT(1);
 DECLARE user_id_proc INT;

 CASE
   WHEN is_set = TRUE THEN
      SET is_set_val = '1';
   WHEN is_set = FALSE THEN
      SET is_set_val = '0';
 END CASE;

 SELECT count(distinct concept_id) into @concept_count from concept_name where name = name_of_concept and concept_name_type='FULLY_SPECIFIED';
 IF @concept_count > 0 THEN
   SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Concept Already Exists';
 ELSE
   SELECT concept_datatype_id INTO data_type_id FROM concept_datatype WHERE name = data_type_name;
   SELECT concept_class_id INTO class_id FROM concept_class WHERE name = class_name;
   SELECT user_id into user_id_proc FROM users WHERE system_id = "admin";

   SELECT uuid() into @uuid;
   INSERT INTO concept (datatype_id, class_id, is_set, creator, date_created, changed_by, date_changed, uuid)
     values (data_type_id, class_id, is_set_val, user_id_proc, now(), 1, now(), @uuid);
   SELECT MAX(concept_id) INTO new_concept_id FROM concept;

   IF concept_short_name IS NOT NULL THEN
   SELECT uuid() into @uuid;
   INSERT INTO concept_name (concept_id, name, locale, locale_preferred, creator, date_created, concept_name_type, uuid)
     values (new_concept_id, concept_short_name, locale, 0, user_id_proc, now(), 'SHORT', @uuid);
   SELECT MAX(concept_name_id) INTO concept_name_short_id FROM concept_name;
   END IF;

   SELECT uuid() into @uuid;
   INSERT INTO concept_name (concept_id, name, locale, locale_preferred, creator, date_created, concept_name_type, uuid)
     values (new_concept_id, name_of_concept, locale, 1, user_id_proc, now(), 'FULLY_SPECIFIED', @uuid);
   SELECT MAX(concept_name_id) INTO concept_name_full_id FROM concept_name;

   IF concept_description IS NOT NULL THEN
   SELECT uuid() into @uuid;
   INSERT INTO concept_description (concept_id,description,locale,creator,date_created,changed_by,date_changed,uuid) VALUES
   (new_concept_id,concept_description,locale,user_id_proc,now(),NULL,NULL,@uuid);
   END IF;
 END IF;
END;