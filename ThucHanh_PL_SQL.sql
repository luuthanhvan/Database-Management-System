create user hr identified by hr default tablespace users quota 10M on users;
grant create session, create table, create user to hr with admin option;

/* import hr.dmp into user hr (cmd)
imp userid=sys/orcl@orcl file=D:\hr.dmp fromuser=hr touser=hr

... Username: sys as sysdba
Passworld: orcl
*/
-- cau 1
set serveroutput on;
declare
  total_sales number(15,2);
  emp_id  varchar2(9);
  company_number number default 10;
begin
  total_sales := 350000;
  emp_id := 3;
  dbms_output.put_line('Employee ' || emp_id || ', sold total product value: ' || total_sales);
end;

set serveroutput on;
declare
  message varchar2(30) := 'Hello World!';
begin
  dbms_output.put_line(message);
end;

-- cau 2
set serveroutput on;
declare
  ten varchar2(50);
begin
  ten:='&Nhap_vao_ten_cua_ban';
  dbms_output.put_line('Chao ban ' || ten);
end;

select * from hr.employees;
-- cau 3
set serveroutput on;
declare
  vEname hr.employees.last_name%type;
  /* kieu du lieu cua bien vEname se lay tu kieu du lieu cua cot last_name trong bang employees */
  vSalary hr.employees.salary%type;
begin
  select last_name, salary into vEname, vSalary
  from hr.employees
  where employee_id = 100;
  dbms_output.put_line('Name: ' || vEname || '. Salary: ' || vSalary);
end;

-- cau 4
set serveroutput on;
declare
  vEname hr.employees.first_name%type;
begin
  select first_name into vEname
  from hr.employees
  where employee_id = 120;
  
  if vEname='Matthew' then
    dbms_output.put_line('Hi ' || vEname);
  else
    dbms_output.put_line('Hello ' || vEname);
  end if;
end;

set serveroutput on;
declare
  vArea varchar2(20);
begin
  select region_id into vArea
  from hr.countries
  where country_id='CA';
  
  case vArea
    when 1 then vArea:='Europe';
    when 2 then vArea:='America';
    when 3 then vArea:='Asia';
    else vArea:='Other';
  end case;
  dbms_output.put_line('The Area is ' || vArea);
end;

set serveroutput on;
declare
  counter number;
begin
  for counter in 1..4 -- tang
  loop
    dbms_output.put(counter || ' ');
  end loop;
  dbms_output.new_line;
  for counter in reverse 1..4 -- giam
  loop
    dbms_output.put(counter || ' ');
  end loop;
  dbms_output.new_line;
end;




