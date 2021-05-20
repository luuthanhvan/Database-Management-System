-- sys user
drop table NHAXB;
create table nhaXB(
  MaNXB char(4) not null constraint PK_NXB primary key
    check (MaNXB in ('1389', '0736', '0877', '1622', '1756') or regexp_like(MaNXB, '[A-Z]9[1-9]\d')),
  TenNXB varchar2(40) null,
  ThPho varchar2(20) null,
  QGia varchar2(30) default 'VietNam' null
);

insert into nhaXB(MaNXB, TenNXB, ThPho) values('9980', 'NXB Van Hoa 1', 'TP.HCM');
-- error: check constraint violated (MaNXB is incorrect with its pattern)

insert into nhaXB(MaNXB, TenNXB, ThPho) values('1389', 'NXB Van Hoa 1', 'TP.HCM');

drop user BAOHIEM cascade;

create user baohiem identified by bh default tablespace users quota 2M on users;
grant create session, create table, create user to baohiem with admin option;


-- baohiem user
select * from donvi;
alter table donvi add constraint pk_dv primary key (donvi)
	add constraint uk_tendv unique (tendv)
	add check(regexp_like(trim(both ' ' from tel), '{38}\d{6}'));

select * from kh;
alter table kh add constraint pk_kh primary key (makh)
	add constraint fk_dv foreign key (madv) references donvi(madv)
	add constraint ck_phai check(phai in (0,1));

select * from loaibh;
alter table loaibh add constraint pk_loai primary key (maloai)
	add constraint uk_tenloai unique(tenloai)
	add constraint ck_mucphi check (mucphi > 0);

select * from thebh;
alter table thebh add primary key (maloai, makh, ngaybd) 
	add foreign key (maloai) references loaibh(maloai)
	add foreign key (makh) references kh(makh)
	add constraint ck_thoihan check (thoihan > 0);

alter table thebh add (NgayKT, date) add check (NgayKT = add_months(ngaybd,thoihan));
update thebh set ngayKT = add_months(ngaybd,thoihan);

alter table thebh add (ConHL, int check(ConHL in (0,1)));
update thebh set ConHL = 0 where ngaykt <= sysdate;
update thebh set ConHL = 1 where ngaykt > sysdate;

insert into thebh (maloai, ngaybd, makh, thoihan, ngaykt, conhl)
select distinct a.maloai, sysdate, a.makh, 6, add_months(sysdate, 6),1 
    from thebh a, kh b, donvi c, loaibh d
    where a.makh = b.makh and b.madv =c.madv and d.maloai=a.maloai
        		and tendv = 'So Dien Luc' and tenloai = 'BH Y TE';
create table thebh_quahan as
    select*from thebh where conhl=0;

delete from thebh where conhl = 0;

create table mucphi (
maloai char(2) references loaibh(maloai),
mucphi int check(mucphi >0), ngaybd date defaul(sysdate),
nguoicn char(20) default (user), primary key (maloai,ngaybd));
        

create view thebh_ganhethan as
    select* from thebh where add_months(ngaybd, thoihan)
    between sysdate and add_months(sysdate,1);
select* from thebh_ganhethan 

update thebh_ganhethan set ngaybd = sysdate 
                        where makh='005' and maloai='TS';
select * from thebh_ganhethan                        

create or replace view thebh_ganhethan as
select*from thebh where add_months(ngaybd, thoihan) between sysdate and add_months(sysdate,1)
    with check option;
select*from thebh_ganhethan




