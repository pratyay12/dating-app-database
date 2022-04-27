-- cannot input other email ids
create or replace procedure insert_like(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2) 
is
userid_initiator number;
userid_receiver number;
x number;
begin
if email_initiator = email_receiver then raise_application_error(-20101, 'You cannot like yourself, input another email-id');
end if;
    
    select COUNT(*) into x from user_detail_u a 
    inner join gender_preference_u b 
        on a.user_id=b.user_id
    inner join interested_in_relation_u c 
        on a.user_id=c.user_id
    where b.GENDER_ID=(select gender_id from gender_preference_u where user_id=userid_initiator) 
        and a.email!=email_initiator 
        AND c.relationship_type_id=(select relationship_type_id from interested_in_relation_u where user_id=userid_initiator)
        AND a.email=email_receiver;
   
   if x=0 then raise_application_error(-20104, 'You cannot proceed with the like');
end if;

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
merge into user_like_u u using sys.dual on (u.initiator_id = userid_initiator and u.receiver_id = userid_receiver)
WHEN NOT MATCHED THEN INSERT(initiator_id,receiver_id,status)
VALUES(userid_initiator,userid_receiver,1);
commit;
end;
/

-- Below functions contains code with credential check and every time a credential check occurs, last_login changes
create or replace FUNCTION get_user_id(email_value IN varchar2, password_value IN varchar2)
RETURN number
IS
user_id_value number;
BEGIN

select user_id into user_id_value from user_detail_u  where email_value = email and password_value=password;
RETURN user_id_value;
EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            raise_application_error(-20101, 'Please check your credentials.');
--if user_id_value is null then raise_application_error(-20101, 'Please check your credentials.'); end if;
END;
/

--update bio
create or replace PROCEDURE UPDATE_bio(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set bio=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your bio has been updated');
 END;
/

--update hobby
create or replace PROCEDURE UPDATE_hobby(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set hobby=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your hobby has been updated');
 END;
/

--update height
create or replace PROCEDURE UPDATE_height(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN number) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set height=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your height has been updated');
 END;
/

--update city
create or replace PROCEDURE UPDATE_city(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set city=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your city has been updated');
 END;
/

--update state
create or replace PROCEDURE UPDATE_state(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set state=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your state has been updated');
 END;
/

--update passport_number
create or replace PROCEDURE UPDATE_passport_number(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set passport_number=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your passport number has been updated');
 END;
/

--update membership_type
create or replace PROCEDURE UPDATE_membership_type(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set membership_type=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your membership type has been updated');
  if (update_this='PREMIUM') then dbms_output.put_line('And your invoice has been sent to your email.'); end if;
 END;
/

--update password
create or replace PROCEDURE UPDATE_password(email_initiator IN varchar2, password_initiator IN varchar2, update_this IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  update user_detail_u set password=update_this where user_id=userid_initiator;
  dbms_output.put_line('Your password has been updated');
 END;
/



