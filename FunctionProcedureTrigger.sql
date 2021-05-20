-- cau 1: thu tuc co tham so
select * from SCOTT.emp;

-- tao thu tuc xoa mot nhan vien khoi danh sach voi tham so truyen vao la ma nhan vien
create or replace procedure del_emp(pEmpno number) is
begin
  delete from scott.emp where empno = pEmpno;
  commit;
end;

-- tim xem nhan vien co ma 7654 co trong bang khong
select * from scott.emp where empno = 7654;

-- thuc thi thu tuc
execute del_emp(7654);

-- cau 2: ham co tham so
-- viet mot ham de lay tong tien luong cua mot phong ban nao do 
set serveroutput on;
create or replace function getDeptSalary(dno number) return number
is allSal number;
begin
  allSal := 0;
  for empSal in (select sal from scott.emp where deptno = dno and sal is not null)
  loop
    allSal := allSal + empSal.sal;
  end loop;
  return allSal;
end getDeptSalary;

-- goi thu ham getDeptSalary voi ma phong ban la 30
select getDeptSalary(30) as Tsal from dual;

-- goi thu ham getDeptSalary voi ma phong ban la 30 va truyen ket qua vao mot bien
declare
  result number;
begin
  result := getDeptSalary(30);
  dbms_output.put_line(result);
end;

-- cau 3 thu tuc voi tham so dau ra
/* su dung bang hr.Jobs(Job_id, Job_Title, Min_Salary, Max_Salary) tao thu tuc MucLuong nhan vao mot
Job)id, tra ve muc luong thap nhat va cao nhat ung voi ma cong viec nay */

create user hr identified by hr default tablespace users quota 2M on users;
grant create session, create table, create user to hr with admin option;

/* 
import user hr:
imp sys@orcl file:D:\CSDL_Oracle\hr.dmp fromuser=hr touser=hr
username: sys as sysdba
password: orcl
*/
select * from hr.jobs;
create or replace procedure MucLuong (p_jobid hr.jobs.job_id%type, 
                                      min_lg out hr.jobs.min_salary%type, 
                                      max_lg out hr.jobs.max_salary%type) is
begin
  select min_salary, max_salary into min_lg, max_lg from hr.jobs where job_id = p_jobid;
end;

set serveroutput on;
declare 
  min1 hr.jobs.min_salary%type;
  max1 hr.jobs.max_salary%type;
  jobID hr.jobs.job_id%type;
begin
  MucLuong('&Nhap_ma_cong_viec', min1, max1);
  dbms_output.put_line('Min = ' || to_char(min1) || ' ' || 'Max = ' || to_char(max1));
end;

-- cau 4: tao trigger de kiem tra rang buoc du lieu
/* Gia su trong bang dept cua luoc do scott co them cot BUDGET chua ngan sach toi da cua tung phong ban danh
cho viec tra luong. Xay dung trigger de kiem tra rang khi cap nhat tien luong thi tong tien luong cua tat ca
cac nhan vien trong mot phong ban khong duoc vuot qua ngan sach cua no.
- them cot Budget kieu number(10) vao bang DEPT
- tim tong tien luong cua tat ca nhan vien theo tung phong ban de uoc luong gia tri phai nhap cho cot Budget*/
select * from SCOTT.dept;
select deptno, sum(sal) as total_sal from scott.emp group by deptno;
-- them cot Budget kieu number(10) vao bang DEPT
alter table scott.dept add budget number(10);
-- nhap gia tri cho cot budget lon hon total_sal
-- tao trigger tren 2 cot: luong va ma phong cua bang emp
create or replace trigger check_budget_emp
after insert or update of sal, deptno on scott.emp
declare
  -- khai bao cursor chua ma phong va ngan sach tu bang dept
  cursor dept_cur is
    select deptno, budget from scott.dept;
  
  -- khai bao bien de luu ma phong, tong luong tu ngan sach va tong luong tu cac nhan vien
  dno scott.dept.deptno%type;
  allsal scott.dept.budget%type;
  dept_sal number;
begin
  open dept_cur;
  loop
    -- lay ngan sach cua tung phong
    fetch dept_cur into dno, allsal;
    exit when dept_cur%NOTFOUND;
    -- tinh tong tien luong cua cac nhan vien trong phong do
    select sum(sal) into dept_sal from scott.emp where deptno = dno;
    -- neu tong luong > ngan sach thi bao loi
    if dept_sal > allsal then
      raise_application_error(-20325, 'Tong luong trong phong ' || to_char(dno) || ' da vuot qua ngan sach');
    end if;
  end loop;
  close dept_cur;
end;

-- cau 5: tao trigger de theo doi cap nhat du lieu
create table change_sal_emp(
  username varchar2(20),
  modify_time date,
  empno number(4),
  old_sal number(7),
  new_sal number(7)
);
-- tao trigger
create or replace trigger store_change_sal_emp
after update of sal on scott.emp
for each row
begin
  insert into change_sal_emp(username, modify_time, empno, old_sal, new_sal)
  values (user, sysdate, :new.empno, :old.sal, :new.sal);
end;

select * from scott.emp;
update SCOTT.emp set sal = 2000 where empno = 7499;
select * from change_sal_emp;

-- cau 6: tao trigger ngan kiem tra du lieu
create user van identified by van default tablespace users quota 2M on users;
grant create session, create table, create user to van with admin option;

/* 
import baohiem schema vao user van:
imp sys@orcl file=D:\CSDL_Oracle\baohiem.dmp fromuser=baohiem touser=van
username: sys as sysdba
password: orcl
*/

/*
login as new user (van)
Connection Name: van_conn
Username: van
Password: van
Role: default
Service name: orcl
*/

-- tao trigger trong new user (van)
select * from thebh;
create trigger da_co_BG before insert on thebh for each row
declare
  sodong int;
begin
  select count(*) into sodong from thebh 
  where makh = :new.makh and maloai = :new.maloai and ngaybd < sysdate;
  if (sodong > 0) then
    raise_application_error(-20111, 'KH nay hien van con duoc BH loai nay');
  end if;
end if;