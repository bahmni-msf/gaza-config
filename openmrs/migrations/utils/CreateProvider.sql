CREATE PROCEDURE create_provider (user_gender VARCHAR(50),user_given_name VARCHAR(50),user_family_name VARCHAR(50),user_username varchar(50))
  BEGIN
    SET @puuid = uuid();
    SET @user_password = (SELECT password from users where username="superman");
    SET @user_salt = (SELECT salt from users where username="superman");
    INSERT INTO person (gender, creator, date_created, uuid) VALUES (user_gender, 1, now(), @puuid);
    INSERT INTO person_name (person_id, given_name, family_name,creator, date_created, uuid) VALUES ((SELECT max(person_id) FROM person),user_given_name,user_family_name,1, now(), @puuid);
    INSERT INTO users (system_id, username, password, salt, creator, date_created, changed_by, person_id,retired,uuid)
     VALUES (user_username, user_username, @user_password, @user_salt, 1,now(),1,(SELECT max(person_id) FROM person),0,@puuid);
    INSERT INTO user_role VALUES ((select max(user_id) from users),'Appointments:ManageAppointments'), ((select max(user_id) from users),'Appointments:ReadOnly'), ((select max(user_id) from users),'Registration-App-Read-Only') , ((select max(user_id) from users),'Programs-App');
    INSERT INTO user_property values ((select max(user_id) from users),'forcePassword','true');
    INSERT INTO provider (person_id, identifier,creator, date_created, retired, uuid)VALUES ((SELECT max(person_id) FROM person),user_username,1,now(),0,@puuid);
    INSERT INTO provider_attribute (provider_id,attribute_type_id, value_reference, uuid,creator,date_created)VALUES ((SELECT max(provider_id) FROM provider),1,"true",@puuid,1,now());
  END;