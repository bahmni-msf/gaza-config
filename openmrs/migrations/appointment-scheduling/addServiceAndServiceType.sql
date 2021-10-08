CREATE PROCEDURE add_new_service_and_service_type(service_name VARCHAR(255),
                             service_description VARCHAR(255),
                             service_start_time TIME,
                             service_color VARCHAR(255),
                             service_duration INT(11),
                             service_location_name VARCHAR(255),
                             service_type_name VARCHAR(255),
                             service_type_duration INT(11)
                        )

BEGIN
 DECLARE user_id_proc INT;
 DECLARE appointment_service_id_proc INT;
 DECLARE service_location_id INT;
 DECLARE service_type_id INT;
 DECLARE appointment_service_count INT;
 DECLARE appointment_service_type_count INT;


  SELECT user_id into user_id_proc FROM users WHERE system_id = "admin";

  IF service_location_name IS NULL
  THEN
    SET service_location_id = NULL;
  ELSE
    SELECT location_id INTO service_location_id FROM location
    WHERE name = service_location_name AND retired = 0;
  END IF;

  SELECT count(distinct appointment_service_id) into @appointment_service_count from appointment_service WHERE name = service_name AND voided = 0;
  IF @appointment_service_count = 0 THEN
     INSERT INTO appointment_service (name,description,start_time,end_time,location_id,speciality_id,max_appointments_limit,duration_mins,color,date_created,creator,date_changed,changed_by,voided,voided_by,date_voided,void_reason,uuid) VALUES
     (service_name,service_description,service_start_time,NULL,service_location_id,NULL,NULL,service_duration,service_color,now(),user_id_proc,now(),user_id_proc,0,NULL,NULL,NULL,uuid());
  END IF;

   IF service_name IS NULL
    THEN
      SET appointment_service_id_proc = NULL;
    ELSE
      SELECT appointment_service_id INTO appointment_service_id_proc FROM appointment_service
      WHERE name = service_name AND voided = 0;
  END IF;

 SELECT count(distinct appointment_service_type_id) into @appointment_service_type_count from appointment_service_type WHERE name = service_type_name AND appointment_service_id = appointment_service_id_proc AND voided = 0;
 IF @appointment_service_type_count > 0 THEN
   SIGNAL SQLSTATE '45000'
   SET MESSAGE_TEXT = 'Appointment Service Already Exists';
 ELSEIF service_type_name IS NOT NULL THEN
   INSERT INTO appointment_service_type (appointment_service_id,name,duration_mins,date_created,creator,date_changed,changed_by,voided,voided_by,date_voided,void_reason,uuid) VALUES
   (appointment_service_id_proc,service_type_name,service_type_duration,now(),user_id_proc,now(),user_id_proc,0,NULL,NULL,NULL,uuid());
 END IF;

END;


