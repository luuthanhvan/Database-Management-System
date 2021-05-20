create user user1 identified by user1 quota 10M on USERS;
grant create session, create table to user1;
--drop user user1;

-- change password user SCOTT
alter user scott identified by tiger;
-- unlock account user SCOTT
alter user scott account unlock;

create user uimp1 identified by uimp1 quota 10M on USERS;
create user uimp2 identified by uimp2 quota 10M on USERS;
create user uimp3 identified by uimp3 quota 10M on USERS;

grant create session, create table to uimp1;
grant create session, create table to uimp2;
grant create session, create table to uimp3;

create user hr identified by hr quota 10M on USERS;
grant create session, create table to hr;

