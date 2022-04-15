--insert data into Gender

insert into GENDER_U values(00000000002,'female');
insert into GENDER_U values(00000000001,'male');



--insert data into User Detail

CREATE SEQUENCE USER_ID_SEQ
    INCREMENT BY 1
    START WITH 1000000002
    MINVALUE 1000000000
    MAXVALUE 9999999999
    CACHE 20;


exec insert_new_user(USER_ID_SEQ.nextval, 'male', 'Patel', 'Raj', 8572505548, 'abcd@gmail.com',CURRENT_TIMESTAMP, '12-DEC-98', 'BIO', 'HOBBY', 6.0, 'Boston', 'MA', 'IG_LINK4.COM', 'PASSWORD1', CURRENT_TIMESTAMP, 'M9523456','TYPE1');
exec insert_new_user(USER_ID_SEQ.nextval, 'female', 'Shah', 'Anushka', 8572705548, 'abcde@gmail.com',CURRENT_TIMESTAMP, '12-DEC-98', 'BIO', 'HOBBY', 6.0, 'Boston', 'MA', 'IG_LINK5.COM', 'PASSWORD1', CURRENT_TIMESTAMP, 'M9521456','TYPE1');


DROP SEQUENCE USER_ID_SEQ;


--insert data into gender_preference

exec insert_gender_preference('abcd@gmail.com','PASSWORD1','female');

--insert data into user_like_u

exec insert_like('abcd@gmail.com','PASSWORD1','abcde@gmail.com',1);
exec insert_like('abcde@gmail.com','PASSWORD1','abcd@gmail.com',0);

--insert data into RATING_R

exec insert_rating('abcd@gmail.com','PASSWORD1','abcde@gmail.com',5);
exec insert_rating('abcde@gmail.com','PASSWORD1','abcd@gmail.com',3);

--insert data into BLOCK_R

exec insert_block('abcde@gmail.com','PASSWORD1','abcd@gmail.com');
