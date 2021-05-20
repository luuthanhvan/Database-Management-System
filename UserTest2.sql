-- tao bang
create table products(
  productID char(3) primary key,
  productName varchar2(30)
);
-- them du lieu vao bang
insert into products values('P01', 'Kem Danh Rang P/S');
insert into products values('P02', 'Khan Giay Puppy');

select * from products;
select * from test1.students;

-- cap quyen doi tuong cho user test3
grant select, update on test1.students to test3;

-- cap quyen xoa bang students cua user test1 cho user test3
grant delete on test1.students to test3;
/*
Error: insufficient privileges
Reason: user test2 chua duoc cao quyen xoa bang nen khong the cap quyen xoa bang
cho user test3
*/

/* thuc hien cac cau truy van tren bang students cua user test1 tu user test2 va test3
-> error: table or view does not exist */
