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
    TEXT_MESSAGE blob  NOT NULL,
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
    GENDER varchar2(10)  NOT NULL,
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
    RATE number(2)  NOT NULL,
    CONSTRAINT RATING_R_pk PRIMARY KEY (RATE_INITIATER,RATE_RECEIVER)
) ;

-- Table: RELATIONSHIP_TYPE_U
CREATE TABLE RELATIONSHIP_TYPE_U (
    RELATIONSHIP_TYPE_ID number(10)  NOT NULL,
    RELATIONSHIP_TYPE varchar2(20)  NOT NULL,
    CONSTRAINT RELATIONSHIP_TYPE_U_pk PRIMARY KEY (RELATIONSHIP_TYPE_ID)
) ;

-- Table: USER_DETAIL_U
CREATE TABLE USER_DETAIL_U (
    USER_ID number(10)  NOT NULL,
    GENDER_ID number(10)  NOT NULL,
    LAST_NAME varchar2(50)  NOT NULL,
    FIRST_NAME varchar2(50)  NOT NULL,
    PHONE_NUMBER number(10)  NOT NULL,
    EMAIL varchar2(100)  NOT NULL,
    REGISTRATION_TIMESTAMP timestamp NOT NULL,
    DATE_OF_BIRTH date  NOT NULL,
    BIO varchar2(400)  NOT NULL,
    HOBBY varchar2(30)  NOT NULL,
    HEIGHT number(3)  NOT NULL,
    CITY varchar2(6)  NOT NULL,
    STATE varchar2(2)  NOT NULL,
    INSTAGRAM_LINK varchar2(500)  NOT NULL,
    PASSWORD varchar2(100)  NOT NULL,
    LAST_LOGIN timestamp NOT NULL,
    PASSPORT_NUMBER varchar2(10)  NOT NULL,
    MEMBERSHIP_TYPE varchar2(15)  NOT NULL,
    CONSTRAINT USER_DETAIL_U_pk PRIMARY KEY (USER_ID)
) ;

-- Table: USER_LIKE_U
CREATE TABLE USER_LIKE_U (
    INITIATOR_ID number(10)  NOT NULL,
    RECEIVER_ID number(10)  NOT NULL,
    STATUS number(1)  NOT NULL,
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
            'GRANT SELECT ON '||r.owner||'.'||r.table_name||' to ' || grantee;
        EXECUTE IMMEDIATE
            'GRANT INSERT ON '||r.owner||'.'||r.table_name||' to ' || grantee;
    END LOOP;
END; 
/
EXECUTE grant_select('ADMIN_DATING_APP','DATA_OPERATOR');
/
