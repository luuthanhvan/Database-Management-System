-- cau 8: tao role, cap quyen cho role va them nguoi dung vao role vua tao
-- tao 2 user
create user van1 identified by van1 default tablespace users quota 1M on users;
create user van2 identified by van2 default tablespace users quota 1M on users;

-- tao role
create role TTOracle;

-- cap quyen ket noi CSDL, tao bang, tao thu tuc, tao trigger cho role vua tao
grant create session, create table, create procedure, create trigger to TTOracle;

-- cap quyen cho cac user vao role nay
grant TTOracle to van1, van2;

-- thu hoi role
revoke TTOracle from van1;

