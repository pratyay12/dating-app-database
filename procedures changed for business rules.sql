create or replace procedure insert_like(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2) 
is
userid_initiator number;
userid_receiver number;
begin
if email_initiator = email_receiver then raise_application_error(-20101, 'You cannot like yourself, input another email-id');
end if;
userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
merge into user_like_u u using sys.dual on (u.initiator_id = userid_initiator and u.receiver_id = userid_receiver)
WHEN NOT MATCHED THEN INSERT(initiator_id,receiver_id,status)
VALUES(userid_initiator,userid_receiver,1);
commit;
end;
/

create or replace procedure insert_conversation(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2,text_message in clob)
is

userid_initiator number;
userid_receiver number;
x number;
begin

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
    
    select count(*) into x from Block_r
    where (block_initiater=userid_initiator and block_receiver=userid_receiver) or (block_receiver=userid_initiator and block_initiater=userid_receiver);
    if x>0 then 
        raise_application_error(-20102, 'User is blocked, you cannot converse with them.');
    end if;

    
    select count(*) into x from user_like_u
    where (initiator_id=userid_initiator and receiver_id=userid_receiver and status=1) or (receiver_id=userid_initiator and initiator_id=userid_receiver and status=1 );
    if x=2 then 
        INSERT INTO CONVERSATION_C (CONVERSATION_INITIALIZER,CONVERSATION_RECEIVER,TIME_STAMP,TEXT_MESSAGE)
        VALUES(userid_initiator,userid_receiver,sysdate,text_message);
        commit;
    else x:=0; 
        raise_application_error(-20101, 'Both users have not liked each other so you cannot converse with each other');
    end if;

end;
/

create or replace TRIGGER AGE_CHECK 
BEFORE INSERT OR UPDATE ON USER_DETAIL_U
FOR EACH ROW
BEGIN
    IF :NEW.DATE_OF_BIRTH >  add_months(sysdate , -12*18)  then
       RAISE_APPLICATION_ERROR(-20001, 'Underage user');
    END IF;
END;
/

create or replace procedure insert_rating(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2, val IN number) 

is

userid_initiator number;
userid_receiver number;
x number;
begin

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);
    
    select count(*) into x from Block_r
    where (block_initiater=userid_initiator and block_receiver=userid_receiver) or (block_receiver=userid_initiator and block_initiater=userid_receiver);
    if x>0 then 
        raise_application_error(-20102, 'User is blocked, you cannot rate with them.');
    end if;
    
    select count(*) into x from user_like_u
    where (initiator_id=userid_initiator and receiver_id=userid_receiver and status=1) or (receiver_id=userid_initiator and initiator_id=userid_receiver and status=1 );
    if x=2 then 
        merge into RATING_R R using sys.dual on (R.RATE_INITIATER = userid_initiator and R.RATE_RECEIVER = userid_receiver)
        WHEN NOT MATCHED THEN INSERT(RATE_INITIATER,RATE_RECEIVER,RATE)
        VALUES(userid_initiator,userid_receiver,val);
        commit;
    else x:=0; 
        raise_application_error(-20101, 'Both users have not liked each other so you cannot rate.');
    end if;


end;
/

create or replace procedure insert_block(email_initiator IN varchar2, password_initiator IN varchar2, email_receiver IN varchar2) 

is

userid_initiator number;
userid_receiver number;
initiator_id_receiver_id_unique number;
initiator_id_receiver_id_uniqueEx exception;
x number;

begin

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);

userid_initiator := get_user_id(email_initiator,password_initiator);
userid_receiver := get_user_id_wp(email_receiver);

select count(*) into x from user_like_u
    where (initiator_id=userid_initiator and receiver_id=userid_receiver and status=1) or (receiver_id=userid_initiator and initiator_id=userid_receiver and status=1 );
    if x=2 then 
        merge into BLOCK_R B using sys.dual on (B.BLOCK_INITIATER = userid_initiator and B.BLOCK_RECEIVER = userid_receiver)
        WHEN NOT MATCHED THEN INSERT(BLOCK_INITIATER,BLOCK_RECEIVER)
        VALUES(userid_initiator,userid_receiver);
        COMMIT;
    else x:=0; 
        raise_application_error(-20101, 'Both users have not liked each other so you cannot block.');
    end if;


end;
/

create or replace PROCEDURE VIEW_OTHER_USERS(email_initiator IN varchar2, password_initiator IN varchar2) IS

userid_initiator number;
BEGIN
  userid_initiator := get_user_id(email_initiator,password_initiator);
  declare
    cursor eid is select a.email from user_detail_u a 
    inner join gender_preference_u b 
        on a.user_id=b.user_id
    inner join interested_in_relation_u c 
        on a.user_id=c.user_id
    where b.GENDER_ID=(select gender_id from gender_preference_u where user_id=userid_initiator) and a.email!=email_initiator AND c.relationship_type_id=(select relationship_type_id from interested_in_relation_u where user_id=userid_initiator);
    v_mgr eid%ROWTYPE;
  BEGIN
    OPEN EID;
  LOOP
    -- fetch information from cursor into record
    FETCH eid INTO v_mgr;
    EXIT WHEN eid%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_mgr.email || ',');
  END LOOP;
  CLOSE EID;
 END;
   
END VIEW_OTHER_USERS;