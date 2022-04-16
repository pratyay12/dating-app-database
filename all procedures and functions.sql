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

-- Function to get the Relationship type ID --
CREATE OR REPLACE FUNCTION relation_id_name(relation_i IN varchar2)
RETURN number
IS
relation_id_value number;
BEGIN
select relationship_type_ID into relation_id_value from RELATIONSHIP_TYPE_U  where relationship_type = relation_i;
RETURN relation_id_value;
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


create or replace procedure insert_photo(email_initiator IN varchar2, password_initiator IN varchar2, photoID in number, timeuploaded in timestamp, photolink in varchar) 

is

userid_initiator number;
photo_id_unique number;
photo_id_uniqueEx exception;


begin

userid_initiator := get_user_id(email_initiator,password_initiator);


select count(*) into photo_id_unique from USER_PHOTO_U where PHOTO_ID = photoid;



if (photo_id_unique > 0)
then raise photo_id_uniqueEx;

else
insert into USER_PHOTO_U(PHOTO_ID,
    USER_ID,time_uploaded,photo_link) 
values(photoid,userid_initiator,
    timeuploaded,photolink);

end if;

exception

when photo_id_uniqueEx then
raise_application_error (-20011,'Photo ID Should be Unique');


end;
/

create or replace procedure insert_gender_preference(email_value IN varchar2, password_value IN varchar2, preference IN varchar2) 

is

userid number;
GENDERID number;
user_id_gender_id_uniqueEx exception;
user_id_gender_id_unique number;


begin

userid := get_user_id(email_value,password_value);
GENDERID := gender_id_name(preference);

select count(*) into user_id_gender_id_unique from GENDER_PREFERENCE_U where user_id = userid and GENDER_ID = genderid;



if (user_id_gender_id_unique > 0)
then raise user_id_gender_id_uniqueEx;

else
insert into GENDER_PREFERENCE_U(USER_ID,
    GENDER_ID) 
values(USERID,
    GENDERID);

end if;

exception

when user_id_gender_id_uniqueEx then
raise_application_error (-20010,'USER ID and gender id combination Should be Unique');


end;
/

create or replace procedure insert_relationship_type(email_value IN varchar2, password_value IN varchar2, preference IN varchar2) 

is

userid number;
RELATIONID number;
user_id_relation_id_uniqueEx exception;
user_id_relation_id_unique number;


begin

userid := get_user_id(email_value,password_value);
RELATIONID := relation_id_name(preference);

select count(*) into user_id_relation_id_unique from interested_in_relation_u where user_id = userid and relationship_type_ID = RELATIONID;



if (user_id_relation_id_unique > 0)
then raise user_id_relation_id_uniqueEx;

else
insert into interested_in_relation_u(USER_ID,
    relationship_type_ID) 
values(USERID,
    RELATIONID);

end if;

exception

when user_id_relation_id_uniqueEx then
raise_application_error (-20012,'USER ID and relation type id combination Should be Unique');


end;
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

create or replace procedure insert_like(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2, val IN varchar2) 

is

userid_initiator number;
userid_receiver number;
initiator_id_receiver_id_unique number;
initiator_id_receiver_id_uniqueEx exception;


begin

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);


select count(*) into initiator_id_receiver_id_unique from USER_LIKE_U where initiator_id = userid_initiator and receiver_id = userid_receiver;



if (initiator_id_receiver_id_unique > 0)
then raise initiator_id_receiver_id_uniqueEx;

else
insert into USER_LIKE_U(INITIATOR_ID,
    RECEIVER_ID,
    STATUS) 
values(userid_initiator,
    userid_receiver,
    val);

end if;

exception

when initiator_id_receiver_id_uniqueEx then
raise_application_error (-20010,'INITIATOR ID and RECEIVER ID combination Should be Unique');


end;
/

create or replace procedure insert_rating(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2, val IN varchar2) 

is

userid_initiator number;
userid_receiver number;
initiator_id_receiver_id_unique number;
initiator_id_receiver_id_uniqueEx exception;


begin

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);


select count(*) into initiator_id_receiver_id_unique from RATING_R where RATE_INITIATER = userid_initiator and RATE_RECEIVER = userid_receiver;



if (initiator_id_receiver_id_unique > 0)
then raise initiator_id_receiver_id_uniqueEx;

else
insert into RATING_R(RATE_INITIATER,
    RATE_RECEIVER,
    RATE) 
values(userid_initiator,
    userid_receiver,
    val);

end if;

exception

when initiator_id_receiver_id_uniqueEx then
raise_application_error (-20010,'INITIATOR ID and RECEIVER ID combination Should be Unique');


end;
/

create or replace procedure insert_block(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2) 

is

userid_initiator number;
userid_receiver number;
initiator_id_receiver_id_unique number;
initiator_id_receiver_id_uniqueEx exception;


begin

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);


select count(*) into initiator_id_receiver_id_unique from BLOCK_R where BLOCK_INITIATER = userid_initiator and BLOCK_RECEIVER = userid_receiver;



if (initiator_id_receiver_id_unique > 0)
then raise initiator_id_receiver_id_uniqueEx;

else
insert into BLOCK_R(BLOCK_INITIATER,
    BLOCK_RECEIVER) 
values(userid_initiator,
    userid_receiver);

end if;

exception

when initiator_id_receiver_id_uniqueEx then
raise_application_error (-20010,'INITIATOR ID and RECEIVER ID combination Should be Unique');


end;
/


