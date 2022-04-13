CREATE OR REPLACE PROCEDURE create_users
is
userexist integer;

begin
-- creating admin
  select count(*) into userexist from dba_users where username='ADMIN_DATING_APP';
  if (userexist = 0) then
    execute immediate 'create user admin_dating_app identified by DeFz8yQfpZVz';
    execute immediate 'GRANT create session TO admin_dating_app';
    execute immediate 'grant create view, create procedure, create sequence to admin_dating_app';
    execute immediate 'grant create table to admin_dating_app';
    execute immediate 'alter user admin_dating_app quota unlimited on users';

  else
    execute immediate 'drop user admin_dating_app cascade';
    execute immediate 'create user admin_dating_app identified by DeFz8yQfpZVz';
    execute immediate 'GRANT create session TO admin_dating_app';
    execute immediate 'grant create view, create procedure, create sequence to admin_dating_app';
    execute immediate 'grant create table to admin_dating_app';
    execute immediate 'alter user admin_dating_app quota unlimited on users';
    --execute immediate 'GRANT dba TO admin_dating_app WITH ADMIN OPTION';

  end if;
  
-- creating data_operator
  select count(*) into userexist from dba_users where username='DATA_OPERATOR';
  if (userexist = 0) then
    execute immediate 'create user DATA_OPERATOR identified by NxXPY6boUurG9';

  else
    execute immediate 'drop user data_operator';
    execute immediate 'create user DATA_OPERATOR identified by NxXPY6boUurG9';
  end if;
  
  
end;
/
execute create_users();
/
