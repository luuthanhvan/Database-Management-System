/* Bai tap thuc hanh trang 100 */
-- Cau 5: tao nguoi dung
-- tao user
create user test1 identified by test1;

-- cap quyen create session cho user test1
grant create session to test1;

-- thay doi mat khau cho user test1
alter user test1 identified by ptest1;

/* cap quyen he thong cho user test1 de user nay duoc phep tao bang, tao user va
duoc phep cap lai cac quyen nay cho nhung user khac */
grant create session, create table, create user to test1 with admin option;

-- cap quota cho user test1
alter user test1 default tablespace users quota 2M on users;
alter user test2 default tablespace users quota 2M on users;
-- tang quota cho user test1 thanh 4M
alter user test1 quota 4M on users;

-- thu hoi quyen create table cua nguoi dung test1
revoke create table from test1;

grant create session, create table to test3 with admin option;
alter user test3 default tablespace users quota 2M on users;
