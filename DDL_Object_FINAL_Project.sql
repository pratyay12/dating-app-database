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
set serveroutput on;
DECLARE
count_s number;
begin
select count(*) into count_s from user_sequences where sequence_name =upper('gender_id_seq'); 
IF (count_s = 0) then
EXECUTE IMMEDIATE 'CREATE SEQUENCE gender_id_seq
 START WITH     1
 INCREMENT BY   1
 MAXVALUE  9999999999
 NOCACHE
 NOCYCLE';
ELSE 
EXECUTE IMMEDIATE 'DROP SEQUENCE gender_id_seq';
EXECUTE IMMEDIATE 'CREATE SEQUENCE gender_id_seq
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
select count(*) into count_s from user_sequences where sequence_name =upper('relation_type_id_seq'); 
IF (count_s = 0) then
EXECUTE IMMEDIATE 'CREATE SEQUENCE relation_type_id_seq
 START WITH     1
 INCREMENT BY   1
 MAXVALUE  9999999999
 NOCACHE
 NOCYCLE';
ELSE 
EXECUTE IMMEDIATE 'DROP SEQUENCE relation_type_id_seq';
EXECUTE IMMEDIATE 'CREATE SEQUENCE relation_type_id_seq
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
CREATE OR REPLACE
PROCEDURE insert_gender(gender_i IN varchar2) 
IS
INVALID_GENDER_NAME EXCEPTION;
NUMBER_GENDER_NAME EXCEPTION;
INVALID_LENGTH_GENDER EXCEPTION;
--GENDER_ALREADY_EXISTS EXCEPTION;
BEGIN 
IF gender_i is NULL or gender_i = '' THEN
    RAISE INVALID_GENDER_NAME;
ELSIF (VALIDATE_CONVERSION(gender_i AS NUMBER) = 1) THEN
    RAISE NUMBER_GENDER_NAME;
ELSIF LENGTH(gender_i) > 10 THEN
    RAISE INVALID_LENGTH_GENDER;
ELSE
merge into admin_dating_app.GENDER_U g using sys.dual on (g.GENDER = upper(gender_i))
   when not matched then insert (g.gender_id,g.gender) values (gender_id_seq.NEXTVAL,upper(gender_i));
 --  when matched then RAISE GENDER_ALREADY_EXISTS;
END IF;
COMMIT;
dbms_output.put_line(' ');
FOR i in (SELECT * FROM admin_dating_app.GENDER_U ORDER BY gender_id) LOOP
    dbms_output.put_line('     ' || i.gender_id || ' ' || i.gender);
END LOOP; 
dbms_output.put_line(' ');
EXCEPTION 
WHEN INVALID_GENDER_NAME THEN
dbms_output.put_line('Invalid Gender Name');
WHEN NUMBER_GENDER_NAME THEN
dbms_output.put_line('Gender Name is a Number');
WHEN INVALID_LENGTH_GENDER THEN
 dbms_output.put_line('Invalid Length of Gender');
END;
/
exec insert_gender('Male');
exec insert_gender('Female');
exec insert_gender('Trans');
exec insert_gender('Pangender'); 
exec insert_gender('Polygender'); 
exec insert_gender('Others');
/
CREATE OR REPLACE
PROCEDURE insert_relationship(relation_i IN varchar2) 
IS
INVALID_RELATION_NAME EXCEPTION;
NUMBER_RELATION_NAME EXCEPTION;
INVALID_LENGTH_RELATION EXCEPTION;
--GENDER_ALREADY_EXISTS EXCEPTION;
BEGIN 
IF relation_i is NULL or relation_i = '' THEN
    RAISE INVALID_RELATION_NAME;
ELSIF (VALIDATE_CONVERSION(relation_i AS NUMBER) = 1) THEN
    RAISE NUMBER_RELATION_NAME;
ELSIF LENGTH(relation_i) > 20 THEN
    RAISE INVALID_LENGTH_RELATION;
ELSE
merge into admin_dating_app.RELATIONSHIP_TYPE_U r using sys.dual on (r.relationship_type = upper(relation_i))
   when not matched then insert (r.relationship_type_id,r.relationship_type) values (relation_type_id_seq.NEXTVAL,upper(relation_i));
 --  when matched then RAISE GENDER_ALREADY_EXISTS;
END IF;
COMMIT;
dbms_output.put_line(' ');
FOR i in (SELECT * FROM admin_dating_app.RELATIONSHIP_TYPE_U ORDER BY relationship_type_id) LOOP
    dbms_output.put_line('     ' || i.relationship_type_id || ' ' || i.relationship_type);
END LOOP; 
dbms_output.put_line(' ');
EXCEPTION 
WHEN INVALID_RELATION_NAME THEN
dbms_output.put_line('Invalid Relation Name');
WHEN NUMBER_RELATION_NAME THEN
dbms_output.put_line('Relation Name is a Number');
WHEN INVALID_LENGTH_RELATION THEN
 dbms_output.put_line('Invalid Length of Relation Type');
END;
/
exec insert_relationship('Casual');
exec insert_relationship('Serious');
exec insert_relationship('Committed');
exec insert_relationship('NSA'); 
exec insert_relationship('Not Sure'); 
/
COMMIT;
/
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE','Sharma','Rohan',5046218927,'rohansharma@gmail.com','23-Jan-1989','I love HP','Cycling','165','Boston','MA','gdghsgwyuab.com',SYSDATE + 10,'password123','234FD5TF01');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE','Butt','James',8102929388,'buttjames@gmail.com','28-Feb-1999','I am from NYC','3D printing','173','New Orleans','LA','aidygqwf.com',SYSDATE + 15,'1980290','758FE2IJ02');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS','Darakjy','Josephine',8566368749,'josephine_darakjy@darakjy.org','01-Nov-1992','Hey how are you','amateur radio','167','Brighton','MI','hgdgqwkf.com',SYSDATE + 30,'tornadof','300AS2UN03');											
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER','Venere','Art',9073854412,'art@venere.org','11-Dec-1994','I am from into singing','scrapbook','180','Bridgeport','NJ','qudqwfqff.com',SYSDATE + 35,'vova87654','196DF3TH04');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER','Paprocki','Lenna',5135701893,'lpaprocki@hotmail.com','23-Jan-1989','I love ice-cream','Amateur radio','163','Anchorage','AK','wyfqiwvfqf.com',SYSDATE + 12,'XpKvShrO','786VG2UJ05');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS','Foller','Donette',4195032484,'donette.foller@cox.net','28-Feb-1999','Love Indian Food','Acting','165','Hamilton','OH','qiuetif.com',SYSDATE + 9,'QuieaX','729BN7GC06');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE','Morasca','Simona',7735736914,'simona@morasca.com','01-Nov-1992','I am into metalicca','Baton twirling','172','Ashland','OH','sdgiadj.com',SYSDATE + 17,'stava1','299MQ8DI07');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE','Tollner','Mitsue',4087523500,'mitsue_tollner@yahoo.com','11-Dec-1994','I like baseball','Board games','182','Chicago','IL','uigfjkffqw.com',SYSDATE + 1,'keannn','289GB9AS08');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS','Dilliard','Leota',6054142147,'leota@hotmail.com','23-Jan-1989','I love movies','Book restoration','174','San Jose','CA','tyqhqwvff.com',SYSDATE + 14,'xoPTDK','832SS0UA09');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER','Wieser','Sage',4106558723,'sage_wieser@cox.net','28-Feb-1999','I love music','Cabaret','172','Sioux Falls','SD','jdfwqjhvfqw.com', SYSDATE + 20,'supagordon','204NA5IL10');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER','Marrier','Kris',2158741229,'kris@gmail.com','01-Nov-1992','I am a big fan of DeNiro','Calligraphy','178','Baltimore','MD','sadgffjf.com',SYSDATE + 12,'XQyz7B4c8','122GA6YT11');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS','Amigon','Minna',6313353414,'minna_amigon@yahoo.com','23-Jan-1989','I am into metallica Love Indian Food','Candle making',	'167',	'Kulpsville','PA','gygdd.com', SYSDATE + 17,'gOeJio','653TA7UY12');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE','Maclead','Abel', 3104985651,'amaclead@gmail.com',	'28-Feb-1999','I am into metallica',	'Computer programming',	'166'	,'Middle Island'	,'NY'	,'ttqbhbba.com', SYSDATE + 25	,'xor59him',	'657YU7FG13');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE','Caldarera'	,'Kiley',4407808425,'kiley.caldarera@aol.com','01-Nov-1992','I like baseball'	,'Coffee roasting'	,'165',	'Los Angeles'	,'CA',	'wqftydfqwd.com', SYSDATE + 10,	'ZyKDmjR5f',	'863SB9KL14');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS','Ruta','Graciela',9565376195	,'gruta@cox.net',	'11-Dec-1994',	'I love movies	Cooking','Computer programming',	'183'	,'Chagrin Falls'	,'OH','wytdfqd.com', SYSDATE + 23,	'mroads',	'988LK9BL15'	);									
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER','Albares','Cammy',6022774385,	'calbares@gmail.com','23-Jan-1989',	'I love music',	'Coloring',	'181'	,'Laredo',	'TX','qrytqfw.com', SYSDATE + 12,	'vbl666ufhl',	'423XC8TD16');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER' ,'Poquette','Mattie',9313139635,	'mattie@aol.com','28-Feb-1999'	,'I am a big fan of DeNiro','Cosplaying','182',	'Phoenix',	'AZ','khjbwqd.com' ,SYSDATE + 20,'9533207',	'612CS4HD17');												
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS','Garufi','Meaghan',4146619598,'meaghan@hotmail.com',	'01-Nov-1992',	'Love Indian Food',	'Couponing'	,'181',	'Mc Minnville',	'TN',	'tdghcb.com' ,SYSDATE + 7	,'nrokkorn','635JA8AB18')	;											
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE','Rim','Gladys',3132887937,'gladys.rim@rim.org','11-Dec-1994','I am into metallica'	,'Creative writing'	,'165',	'Milwaukee','WI',	'tfghwqwh.com', SYSDATE + 6, 'yBYlIRUje','195LD0VS19');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE'    ,	'Whobrey', 'Yuki',	8158282147	,'yuki_whobrey@aol.com' , 	'23-Jan-1989',	'I like baseball',	'Crocheting',	'178'	,'Taylor',	'MI',	'wesgfcj.com' ,SYSDATE + 3,'YbR4859','675BA9RD20');	
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS'     ,	'Flosi' ,'Fletcher',6105453615 ,'fletcher.flosi@yahoo.com' ,	'28-Feb-1999',	'I love movies',	'Cryptography',	'181'	,'Rockford',	'IL',	'tfdhwqjd.com' ,SYSDATE+14 , 'canyon59', '459CC7TY21')	;	
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER' , 'Nicka' ,'Bettte',	4085401785 ,'bette_nicka@cox.net'		,'01-Nov-1992'	,'I love music',	'Dance'	,'184',	'Aston','PA','tygvjhyu.com' ,SYSDATE+9 	,'waltdawg' 			,'012XF8XC22');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER',	'Inouye' ,'Veronica', 	9723039197,	'vinouye@aol.com',	'23-Jan-1989',	'I am a big fan of DeNiro',	'Digital arts',	'182','San Jose',	'CA',	'dhwvjhwev.com' ,SYSDATE+15 ,'ybnf101208',		'458DH1JD23')	;	
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS'    ,	'Kolmetz' ,'Willard',	5189667987, 'willard@hotmail.com',		'28-Feb-1999'	,'Love Indian Food',	'Drama'	,'178',	'Irving',	'TX','dwfdfqwhdv.com'	 ,SYSDATE+8, 'XjjQSlN516'	,		'731KJ5TF24')	;
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE'      ,	'Royster' ,'Maryann',	7326583154,	'mroyster@royster.com',	'01-Nov-1992',	'I am into metallica'	,'Drawing',	'182'	,'Albany',	'NY','tyrcjvjh.com'	, SYSDATE +14, 'Waltz'	,			'627DL8TC25');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE'    ,	'Slusarski', 'Alisha',	7156626764,	'alisha@slusarski.com',	'11-Dec-1994',	'I like baseball'	,'Do it yourself',	'185'	,'Middlesex',	'NJ'	,'hgfdjwqd.com', SYSDATE+9  ,'w23d45f65'	,	'318KL7FT26');		
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS'     ,	'Iturbide','Allene',	9133882079,	'allene_iturbide@cox.net'	,'23-Jan-1989',	'I love movies'	,'Electronics',	'178',	'Stevens Point',	'WI' ,'dtyfjhvyiy.com'	, SYSDATE +10, 'vpmzc4zw',	'937UV6IH27')	;		
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER' ,	'Caudy' ,'Chanel',	4106691642,	'chanel.caudy@caudy.org',	'28-Feb-1999',	'I love music',	'Embroidery',	'178',	'Shawnee',	'KS',	'ggfuyiy.com', SYSDATE+9, 'allsts1',				'391PB5YB28');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER',	'Chui' ,'Ezekiel'	,2125824976 ,'ezekiel@chui.com'	,	'01-Nov-1992',	'I am a big fan of DeNiro',	'Fashion'	,'178'	,'Easton',	'MD',	'tyfjhqwvdgd.com' ,SYSDATE+4 ,'fdsff','836IG4CX29');		
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS'    ,	'Kusko' ,'willow'	,9363363951	,'wkusko@yahoo.com',	'11-Dec-1994'	,'Love Indian Food'	,'Flower arranging'	,'178',	'New York'	,'NY' ,'fufkwqduig.com',	 SYSDATE ,'zhuk72','150BV6SG30');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE'      ,	'Figeroa' ,'Bernardo'	,6148019788	,'bfigeroa@aol.com'	,'23-Jan-1989',	'I am into metallica'	,'Foreign language learning',	'183',	'Conroe',	'TX', 'ffwdhd.com'	, SYSDATE+6, '1Chapman',	'732YC8OC31');			
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE'    ,	'Corrio', 'Ammie',	5059773911,	'ammie@corrio.com',	'28-Feb-1999'	,'I like baseball',	'Gaming',	'168'	,'Columbus',	'OH','gfhyufig.com'	 ,SYSDATE+8 ,'vvanyaa','816GT0VS32');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS'     ,	'Vocelka', 'Francine',	2017096245	,'francine_vocelka@vocelka.com',	'01-Nov-1992',	'I love movies','tabletop games',		'174',	'Las Cruces',	'NM', 'drtdkqwd.com',SYSDATE+17 , 'woodchair84'	,'514LF9BC33');			
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER' ,	'Stenseth', 'Ernie',	7329247882	,'ernie_stenseth@aol.com',	'23-Jan-1989'	,'I love music','role-playing games'	,	'167'	,'Ridgefield Park'	,'NJ' ,'fwdwutdqw.com'	 ,SYSDATE+9 ,'topref'	,'862CS8TQ34');			
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER',	'Glick' ,'Albina',	2128601579	,'albina@glick.com'	,'28-Feb-1999',	'I am a big fan of DeNiro',	'Gambling',	'171'	,'Dunellen',	'NJ', 'fuyfwqdu.com',	 SYSDATE+9 ,'Xander28','838PO3BX35');		
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS'    ,	'Sergi' ,'Alishia',	5049799175,	'asergi@gmail.com',	'01-Nov-1992'	,'Love Indian Food',	'Genealogy',	'177'	,'New York',	'NY' 	, 'dfqwyd.com', SYSDATE+2  ,'backspc'	,'726JO6VV36');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE'      ,	'Shinko', 'Solange'	,2126758570,'solange@shinko.com',		'11-Dec-1994',	'I am into metallica',	'Glassblowing',	'166',	'Metairie',	'LA' ,'hjdvwqdhgqiud.com',	 SYSDATE+16,  'Wx9Dk3'	,	'185MA7OP37')	;	
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE'    ,	'Stockham', 'Jose',	8058326163,	'jose@yahoo.com',	'23-Jan-1989'	,'I like baseball',	'Gunsmithing',	'169'	,'New York',	'NY' ,'wggfdyd.com',	 SYSDATE+15 ,'genosys'	,'126PO0PM38');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS',	'Ostrosky' ,'Rozella',	2108129597 ,'rozella.ostrosky@ostrosky.com'	,	'28-Feb-1999',	'I love movies',	 'Homebrewing',	'169'	,'Camarillo',	'CA', 'tydqid.com',	 SYSDATE+7,  'Vu5288zLUJ',		'991VN6CM39'	);	
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER',	'Gillian' ,'Valentine',	7854637829 ,'valentine_gillian@gmail.com'		,'01-Nov-1992'	,'I love music',	'Ice skating'	,'169'	,'San Antonio'	,'TX' ,'dyfqdi.com',	 SYSDATE+3 ,'evete'	,	'001ZX9MP40');	
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER',	'Rulapaugh', 'Kati',	5415488197	,'kati.rulapaugh@hotmail.com'	,'11-Dec-1994',	'I am a big fan of DeNiro' ,'Jewelry making','167',	'Abilene',	'KS', 'gqfhfdiy.com',	 SYSDATE+17, 'xxx310xxx','712DO2CS41')	;	
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS',	'Schemmer' ,'Youlanda',	9134134604, 	'youlanda@aol.com',	'23-Jan-1989',	'I like baseball',	'Jigsaw puzzles'	,'183',	'Prineville',	'OR' ,'afdiyqwd.com'	 ,SYSDATE+18 ,'edcba2000','168GH4IX42')	;
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE',	'Oldroyd' ,'Dyan', 9072314722 ,	'doldroyd@aol.com',	'28-Feb-1999'	,'Love Indian Food'	,'Juggling',	'168'	,'Overland Park',	'KS' ,'ydtqiwdjl.com',	 SYSDATE+19, 'd88884350' ,				'512LA7GA43');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('FEMALE',	'Campain',' Roxane',	3056067291,	'roxane@hotmail.com', '01-Nov-1992',	'I am into metallica'	,'Knapping',	'175',	'Fairbanks',	'AK'	,'oioewhiouqw.com' ,SYSDATE+11 ,'xao009358'	,'790FF9JQ44');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS'	,'Perin',' Lavera',	9077411044	,'lperin@perin.org'	,'23-Jan-1989'	,'I like baseball',	'Knitting',	'176',	'Miami',	'FL',	'pweggwf.com', SYSDATE+14, '3512938','551FA9PW45');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('PANGENDER',	'Ferensz',' Erick',	9527682416,	'erick.ferencz@aol.com'	,'28-Feb-1999',	'Love Indian Food',	'Kabaddi'	,'180',	'Fairbanks'	,'AK',	'dfuyqwfd.com',SYSDATE+14, 'romairina','714NF0PG46');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('POLYGENDER',	'Saylors',' Fatima',	6173995124 ,'fsaylors@saylors.org'	, '01-Nov-1992',	'I like baseball',	'Knife making',	'181'	,'Hopkins'	,'MN' ,'eqquf.com'	, SYSDATE+12 ,'9n8wq58u','882LA0BM47')	;
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('OTHERS',	'Briddick ','Jina',	3234532780	,'jina_briddick@briddick.com', '11-Dec-1994',	'I love movies'	,'Lacemaking',	'168',	'Boston',	'MA',' yydwuwkq.com',	 SYSDATE+11, 'c0427c','531VX8TH48');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('MALE',	'Waycott',' Kanisha',	6083367444,	'kanisha_waycott@yahoo.com'	,'23-Jan-1989'	,'I love music',	'Lapidary',	'180'	,'Los Angeles'	,'CA',	'jhvwdhqd.com' ,SYSDATE +17,'jr0418',	'109UY5VS49');
EXEC ADMIN_DATING_APP.INSERT_USER_PRIMARY('TRANS',	'Blair','Malet',	2159079111	,'bmalet@yahoo.com',	'28-Feb-1999',	'I am a big fan of DeNiro',	'Leather crafting',	'171',	'Dane',	'WI', 'gwighww.com',	 SYSDATE+3, '80454723'	,	'610GW3KL50');	
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'rohansharma@gmail.com' , 'password123' , 'ESN32SZKFT8G');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'buttjames@gmail.com' , '1980290' , 'VCB5KM221OM0');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'josephine_darakjy@darakjy.org' , 'tornadof' , 'NVJXNH3Z9HYC');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'art@venere.org' , 'vova87654' , 'T7E3KT21BVXH');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'lpaprocki@hotmail.com' , 'XpKvShrO' , '2XDSW5OGZOLY');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'donette.foller@cox.net' , 'QuieaX' , 'G3FDJYMHJAYQ');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'simona@morasca.com' , 'stava1' , 'AXJEIQRF248A');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'mitsue_tollner@yahoo.com' , 'keannn' , 'WER0QYXJ2ZWW');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'leota@hotmail.com' , 'xoPTDK' , '80QLBXBVRZPQ');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'sage_wieser@cox.net' , 'supagordon' , 'NNJZ1DH5RXKC');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'kris@gmail.com' , 'XQyz7B4c8' , 'DQY23XGRGGR3');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'minna_amigon@yahoo.com' , 'gOeJio' , 'CDC4BAXW9PTI');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'amaclead@gmail.com' , 'xor59him' , '3B3MCUEPMFRB');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'kiley.caldarera@aol.com' , 'ZyKDmjR5f' , 'ZCX1BR9YK5CY');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'gruta@cox.net' , 'mroads' , '1BLEXV0XCAZP');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'calbares@gmail.com' , 'vbl666ufhl' , '7EA25FFR5356');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'mattie@aol.com' , '9533207' , 'D2B6IFAOF049');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'meaghan@hotmail.com' , 'nrokkorn' , 'DSHC3J7SH4HN');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'gladys.rim@rim.org' , 'yBYlIRUje' , '2SRUKGW68N6T')
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'yuki_whobrey@aol.com' , 'YbR4859' , '1NLQMM6EUFWS');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'fletcher.flosi@yahoo.com' , 'canyon59' , '6IYYOK2UCVIX');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'bette_nicka@cox.net' , 'waltdawg' , '0GF879FSV308');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'vinouye@aol.com' , 'ybnf101208' , 'SAHRA20Y59OT');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'willard@hotmail.com' , 'XjjQSlN516' , 'MHTY9W8TT3IN');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'mroyster@royster.com' , 'Waltz' , '7XQB3FAHZ02S');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'alisha@slusarski.com' , 'w23d45f65' , 'D8MU0RYCK9S6');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'allene_iturbide@cox.net' , 'vpmzc4zw' , '5RJPEHE69DCQ');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'chanel.caudy@caudy.org' , 'allsts1' , '7YOLM88ZEL5V');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'ezekiel@chui.com' , 'fdsff' , 'Q9TN86ALLEWB');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'wkusko@yahoo.com' , 'zhuk72' , '1Q541G0LUV2V');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'bfigeroa@aol.com' , '1Chapman' , '211OS5LEQ6VJ');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'ammie@corrio.com' , 'vvanyaa' , 'UARGL06ZVJWM');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'francine_vocelka@vocelka.com' , 'woodchair84' , 'TXZHEVPDFBXR');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'ernie_stenseth@aol.com' , 'topref' , '658JR74RNOSB');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'albina@glick.com' , 'Xander28' , 'WGM272J9B65A');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'asergi@gmail.com' , 'backspc' , 'RO8G5CPI4NPA');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'solange@shinko.com' , 'Wx9Dk3' , '9ZCDCLCKGYJY');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'jose@yahoo.com' , 'genosys' , '2MH0R9S0Y9OT');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'rozella.ostrosky@ostrosky.com' , 'Vu5288zLUJ' , 'LA1UQW4U3JQ0');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'valentine_gillian@gmail.com' , 'evete' , 'YEHK4I8HEGX6');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'kati.rulapaugh@hotmail.com' , 'xxx310xxx' , 'Y9BCJKHZLES9');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'youlanda@aol.com' , 'edcba2000' , '7A7FNMLBOOG3');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'doldroyd@aol.com' , 'd88884350' , '8A4R7NXJNFUR');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'roxane@hotmail.com' , 'xao009358' , 'DNBSRCKEVZ0S');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'lperin@perin.org' , '3512938' , 'VA25HUY9AVXZ');
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'erick.ferencz@aol.com' , 'romairina' , 'ZV9ZXDFV49QJ')
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'fsaylors@saylors.org' , '9n8wq58u' , 'OKNB07CU6NGH')
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'jina_briddick@briddick.com' , 'c0427c' , '5XRZS392TIJR')
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'kanisha_waycott@yahoo.com' , 'jr0418' , '9M06GC3DUVWS')
EXEC ADMIN_DATING_APP.INSERT_PHOTO( 'bmalet@yahoo.com' , '80454723' , 'JIY1YJRYVLLH')

EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('rohansharma@gmail.com','password123','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('buttjames@gmail.com','1980290','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('josephine_darakjy@darakjy.org','tornadof','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('art@venere.org','vova87654','POLYGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('lpaprocki@hotmail.com','XpKvShrO','PANGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('donette.foller@cox.net','QuieaX','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('simona@morasca.com','stava1','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('mitsue_tollner@yahoo.com','keannn','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('leota@hotmail.com','xoPTDK','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('sage_wieser@cox.net','supagordon','POLYGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('kris@gmail.com','XQyz7B4c8','PANGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('minna_amigon@yahoo.com','gOeJio','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('amaclead@gmail.com','xor59him','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('kiley.caldarera@aol.com','ZyKDmjR5f','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('gruta@cox.net','mroads','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('calbares@gmail.com','vbl666ufhl','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('mattie@aol.com','9533207','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('meaghan@hotmail.com','nrokkorn','POLYGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('gladys.rim@rim.org','yBYlIRUje','PANGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('yuki_whobrey@aol.com','YbR4859','POLYGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('fletcher.flosi@yahoo.com','canyon59','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('bette_nicka@cox.net','waltdawg','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('vinouye@aol.com','ybnf101208','PANGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('willard@hotmail.com','XjjQSlN516','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('mroyster@royster.com','Waltz','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('alisha@slusarski.com','w23d45f65','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('allene_iturbide@cox.net','vpmzc4zw','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('chanel.caudy@caudy.org','allsts1','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('ezekiel@chui.com','fdsff','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('wkusko@yahoo.com','zhuk72','POLYGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('bfigeroa@aol.com','1Chapman','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('ammie@corrio.com','vvanyaa','PANGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('francine_vocelka@vocelka.com','woodchair84','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('ernie_stenseth@aol.com','topref','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('albina@glick.com','Xander28','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('asergi@gmail.com','backspc','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('solange@shinko.com','Wx9Dk3','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('jose@yahoo.com','genosys','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('rozella.ostrosky@ostrosky.com','Vu5288zLUJ','POLYGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('valentine_gillian@gmail.com','evete','PANGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('kati.rulapaugh@hotmail.com','xxx310xxx','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('youlanda@aol.com','edcba2000','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('doldroyd@aol.com','d88884350','TRANS')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('roxane@hotmail.com','xao009358','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('lperin@perin.org','3512938','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('erick.ferencz@aol.com','romairina','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('fsaylors@saylors.org','9n8wq58u','FEMALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('jina_briddick@briddick.com','c0427c','MALE')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('kanisha_waycott@yahoo.com','jr0418','PANGENDER')
EXEC ADMIN_DATING_APP.INSERT_GENDER_PREFERENCE('bmalet@yahoo.com','80454723','TRANS')

EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('rohansharma@gmail.com','password123','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('buttjames@gmail.com','1980290','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('josephine_darakjy@darakjy.org','tornadof','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('art@venere.org','vova87654','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('lpaprocki@hotmail.com','XpKvShrO','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('donette.foller@cox.net','QuieaX','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('simona@morasca.com','stava1','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('mitsue_tollner@yahoo.com','keannn','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('leota@hotmail.com','xoPTDK','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('sage_wieser@cox.net','supagordon','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('kris@gmail.com','XQyz7B4c8','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('minna_amigon@yahoo.com','gOeJio','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('amaclead@gmail.com','xor59him','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('kiley.caldarera@aol.com','ZyKDmjR5f','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('gruta@cox.net','mroads','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('calbares@gmail.com','vbl666ufhl','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('mattie@aol.com','9533207','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('meaghan@hotmail.com','nrokkorn','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('gladys.rim@rim.org','yBYlIRUje','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('yuki_whobrey@aol.com','YbR4859','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('fletcher.flosi@yahoo.com','canyon59','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('bette_nicka@cox.net','waltdawg','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('vinouye@aol.com','ybnf101208','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('willard@hotmail.com','XjjQSlN516','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('mroyster@royster.com','Waltz','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('alisha@slusarski.com','w23d45f65','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('allene_iturbide@cox.net','vpmzc4zw','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('chanel.caudy@caudy.org','allsts1','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('ezekiel@chui.com','fdsff','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('wkusko@yahoo.com','zhuk72','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('bfigeroa@aol.com','1Chapman','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('ammie@corrio.com','vvanyaa','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('francine_vocelka@vocelka.com','woodchair84','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('ernie_stenseth@aol.com','topref','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('albina@glick.com','Xander28','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('asergi@gmail.com','backspc','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('solange@shinko.com','Wx9Dk3','CASUAL')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('jose@yahoo.com','genosys','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('rozella.ostrosky@ostrosky.com','Vu5288zLUJ','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('valentine_gillian@gmail.com','evete','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('kati.rulapaugh@hotmail.com','xxx310xxx','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('youlanda@aol.com','edcba2000','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('doldroyd@aol.com','d88884350','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('roxane@hotmail.com','xao009358','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('lperin@perin.org','3512938','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('erick.ferencz@aol.com','romairina','SERIOUS')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('fsaylors@saylors.org','9n8wq58u','COMMITTED')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('jina_briddick@briddick.com','c0427c','NSA')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('kanisha_waycott@yahoo.com','jr0418','NOT SURE')
EXEC ADMIN_DATING_APP.INSERT_RELATIONSHIP_TYPE('bmalet@yahoo.com','80454723','SERIOUS')


EXEC ADMIN_DATING_APP.INSERT_LIKE('rohansharma@gmail.com','password123','willard@hotmail.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('buttjames@gmail.com','1980290','mroyster@royster.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('josephine_darakjy@darakjy.org','tornadof','alisha@slusarski.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('art@venere.org','vova87654','allene_iturbide@cox.net')
EXEC ADMIN_DATING_APP.INSERT_LIKE('lpaprocki@hotmail.com','XpKvShrO','chanel.caudy@caudy.org')
EXEC ADMIN_DATING_APP.INSERT_LIKE('donette.foller@cox.net','QuieaX','ezekiel@chui.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('simona@morasca.com','stava1','wkusko@yahoo.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('mitsue_tollner@yahoo.com','keannn','bfigeroa@aol.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('leota@hotmail.com','xoPTDK','ammie@corrio.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('sage_wieser@cox.net','supagordon','francine_vocelka@vocelka.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('kris@gmail.com','XQyz7B4c8','ernie_stenseth@aol.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('minna_amigon@yahoo.com','gOeJio','albina@glick.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('amaclead@gmail.com','xor59him','willard@hotmail.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('kiley.caldarera@aol.com','ZyKDmjR5f','mroyster@royster.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('gruta@cox.net','mroads','alisha@slusarski.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('calbares@gmail.com','vbl666ufhl','allene_iturbide@cox.net')
EXEC ADMIN_DATING_APP.INSERT_LIKE('mattie@aol.com','9533207','chanel.caudy@caudy.org')
EXEC ADMIN_DATING_APP.INSERT_LIKE('meaghan@hotmail.com','nrokkorn','ezekiel@chui.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('gladys.rim@rim.org','yBYlIRUje','wkusko@yahoo.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('yuki_whobrey@aol.com','YbR4859','bfigeroa@aol.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('fletcher.flosi@yahoo.com','canyon59','ammie@corrio.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('bette_nicka@cox.net','waltdawg','francine_vocelka@vocelka.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('vinouye@aol.com','ybnf101208','ernie_stenseth@aol.com')
EXEC ADMIN_DATING_APP.INSERT_LIKE('willard@hotmail.com','XjjQSlN516','albina@glick.com')
EXEC ADMIN_DATING_APP.INSERT_RATING('rohansharma@gmail.com','password123','willard@hotmail.com',9)
EXEC ADMIN_DATING_APP.INSERT_RATING('buttjames@gmail.com','1980290','mroyster@royster.com',7)
EXEC ADMIN_DATING_APP.INSERT_RATING('josephine_darakjy@darakjy.org','tornadof','alisha@slusarski.com',1)
EXEC ADMIN_DATING_APP.INSERT_RATING('art@venere.org','vova87654','allene_iturbide@cox.net',5)
EXEC ADMIN_DATING_APP.INSERT_RATING('lpaprocki@hotmail.com','XpKvShrO','chanel.caudy@caudy.org',3)
EXEC ADMIN_DATING_APP.INSERT_RATING('donette.foller@cox.net','QuieaX','ezekiel@chui.com',1)
EXEC ADMIN_DATING_APP.INSERT_RATING('simona@morasca.com','stava1','wkusko@yahoo.com',8)
EXEC ADMIN_DATING_APP.INSERT_RATING('mitsue_tollner@yahoo.com','keannn','bfigeroa@aol.com',9)
EXEC ADMIN_DATING_APP.INSERT_RATING('leota@hotmail.com','xoPTDK','ammie@corrio.com',5)
EXEC ADMIN_DATING_APP.INSERT_RATING('sage_wieser@cox.net','supagordon','francine_vocelka@vocelka.com',5)
EXEC ADMIN_DATING_APP.INSERT_RATING('kris@gmail.com','XQyz7B4c8','ernie_stenseth@aol.com',7)
EXEC ADMIN_DATING_APP.INSERT_RATING('minna_amigon@yahoo.com','gOeJio','albina@glick.com',2)
EXEC ADMIN_DATING_APP.INSERT_RATING('amaclead@gmail.com','xor59him','willard@hotmail.com',3)
EXEC ADMIN_DATING_APP.INSERT_RATING('kiley.caldarera@aol.com','ZyKDmjR5f','mroyster@royster.com',7)
EXEC ADMIN_DATING_APP.INSERT_RATING('gruta@cox.net','mroads','alisha@slusarski.com',7)
EXEC ADMIN_DATING_APP.INSERT_RATING('calbares@gmail.com','vbl666ufhl','allene_iturbide@cox.net',3)
EXEC ADMIN_DATING_APP.INSERT_RATING('mattie@aol.com','9533207','chanel.caudy@caudy.org',8)
EXEC ADMIN_DATING_APP.INSERT_RATING('meaghan@hotmail.com','nrokkorn','ezekiel@chui.com',4)
EXEC ADMIN_DATING_APP.INSERT_RATING('gladys.rim@rim.org','yBYlIRUje','wkusko@yahoo.com',8)
EXEC ADMIN_DATING_APP.INSERT_RATING('yuki_whobrey@aol.com','YbR4859','bfigeroa@aol.com',6)
EXEC ADMIN_DATING_APP.INSERT_RATING('fletcher.flosi@yahoo.com','canyon59','ammie@corrio.com',9)
EXEC ADMIN_DATING_APP.INSERT_RATING('bette_nicka@cox.net','waltdawg','francine_vocelka@vocelka.com',3)
EXEC ADMIN_DATING_APP.INSERT_RATING('vinouye@aol.com','ybnf101208','ernie_stenseth@aol.com',2)
EXEC ADMIN_DATING_APP.INSERT_RATING('willard@hotmail.com','XjjQSlN516','albina@glick.com',4)
EXEC ADMIN_DATING_APP.INSERT_BLOCK('rohansharma@gmail.com','password123','willard@hotmail.com')
EXEC ADMIN_DATING_APP.INSERT_BLOCK('buttjames@gmail.com','1980290','mroyster@royster.com')
EXEC ADMIN_DATING_APP.INSERT_BLOCK('josephine_darakjy@darakjy.org','tornadof','alisha@slusarski.com')
EXEC ADMIN_DATING_APP.INSERT_BLOCK('art@venere.org','vova87654','allene_iturbide@cox.net')
EXEC ADMIN_DATING_APP.INSERT_BLOCK('lpaprocki@hotmail.com','XpKvShrO','chanel.caudy@caudy.org')
EXEC ADMIN_DATING_APP.INSERT_BLOCK('donette.foller@cox.net','QuieaX','ezekiel@chui.com')

EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'rohansharma@gmail.com' , 'password123','willard@hotmail.com' , 'Are you a fan of Google or Microsoft?')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'buttjames@gmail.com' , '1980290','mroyster@royster.com' , 'Both are excellent technology they are helpful in many ways. For the security purpose both are super.')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'josephine_darakjy@darakjy.org' , 'tornadof','alisha@slusarski.com' , ' Im not  a huge fan of Google, but I use it a lot because I have to. I think they are a monopoly in some sense. ')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'art@venere.org' , 'vova87654','allene_iturbide@cox.net' , ' Google provides online related services and products, which includes online ads, search engine and cloud computing.')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'lpaprocki@hotmail.com' , 'XpKvShrO','chanel.caudy@caudy.org' , ' Yeah, their services are good. Im just not a fan of intrusive they can be on our personal lives. ')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'donette.foller@cox.net' , 'QuieaX','ezekiel@chui.com' , 'Google is leading the alphabet subsidiary and will continue to be the Umbrella company for Alphabet internet interest.')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'simona@morasca.com' , 'stava1','wkusko@yahoo.com' , 'Did you know Google had hundreds of live goats to cut the grass in the past?')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'mitsue_tollner@yahoo.com' , 'keannn','bfigeroa@aol.com' , ' It is very interesting. Google provide "Chrome OS" which is a light weight OS. Google provided a lot of hardware mainly in 2010 to 2015. ')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'leota@hotmail.com' , 'xoPTDK','ammie@corrio.com' , 'I like Google Chrome. Do you use it as well for your browser?')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'sage_wieser@cox.net' , 'supagordon','francine_vocelka@vocelka.com' , ' Yes.Google is the biggest search engine and Google service figure out top 100 website, including Youtube and Blogger.')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'kris@gmail.com' , 'XQyz7B4c8','ernie_stenseth@aol.com' , ' By the way, do you like Fish? ')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'minna_amigon@yahoo.com' , 'gOeJio','albina@glick.com' , 'Yes. They form a sister group of tourniquets- they make the sea water clean and remove the dust from it. Fish is the biggest part in the eco-system.')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'amaclead@gmail.com' , 'xor59him','willard@hotmail.com' , 'Did you know that a seahorse is the only fish to have a neck?')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'kiley.caldarera@aol.com' , 'ZyKDmjR5f','mroyster@royster.com' , ' Freshwater fish only drink water through the skin via Osmosis, Saltwater fish drink water through the mouth. Dolphins are friendly to human beings.')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'gruta@cox.net' , 'mroads','alisha@slusarski.com' , ' Interesting, they also have gills. Did you know that jellyfish are immortal? ')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'calbares@gmail.com' , 'vbl666ufhl','allene_iturbide@cox.net' , 'Yes. Fish is the important resources of human world wide for the commercial and subsistence fish hunts the fish in the wild fisheries.')
EXEC ADMIN_DATING_APP.INSERT_CONVERSATION( 'mattie@aol.com' , '9533207','chanel.caudy@caudy.org' , ' What about cats, do you like cats? Im a dog fan myself. ')
COMMIT;
/
SELECT * FROM admin_dating_app.USER_DETAIL_U;
/
SELECT * FROM admin_dating_app.block_r;  
/
SELECT * FROM admin_dating_app.CONVERSATION_C;
/
SELECT * FROM ADMIN_DATING_APP.gender_preference_u;
/
SELECT * FROM admin_dating_app.gender_u;
/
SELECT * FROM admin_dating_app.interested_in_relation_u;
/
SELECT * FROM admin_dating_app.rating_r;
/
SELECT * FROM admin_dating_app.relationship_type_u;
/
SELECT * FROM admin_dating_app.user_like_u;
/
SELECT * FROM admin_dating_app.user_photo_u;
/







































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































