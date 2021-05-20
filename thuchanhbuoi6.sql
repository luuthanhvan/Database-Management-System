/*
select * from SCOTT.emp 
where (extract(year from sysdate) - extract(year from hiredate)) > 25 and sal < 2000;
-- extract(): get current year
select * from SCOTT.emp */
-- cau 5
-- cau a
declare
  cursor cEmp is
    (select * from SCOTT.emp
    where (extract(year from sysdate) - extract(year from hiredate)) > 25 and sal < 2000);
  vEmp cEmp%rowtype; -- khai bao bien de chua dong du lieu cua cursor
begin
-- mo cursor
  open cEmp;
  -- dung vong lap de lay het du lieu trong cursor
  loop
    fetch cEmp into vEmp; -- lay mot dong du lieu tu cursor
    exit when cEmp%notfound; -- lap cho den khi lay het du lieu trong cursor
    -- kiem tra cac gia tri null cua cot tien thuong
    if vEmp.comm is null then vEmp.comm := 500;
    else vEmp.comm := vEmp.comm + 500;
    end if;
    -- cap nhat lai tien thuong trong ban emp voi ma nhan vien trong cursor hien hanh
    update SCOTT.emp set comm = vEmp.comm where empno = vEmp.empno;
    insert into  SCOTT.bonus(ename, job, sal, comm) values(vEmp.ename, vEmp.job, vEmp.sal, vEmp.comm);
  end loop;
  commit; -- luu lai nhung gi thay doi
  close cEmp; -- dong cursor
end; -- -> result: anonymous block completed

select * from Scott.bonus;
select * from SCOTT.emp;


-- cau b
create table empretire(
  empno number(4) not null,
  ename varchar2(10),
  job varchar2(9),
  mgr number(4),
  hiredate date,
  sal number(7,2),
  comm number(7,2),
  deptno number(2)
);

declare
  cursor cEmpRetire is select * from scott.emp where (extract(year from sysdate) - extract(year from hiredate)) >= 35 for update;
begin
  for empRec in cEmpRetire
  loop
    insert into empretire(empno, ename, job, mgr, hiredate, sal, comm, deptno) 
    values (empRec.empno, empRec.ename, empRec.job, empRec.mgr, empRec.hiredate, empRec.sal, empRec.comm, empRec.deptno);
  delete from scott.emp where current of cEmpRetire;
  end loop;
end; -- -> result: anonymous block completed

select * from SCOTT.emp;
select * from empretire;

-- cau c
declare 
  manager scott.emp.mgr%type;
  cursor cEmp(mgrNo number) is select sal from SCOTT.emp where mgr = mgrNo for update of sal;
begin
  select empno into manager from scott.emp where ename = 'KING';
  for empRec in cEmp(manager)
  loop
    update SCOTT.emp set sal = empRec.sal * 1.05 where current of cEmp;
  end loop;
  commit;
end;
