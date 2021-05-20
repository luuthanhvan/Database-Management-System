-- cau 1: tao user
create user van identified by van default tablespace users quota 10M on users;
grant create session, create table, create user to van with admin option;

-- cau 2
create table sinhvien(
  sbd char(8) not null primary key,
  hoten varchar2(50),
  math char(3),
  kvut char(3),
  dtut char(3),
  check (math in ('A00', 'A01') or regexp_like(sbd, '[0-9]\d{8}')) 
);

create table diemthi(
  sbd char(8) not null,
  mon1 float,
  mon2 float,
  mon3 float,
  diemut float,
  diemxt float,
  check(regexp_like(sbd, '[0-9]\d{8}') or mon1 <= 10.0 or mon2 <= 10.0 or mon3 <= 10.0)
);

alter table diemthi add constraint sbd_fk foreign key (sbd) references sinhvien(sbd);

-- cau 3
insert into sinhvien values ('55006267', 'DUONG MINH THANH', 'A01', '3', '0');
insert into sinhvien values ('51015102', 'NGUYEN THI XUAN LAN', 'A01', '2NT', '0');
insert into sinhvien values ('64005272', 'BUI PHUC THINH', 'A00', '1', '0');

insert into diemthi values ('55006267', 7.8, 8.25, 9.6, 0.0, 25.65);
insert into diemthi values ('51015102', 7.6, 6.75, 7.4, 0.5, 22.25);
insert into diemthi values ('64005272', 7.6, 6.75, 7.0, 0.75, 22.1);


