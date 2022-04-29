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
