set SERVEROUTPUT on;

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

