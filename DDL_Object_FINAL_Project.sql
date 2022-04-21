set serveroutput on;
BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                   FROM user_objects
                   WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'MATERIALIZED VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
   FOR cur_rec IN (SELECT * 
                   FROM all_synonyms 
                   WHERE table_owner IN (SELECT USER FROM dual))
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM ' || cur_rec.synonym_name;
      END;
   END LOOP;
END;

/


-- Table: BLOCK_R
CREATE TABLE BLOCK_R (
    BLOCK_INITIATER number(10)  NOT NULL,
    BLOCK_RECEIVER number(10)  NOT NULL,
    CONSTRAINT BLOCK_R_pk PRIMARY KEY (BLOCK_INITIATER,BLOCK_RECEIVER)
) ;

-- Table: CONVERSATION_C
CREATE TABLE CONVERSATION_C (
    CONVERSATION_INITIALIZER number(10)  NOT NULL,
    CONVERSATION_RECEIVER number(10)  NOT NULL,
    TIME_STAMP TIMESTAMP NOT NULL,
    TEXT_MESSAGE clob  NOT NULL,
    CONSTRAINT CONVERSATION_C_pk PRIMARY KEY (CONVERSATION_INITIALIZER,CONVERSATION_RECEIVER,TIME_STAMP)
) ;

-- Table: GENDER_PREFERENCE_U
CREATE TABLE GENDER_PREFERENCE_U (
    GENDER_ID number(10)  NOT NULL,
    USER_ID number(10)  NOT NULL,
    CONSTRAINT GENDER_PREFERENCE_U_pk PRIMARY KEY (GENDER_ID,USER_ID)
) ;

-- Table: GENDER_U
CREATE TABLE GENDER_U (
    GENDER_ID number(10)  NOT NULL,
    GENDER varchar2(10) UNIQUE NOT NULL CHECK(GENDER IN ('MALE','FEMALE'
    ,'TRANS'
    ,'PANGENDER'
    ,'POLYGENDER'
    ,'OTHERS')),
    CONSTRAINT GENDER_U_pk PRIMARY KEY (GENDER_ID)
    
) ;

-- Table: INTERESTED_IN_RELATION_U
CREATE TABLE INTERESTED_IN_RELATION_U (
    USER_ID number(10)  NOT NULL,
    RELATIONSHIP_TYPE_ID number(10)  NOT NULL,
    CONSTRAINT INTERESTED_IN_RELATION_U_pk PRIMARY KEY (USER_ID,RELATIONSHIP_TYPE_ID)
) ;

-- Table: RATING_R
CREATE TABLE RATING_R (
    RATE_INITIATER number(10)  NOT NULL,
    RATE_RECEIVER number(10)  NOT NULL,
    RATE number(2)  NOT NULL CHECK(RATE IN (1,2,3,4,5,6,7,8,9,10)),
    CONSTRAINT RATING_R_pk PRIMARY KEY (RATE_INITIATER,RATE_RECEIVER)
) ;

-- Table: RELATIONSHIP_TYPE_U
CREATE TABLE RELATIONSHIP_TYPE_U (
    RELATIONSHIP_TYPE_ID number(10)  NOT NULL,
    RELATIONSHIP_TYPE varchar2(20)  NOT NULL CHECK(RELATIONSHIP_TYPE IN ('CASUAL'
     ,'SERIOUS'
     ,'COMMITTED'
     ,'NSA'
     ,'NOT SURE')),
    CONSTRAINT RELATIONSHIP_TYPE_U_pk PRIMARY KEY (RELATIONSHIP_TYPE_ID)
) ;

-- Table: USER_DETAIL_U
CREATE TABLE USER_DETAIL_U (
    USER_ID number(10)  NOT NULL,
    GENDER_ID number(10)  NOT NULL,
    LAST_NAME varchar2(50),
    FIRST_NAME varchar2(50)  NOT NULL,
    PHONE_NUMBER number(10)  NOT NULL,
    EMAIL varchar2(100)  NOT NULL,
    REGISTRATION_TIMESTAMP timestamp NOT NULL,
    DATE_OF_BIRTH date  NOT NULL,
    BIO varchar2(400),
    HOBBY varchar2(30),
    HEIGHT number(3),
    CITY varchar2(40)  NOT NULL,
    STATE varchar2(2)  NOT NULL,
    INSTAGRAM_LINK varchar2(500) UNIQUE NOT NULL,
    PASSWORD varchar2(100)  NOT NULL,
    LAST_LOGIN timestamp NOT NULL,
    PASSPORT_NUMBER varchar2(10) UNIQUE NOT NULL,
    MEMBERSHIP_TYPE varchar2(15)  NOT NULL CHECK(MEMBERSHIP_TYPE IN ('FREE','PREMIUM')),
    CONSTRAINT USER_DETAIL_U_pk PRIMARY KEY (USER_ID)
) ;

-- Table: USER_LIKE_U
CREATE TABLE USER_LIKE_U (
    INITIATOR_ID number(10)  NOT NULL,
    RECEIVER_ID number(10)  NOT NULL,
    STATUS number(1)  NOT NULL CHECK(STATUS IN (1,0)),
    CONSTRAINT USER_LIKE_U_pk PRIMARY KEY (RECEIVER_ID,INITIATOR_ID)
) ;

-- Table: USER_PHOTO_U
CREATE TABLE USER_PHOTO_U (
    PHOTO_ID number(10)  NOT NULL,
    USER_ID number(10)  NOT NULL,
    TIME_UPLOADED timestamp  NOT NULL,
    PHOTO_LINK varchar2(500)  NOT NULL,
    CONSTRAINT USER_PHOTO_U_pk PRIMARY KEY (PHOTO_ID)
) ;

-- foreign keys
-- Reference: BLOCK_USER_DETAIL_U (table: BLOCK_R)
ALTER TABLE BLOCK_R ADD CONSTRAINT BLOCK_USER_DETAIL_U
    FOREIGN KEY (BLOCK_RECEIVER)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: BLOCK_USER_DETAIL_U_1 (table: BLOCK_R)
ALTER TABLE BLOCK_R ADD CONSTRAINT BLOCK_USER_DETAIL_U_1
    FOREIGN KEY (BLOCK_INITIATER)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: CONVERSATION_C_USER_DETAIL_U (table: CONVERSATION_C)
ALTER TABLE CONVERSATION_C ADD CONSTRAINT CONVERSATION_C_USER_DETAIL_U
    FOREIGN KEY (CONVERSATION_INITIALIZER)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: CONVERSATION_C_USER_DETAIL_U_1 (table: CONVERSATION_C)
ALTER TABLE CONVERSATION_C ADD CONSTRAINT CONVERSATION_C_USER_DETAIL_U_1
    FOREIGN KEY (CONVERSATION_RECEIVER)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: GENDER_PREFERENCE_U_GENDER_U (table: GENDER_PREFERENCE_U)
ALTER TABLE GENDER_PREFERENCE_U ADD CONSTRAINT GENDER_PREFERENCE_U_GENDER_U
    FOREIGN KEY (GENDER_ID)
    REFERENCES GENDER_U (GENDER_ID);

-- Reference: GENDER_PREFERENCE_U_U_1 (table: GENDER_PREFERENCE_U)
ALTER TABLE GENDER_PREFERENCE_U ADD CONSTRAINT GENDER_PREFERENCE_U_U_1
    FOREIGN KEY (USER_ID)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: INTERESTED_IN_RELATION_U_USER_DETAIL_U (table: INTERESTED_IN_RELATION_U)
ALTER TABLE INTERESTED_IN_RELATION_U ADD CONSTRAINT INTERESTED_IN_RELATION_U_USER_DETAIL_U
    FOREIGN KEY (USER_ID)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: RATING_USER_DETAIL_U (table: RATING_R)
ALTER TABLE RATING_R ADD CONSTRAINT RATING_USER_DETAIL_U
    FOREIGN KEY (RATE_RECEIVER)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: RATING_USER_DETAIL_U_1 (table: RATING_R)
ALTER TABLE RATING_R ADD CONSTRAINT RATING_USER_DETAIL_U_1
    FOREIGN KEY (RATE_INITIATER)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: RELATIONSHIP_TYPE_INTERESTED_IN_RELATION_U (table: INTERESTED_IN_RELATION_U)
ALTER TABLE INTERESTED_IN_RELATION_U ADD CONSTRAINT RELATIONSHIP_TYPE_INTERESTED_IN_RELATION_U
    FOREIGN KEY (RELATIONSHIP_TYPE_ID)
    REFERENCES RELATIONSHIP_TYPE_U (RELATIONSHIP_TYPE_ID);

-- Reference: USER_DETAIL_U_GENDER_U (table: USER_DETAIL_U)
ALTER TABLE USER_DETAIL_U ADD CONSTRAINT USER_DETAIL_U_GENDER_U
    FOREIGN KEY (GENDER_ID)
    REFERENCES GENDER_U (GENDER_ID);

-- Reference: USER_DETAIL_U_USER_LIKE_U (table: USER_LIKE_U)
ALTER TABLE USER_LIKE_U ADD CONSTRAINT USER_DETAIL_U_USER_LIKE_U
    FOREIGN KEY (RECEIVER_ID)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: USER_DETAIL_U_USER_LIKE_U_2 (table: USER_LIKE_U)
ALTER TABLE USER_LIKE_U ADD CONSTRAINT USER_DETAIL_U_USER_LIKE_U_2
    FOREIGN KEY (INITIATOR_ID)
    REFERENCES USER_DETAIL_U (USER_ID);

-- Reference: USER_PHOTO_U_USER_DETAIL_U (table: USER_PHOTO_U)
ALTER TABLE USER_PHOTO_U ADD CONSTRAINT USER_PHOTO_U_USER_DETAIL_U
    FOREIGN KEY (USER_ID)
    REFERENCES USER_DETAIL_U (USER_ID);

/
CREATE PROCEDURE grant_select(
    username VARCHAR2, 
    grantee VARCHAR2)
AS   
BEGIN
    FOR r IN (
        SELECT owner, table_name 
        FROM all_tables 
        WHERE owner = username
    )
    LOOP
        EXECUTE IMMEDIATE 
            'GRANT ALL ON '||r.owner||'.'||r.table_name||' to ' || grantee;
    END LOOP;
END; 
/
EXECUTE grant_select('ADMIN_DATING_APP','DATA_OPERATOR');
EXECUTE grant_select('ADMIN_DATING_APP','USER_DATING_APP');
/
DECLARE
count_s number;
begin
select count(*) into count_s from user_sequences where sequence_name =upper('user_id_seq'); 
IF (count_s = 0) then
EXECUTE IMMEDIATE 'CREATE SEQUENCE user_id_seq
 START WITH     1
 INCREMENT BY   1
 MAXVALUE  9999999999
 NOCACHE
 NOCYCLE';
ELSE 
EXECUTE IMMEDIATE 'DROP SEQUENCE user_id_seq';
EXECUTE IMMEDIATE 'CREATE SEQUENCE user_id_seq
 START WITH     1
 INCREMENT BY   1
 MAXVALUE  9999999999
 NOCACHE
 NOCYCLE';
END IF;
END;
/
DECLARE
count_s number;
begin
select count(*) into count_s from user_sequences where sequence_name =upper('photo_id_seq'); 
IF (count_s = 0) then
EXECUTE IMMEDIATE 'CREATE SEQUENCE photo_id_seq
 START WITH     1
 INCREMENT BY   1
 MAXVALUE  9999999999
 NOCACHE
 NOCYCLE';
ELSE 
EXECUTE IMMEDIATE 'DROP SEQUENCE photo_id_seq';
EXECUTE IMMEDIATE 'CREATE SEQUENCE photo_id_seq
 START WITH     1
 INCREMENT BY   1
 MAXVALUE  9999999999
 NOCACHE
 NOCYCLE';
END IF;
END;
/

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


create or replace procedure insert_photo(email_initiator IN varchar2, password_initiator IN varchar2,photolink in varchar) 

is

userid_initiator number;
photo_id_unique number;
photo_id_uniqueEx exception;
photo_count number;
begin
userid_initiator := get_user_id(email_initiator,password_initiator);
select count(*) into photo_count from  USER_PHOTO_U where user_id = userid_initiator;
if photo_count < 5 THEN
merge into USER_PHOTO_U u using sys.dual on (u.user_id = userid_initiator and u.photo_link = photolink)
WHEN NOT MATCHED THEN INSERT(photo_id,user_id,time_uploaded,photo_link)
VALUES(photo_id_seq.NEXTVAL,userid_initiator,sysdate,photolink);
commit;
END if;

END;
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
merge into GENDER_PREFERENCE_U u using sys.dual on (u.user_id = userid and u.gender_id = GENDERID)
WHEN NOT MATCHED THEN INSERT(user_id,gender_id)
VALUES(userid,GENDERID);
commit;
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
merge into INTERESTED_IN_RELATION_U u using sys.dual on (u.user_id = userid and u.relationship_type_id = RELATIONID)
WHEN NOT MATCHED THEN INSERT(user_id,relationship_type_id)
VALUES(userid,RELATIONID);
commit;
END;
/

CREATE OR REPLACE
PROCEDURE insert_user_primary(gender_i IN varchar2,last_name_i IN varchar2,
first_name_i IN varchar2,phone_number_i IN number,email_i IN varchar2,
dob_i IN date,bio_i in varchar2,hobby_i in varchar2,
height_i in number,city_i in varchar2,state_i in varchar2,
iglink_i in varchar2,last_login_i in date,password_i in varchar2,passport_number_i in varchar2)
IS
gender_id_val number;
BEGIN
gender_id_val := gender_id_name(gender_i);
merge into admin_dating_app.USER_DETAIL_U u using sys.dual on (u.email = upper(email_i) OR u.PASSPORT_NUMBER = upper(passport_number_i) OR u.instagram_link = upper(iglink_i) )
WHEN NOT MATCHED THEN INSERT(user_id,gender_id,last_name,first_name,phone_number,email,REGISTRATION_TIMESTAMP,DATE_OF_BIRTH,bio,hobby,height,city,state,INSTAGRAM_LINK,PASSWORD,last_login,PASSPORT_NUMBER,membership_type)
VALUES(user_id_seq.NEXTVAL,gender_id_val,last_name_i,first_name_i,phone_number_i,email_i,sysdate,dob_i,bio_i,hobby_i,height_i,city_i,state_i,upper(iglink_i),password_i,last_login_i,upper(passport_number_i),'FREE');
 
COMMIT;
END;
/
create or replace procedure insert_like(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2) 
is
userid_initiator number;
userid_receiver number;
begin
userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
merge into user_like_u u using sys.dual on (u.initiator_id = userid_initiator and u.receiver_id = userid_receiver)
WHEN NOT MATCHED THEN INSERT(initiator_id,receiver_id,status)
VALUES(userid_initiator,userid_receiver,1);
commit;
end;
/

create or replace procedure insert_rating(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2, val IN number) 

is

userid_initiator number;
userid_receiver number;

begin

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
merge into RATING_R R using sys.dual on (R.RATE_INITIATER = userid_initiator and R.RATE_RECEIVER = userid_receiver)
WHEN NOT MATCHED THEN INSERT(RATE_INITIATER,RATE_RECEIVER,RATE)
VALUES(userid_initiator,userid_receiver,val);
commit;
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

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
merge into BLOCK_R B using sys.dual on (B.BLOCK_INITIATER = userid_initiator and B.BLOCK_RECEIVER = userid_receiver)
WHEN NOT MATCHED THEN INSERT(BLOCK_INITIATER,BLOCK_RECEIVER)
VALUES(userid_initiator,userid_receiver);
COMMIT;
end;
/
create or replace procedure insert_conversation(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2,text_message in clob)
is

userid_initiator number;
userid_receiver number;
begin
userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
INSERT INTO CONVERSATION_C (CONVERSATION_INITIALIZER,CONVERSATION_RECEIVER,TIME_STAMP,TEXT_MESSAGE)
VALUES(userid_initiator,userid_receiver,sysdate,text_message);
commit;
end;
/

GRANT EXECUTE ON INSERT_PHOTO TO USER_DATING_APP;


GRANT EXECUTE ON INSERT_GENDER_PREFERENCE TO USER_DATING_APP;


GRANT EXECUTE ON INSERT_RELATIONSHIP_TYPE TO USER_DATING_APP;


GRANT EXECUTE ON INSERT_USER_PRIMARY TO USER_DATING_APP;


GRANT EXECUTE ON INSERT_LIKE TO USER_DATING_APP;


GRANT EXECUTE ON INSERT_RATING TO USER_DATING_APP;


GRANT EXECUTE ON INSERT_BLOCK TO USER_DATING_APP;

GRANT EXECUTE ON INSERT_CONVERSATION TO USER_DATING_APP;

/
commit;
/
