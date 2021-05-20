-- tao bang
create table students(
  studentID char(7) primary key,
  studentName varchar2(30)
);

-- xen du lieu vao bang
insert into students values('1940000', 'Phung Phung Phi');
insert into students values('1940001', 'Tao Tung Thieu');

select * from students; 

-- cau 6: quyen he thong
/* de kiem tra quyen create table with admin option ma test1 dang co, test1 se tao
1 nguoi dung khac ten la test2 voi quota 2M de cho phep test2 tao bang trong schema
cua test2 */
create user test2 identified by test2;
-- gan quyen create session cho test2
grant create session to test2;
grant create table to test2 with admin option;

-- tao bang
create table subjects(
  subjectID char(10) primary key,
  subjectName varchar2(50)
);
/* Error: insufficient privileges
Reason: sau khi da thu quyen tao bang cua user test1 thi user test1 khong con
quyen tao bang nua. */

-- tao user test3 co cac quyen nhu user test2
create user test3 identified by test3;

-- cap quyen doi tuong cho user test2 truy cap vao bang students trong schema cua test1
grant select, update on students to test2 with grant option;

-- thu hoi quyen select va update tu user test2
revoke select, update on students from test2;
