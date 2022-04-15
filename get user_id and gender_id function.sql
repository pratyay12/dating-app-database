-- Function to get the Gender ID --
CREATE OR REPLACE FUNCTION gender_id_name(gender_i IN varchar2)
RETURN number
IS
gender_id_value number;
BEGIN
select gender_id into gender_id_value from GENDER_U  where gender = gender_i;
RETURN gender_id_value;
END;
/

-- Function to get the USER ID --

CREATE OR REPLACE FUNCTION get_user_id(email_value IN varchar2, password_value IN varchar2)
RETURN number
IS
user_id_value number;
BEGIN
select user_id into user_id_value from user_detail_u  where email_value = email and password_value=password;
RETURN user_id_value;
END;
/

-- Function to get the USER ID without password --

CREATE OR REPLACE FUNCTION get_user_id_wp(email_value IN varchar2)
RETURN number
IS
user_id_value number;
BEGIN
select user_id into user_id_value from user_detail_u  where email_value = email;
RETURN user_id_value;
END;
/