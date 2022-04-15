set SERVEROUTPUT on;

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

create or replace procedure insert_new_user(USERID number,
    GENDER VARCHAR2,
    LAST_NAME varchar2,
    FIRST_NAME varchar2,
    PHONENUMBER number,
    EMAIL_ varchar2,
    REGISTRATION_TIMESTAMP timestamp,
    DATE_OF_BIRTH date,
    BIO varchar2,
    HOBBY varchar2,
    HEIGHT number,
    CITY varchar2,
    STATE varchar2,
    INSTAGRAMLINK varchar2,
    PASSWORD varchar2,
    LAST_LOGIN timestamp,
    PASSPORTNUMBER varchar2,
    MEMBERSHIP_TYPE varchar2) 

is

user_id_unique number;
GENDERID number;
user_id_uniqueEx exception;
phone_unique number;
phone_uniqueEx exception;
email_unique number;
email_uniqueEx exception;
ig_link_unique number;
ig_link_uniqueEx exception;
passport_unique number;
passport_uniqueEx exception;

begin

select count(*) into user_id_unique from user_detail_u where user_id = userid;
select count(*) into phone_unique from user_detail_u where PHONE_NUMBER = PHONENUMBER;
select count(*) into email_unique from user_detail_u where email = email_;
select count(*) into ig_link_unique from user_detail_u where INSTAGRAM_LINK = INSTAGRAMLINK;
select count(*) into passport_unique from user_detail_u where PASSPORT_NUMBER = PASSPORTNUMBER;
GENDERID := gender_id_name(gender);


if
(user_id_unique > 0)
then raise user_id_uniqueEx;

elsif
(phone_unique >0)
then raise phone_uniqueEx;

elsif
(email_unique > 0)
then raise email_uniqueEx;

elsif
(ig_link_unique > 0)
then raise ig_link_uniqueEx;

elsif
(passport_unique > 0)
then raise passport_uniqueEx;

else
insert into user_detail_u(USER_ID,
    GENDER_ID,
    LAST_NAME,
    FIRST_NAME,
    PHONE_NUMBER,
    EMAIL,
    REGISTRATION_TIMESTAMP,
    DATE_OF_BIRTH,
    BIO,
    HOBBY,
    HEIGHT,
    CITY,
    STATE,
    INSTAGRAM_LINK,
    PASSWORD ,
    LAST_LOGIN,
    PASSPORT_NUMBER,
    MEMBERSHIP_TYPE) 
values(USERID,
    GENDERID,
    LAST_NAME,
    FIRST_NAME,
    PHONENUMBER,
    EMAIL_,
    REGISTRATION_TIMESTAMP,
    DATE_OF_BIRTH,
    BIO,
    HOBBY,
    HEIGHT,
    CITY,
    STATE,
    INSTAGRAMLINK,
    PASSWORD ,
    LAST_LOGIN,
    PASSPORTNUMBER,
    MEMBERSHIP_TYPE);

end if;

exception

when user_id_uniqueEx then
raise_application_error (-20005,'USER ID Should be Unique');

when phone_uniqueEx then
raise_application_error (-20006,'Phone Number Should be Unique');

when email_uniqueEx then
raise_application_error (-20007, 'Email Should be Unique');

when ig_link_uniqueEx then
raise_application_error (-20008, 'IG_Link Should be Unique');

when passport_uniqueEx then
raise_application_error (-20009, 'Passport Number Should be Unique');

end;
/


CREATE SEQUENCE USER_ID_SEQ
    INCREMENT BY 1
    START WITH 1000000000
    MINVALUE 1000000000
    MAXVALUE 9999999999
    CACHE 20;



    
exec insert_new_user(USER_ID_SEQ.nextval, 'male', 'Patel', 'Raj', 8572505548, 'abcd@gmail.com',CURRENT_TIMESTAMP, '12-DEC-98', 'BIO', 'HOBBY', 6.0, 'Boston', 'MA', 'IG_LINK4.COM', 'PASSWORD1', CURRENT_TIMESTAMP, 'M9523456','TYPE1');


DROP SEQUENCE USER_ID_SEQ;
