CREATE PROCEDURE add_new_service_availability (service_name VARCHAR(255),
                             day_of_week VARCHAR(45),
                             start_time TIME,
                             end_time TIME,
                             max_appointments_limit INT(11))


BEGIN
 DECLARE user_id_proc INT;
 DECLARE appointment_service_id_proc INT;

 SELECT user_id into user_id_proc FROM users WHERE system_id = "admin";

 IF service_name IS NULL
    THEN
      SET appointment_service_id_proc = NULL;
    ELSE
      SELECT appointment_service_id INTO appointment_service_id_proc FROM appointment_service
      WHERE name = service_name AND voided = 0;
  END IF;

 IF appointment_service_id_proc IS NOT NULL
  THEN
   INSERT INTO appointment_service_weekly_availability(service_id,day_of_week,start_time,end_time,max_appointments_limit,uuid,voided,voided_by,date_voided,void_reason,date_created,creator)
   VALUES (appointment_service_id_proc,day_of_week,start_time,end_time,NULL,uuid(),0,NULL,NULL,NULL,now(),user_id_proc);
 END IF;

END;