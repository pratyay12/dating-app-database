set SERVEROUTPUT on;

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

