set SERVEROUTPUT on;


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

    
exec insert_gender_preference('abcd@gmail.com','PASSWORD1','female');
