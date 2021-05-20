/* Dang nhap bang nguoi dung sys va tao 1 nguoi dung moi */
create user luuthanhvan identified by van3199;
/* Cap hang ngach */
alter user luuthanhvan default tablespace system quota 2M on system;

/* Tao role co ten la administrator */
create role administrator identified by ad123;

/* Cap quyen nguoi dung cho luuthanhvan */
grant create session, create user, create table, create trigger, create procedure, create type, create view to luuthanhvan;
grant drop user, drop any table, drop any trigger, drop any procedure, drop any type, drop any view to luuthanhvan;

/* Cap quyen cho nguoi dung luuthanhvan vao role administrator */
grant administrator to luuthanhvan;

/* Dang nhap bang nguoi dung luuthanhvan de tao cac bang CSDL */
create table USER_INFO(
    userID integer primary key,
    userName char(30) not null,
    password char(32) not null,
    role integer not null, -- admin: 1, moderators: 2, customers: 3
    firstName nchar(15),
    lastName nchar(15),
    email char(100) not null,
    phoneNumber char(11),
    createdDate date,
    modifiedDate date,
    constraint userInfo_uq unique (userName, email, phoneNumber),
    constraint check_userName check (regexp_like (userName, '[A-Za-z0-9_-]{3,15}')),
    constraint check_pwd check (regexp_like (password, '([A-Za-z0-9])?.{8,12}')),
    constraint check_phoneNumber check(regexp_like(phoneNumber, '0\d{9,10}')),
    constraint check_email check(email like '%_@__%.__%')
);

create table BRAND(
    brandID integer primary key,
    brandName nchar(30) not null,
    constraint brandName_uq unique (brandName)
);

create table METHOD_CHECKOUT(
    methodCheckoutID integer primary key,
    methodCheckoutName nchar(50) not null,
    constraint methodCheckoutName_uq unique (methodCheckoutName)
);

create table PRODUCT_CATEGORY(
    productCategoryID integer primary key,
    productCategoryName nchar(100) not null,
    constraint productCategoryName_uq unique (productCategoryName)
);

create table PRODUCT(
    productID integer primary key,
    productCategoryID integer constraint product_category_FK references PRODUCT_CATEGORY(productCategoryID),
    brandID integer constraint brand_FK references BRAND(brandID),
    productName nchar(150) not null,
    price float not null,
    image nchar(100),
    descriptions nvarchar2(500),
    constraint productName_uq unique (productName)
);

create table COMMENTS(
    numComment integer primary key,
    productID integer constraint product_FK references PRODUCT(productID),
    userID integer constraint user_FK references USER_INFO(userID),
    datetime TIMESTAMP not null,
    contentCmt nvarchar2(500)
);

create table BILL(
    numBill integer primary key,
    userID integer constraint bill_user_FK references USER_INFO(userID),
    methodCheckoutID integer constraint method_checkout_FK references METHOD_CHECKOUT(methodCheckoutID),
    totalBill float not null,
    createdBill timestamp not null
);

create table BILL_DETAIL(
    productID integer constraint product_bill_FK references PRODUCT(productID),
    numBill integer constraint bill_FK references BILL(numBill),
    quantity integer not null
);

/* Data for table USER_INFO */
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (101, 'JohnWilliams2105', 'John2105', 1, 'John', 'Williams', 'john2105@gmail.com', '0851711889', TO_DATE('01/01/2017', 'dd/mm/yyyy'), TO_DATE('02/02/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (102, 'SusanMitchell0402', 'Susan0402', 3, 'Susan', 'Mitchell', 'susan0402@gmail.com', '0374484861', TO_DATE('10/01/2017', 'dd/mm/yyyy'), TO_DATE('02/11/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (103, 'LeoDaniel1812', 'Leo1812', 3, 'Leo', 'Daniel', 'leo1812@gmail.com', '0865657853', TO_DATE('10/01/2017', 'dd/mm/yyyy'), TO_DATE('10/01/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (104, 'DorothyBrown0101', 'Dorothy0101', 3, 'Dorothy', 'Brown', 'dorothy0101@gmail.com', '0838893278', TO_DATE('10/01/2017', 'dd/mm/yyyy'), TO_DATE('25/06/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (105, 'ColeSimon0708', 'Cole0708', 3, 'Cole', 'Simon', 'cole0708@gmail.com', '0398152716', TO_DATE('11/01/2017', 'dd/mm/yyyy'), TO_DATE('11/01/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (106, 'DannaBell1215', 'Danna1215', 3, 'Danna', 'Bell', 'danna1215@gmail.com', '0386342964', TO_DATE('12/01/2017', 'dd/mm/yyyy'), TO_DATE('02/12/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (107, 'JohnnyMatthews0307', 'Johnny0307', 2, 'Johnny', 'Matthews', 'johnny0307@gmail.com', '0547699254', TO_DATE('12/01/2017', 'dd/mm/yyyy'), TO_DATE('12/01/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (108, 'CarlosPatterson0812', 'Carlos0812', 3, 'Carlos', 'Patterson', 'carlos0812@gmail.com', '0857566586', TO_DATE('12/01/2017', 'dd/mm/yyyy'), TO_DATE('15/08/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (109, 'LaurenBaker1212', 'Lauren1212', 3, 'Lauren', 'Baker', 'lauren1212@gmail.com', '0785565443', TO_DATE('13/01/2017', 'dd/mm/yyyy'), TO_DATE('22/04/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (110, 'LiamLong0710', 'Liam0710', 3, 'Liam', 'Long', 'liam0710@gmail.com', '0843389693', TO_DATE('13/01/2017', 'dd/mm/yyyy'), TO_DATE('17/11/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (111, 'KenGross0931', 'Ken0931', 3, 'Ken', 'Gross', 'ken0931@gmail.com', '0323879549', TO_DATE('13/01/2017', 'dd/mm/yyyy'), TO_DATE('10/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (112, 'MarioMiles0221', 'Mario0221', 3, 'Mario', 'Miles', 'mario0221@gmail.com', '0594829704', TO_DATE('14/01/2017', 'dd/mm/yyyy'), TO_DATE('14/01/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (113, 'AustinCooper1219', 'Austin1219', 3, 'Austin', 'Cooper', 'austin1219@gmail.com', '0357146619', TO_DATE('14/01/2017', 'dd/mm/yyyy'), TO_DATE('20/05/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (114, 'VickieClark0321', 'Vickie0321', 3, 'Vickie', 'Clark', 'vickie0321@gmail.com', '0541665107', TO_DATE('14/01/2017', 'dd/mm/yyyy'), TO_DATE('09/12/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (115, 'AmberHolland0909', 'Amber0909', 3, 'Amber', 'Holland', 'amber0909@gmail.com', '0832383838', TO_DATE('14/01/2017', 'dd/mm/yyyy'), TO_DATE('12/12/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (116, 'JessicaJenkins0527', 'Jessica0527', 3, 'Jessica', 'Jenkins', 'jessica0527@gmail.com', '0777428778', TO_DATE('14/01/2017', 'dd/mm/yyyy'), TO_DATE('14/08/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (117, 'BrianShaw0303', 'Brian0303', 3, 'Brian', 'Shaw', 'brian0303@gmail.com', '0366765545', TO_DATE('14/01/2017', 'dd/mm/yyyy'), TO_DATE('28/02/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (118, 'LewisFisher0929', 'Lewis0929', 3, 'Lewis', 'Fisher', 'lewis0929@gmail.com', '0843258713', TO_DATE('15/01/2017', 'dd/mm/yyyy'), TO_DATE('02/08/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (119, 'LeonaFord0303', 'Leona0303', 3, 'Leona', 'Ford', 'leona0303@gmail.com', '0354136355', TO_DATE('15/01/2017', 'dd/mm/yyyy'), TO_DATE('20/10/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (120, 'KyleShelton0420', 'Kyle0420', 3, 'Kyle', 'Shelton', 'kyle0420@gmail.com', '0795776836', TO_DATE('15/01/2017', 'dd/mm/yyyy'), TO_DATE('31/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (121, 'GaryMiller0331', 'Gary0331', 3, 'Gary', 'Miller', 'gary0331@gmail.com', '0709433583', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('03/03/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (122, 'JenniferWhite0321', 'Jennifer0321', 3, 'Jennifer', 'White', 'jennifer0321@gmail.com', '0776223633', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('02/10/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (123, 'EmmaStanley0523', 'Emma0523', 3, 'Emma', 'Stanley', 'emma0523@gmail.com', '0967844245', TO_DATE('16/01/2017','dd/mm/yyyy'), TO_DATE('10/07/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (124, 'HarryPotter0213', 'Harry0213', 3, 'Harry', 'Potter', 'harry0213@gmail.com', '0331735631', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('16/01/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (125, 'AndyFrancis1213', 'Andy1213', 2, 'Andy', 'Francis', 'andy1213@gmail.com', '0563711442', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('16/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (126, 'CindyNewton1213', 'CindyNewton1213', 3, 'Cindy', 'Newton', 'cindy1213@gmail.com', '0976153164', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('10/12/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (127, 'LunaWatkins0731', 'Luna0731', 3, 'Luna', 'Watkins', 'luna0731@gmail.com', '0917559436', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('23/09/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (128, 'JulieRivera1203', 'Julie1203', 3, 'Julie', 'Rivera', 'julie1203@gmail.com', '0885167811', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('15/08/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (129, 'PeterBennett0423', 'Peter0423', 3, 'Peter', 'Bennett', 'peter0423@gmail.com', '0994854842', TO_DATE('16/01/2017', 'dd/mm/yyyy'), TO_DATE('15/09/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (130, 'AaronJenkins0413', 'Aaron0413', 3, 'Aaron', 'Jenkins', 'aaron0413@gmail.com', '0797520745', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('17/11/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (131, 'EliHughes0729', 'Eli0729', 3, 'Eli', 'Hughes', 'eli0729@gmail.com', '0931984799', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('10/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (132, 'IsabelLopez0324', 'Isabel0324', 3, 'Isabel', 'Lopez', 'isabel0324@gmail.com', '0592363665', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('14/02/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (133, 'DanCampbell0112', 'Dan0112', 3, 'Dan', 'Compbell', 'dan0112@gmail.com', '0768267331', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('14/05/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (134, 'SamBrown0409', 'Sam0409', 3, 'Sam', 'Brown', 'sam0409@gmail.com', '0585243643', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('19/03/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (135, 'WarrenParks0213', 'Warren0213', 3, 'Warren', 'Parks', 'warren0213@gmail.com', '0866735258', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('07/07/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (136, 'ErikSimon0223', 'Erik0223', 3, 'Erik', 'Simon', 'erik0223@gmail.com', '0762128893', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('14/08/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (137, 'TiffanyLee0329', 'Tiffany0329', 3, 'Tiffany', 'Lee', 'tiffany0329@gmail.com', '0353408161', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('25/06/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (138, 'KathleenYoung0203', 'Kathleen0203', 3, 'Kathleen', 'Young', 'kathleen0203@gmail.com', '0929739386', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('02/07/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (139, 'EthanGibson0204', 'Ethan0204', 3, 'Ethan', 'Gibson', 'ethan0204@gmail.com', '0837653876', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('20/11/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (140, 'ConnorRussell0707', 'Connor0707', 3, 'Connor', 'Russell', 'connor0707@gmail.com', '0847076840', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('31/03/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (141, 'JulianFoster0306', 'Julian0306', 3, 'Julian', 'Foster', 'julian0306@gmail.com', '0382961738', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('02/03/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (142, 'GlenHamilton0103', 'Glen0103', 3, 'Glen', 'Hamilton', 'glen0103@gmail.com', '0367315232', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('30/11/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (143, 'AntonioGriffin0506', 'Antonio0506', 3, 'Antonio', 'Griffin', 'antonio0506@gmail.com', '0938536713', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('27/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (144, 'ChrystaFisher1215', 'Chrysta1215', 3, 'Chrysta', 'Fisher', 'chrysta1215@gmail.com', '0761794447', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('15/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (145, 'JanetGordon0220', 'Janet0220', 3, 'Janet', 'Gordon', 'janet0220@gmail.com', '0788629326', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('06/04/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (146, 'RileyBaker0430', 'Riley0430', 3, 'Riley', 'Baker', 'riley0430@gmail.com', '0919385133', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('08/04/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (147, 'VeraAdams0501', 'Vera0501', 3, 'Vera', 'Adams', 'vera0501@gmail.com', '0352431286', TO_DATE('17/01/2017', 'dd/mm/yyyy'), TO_DATE('26/08/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (148, 'TeresaButler0405', 'Teresa0405', 3, 'Teresa', 'Butler', 'teresa0405@gmail.com', '0981574681', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('25/05/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (149, 'HectorBailey0607', 'Hector0607', 3, 'Hector', 'Bailey', 'hector0607@gmail.com', '0863621469', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('22/09/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (150, 'KingstonMartinez1223', 'Kingston1223', 3, 'Kingston', 'Martinez', 'kingston1223@gmail.com', '0394173947', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('29/11/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (151, 'AlexisBell0219', 'Alexis0219', 3, 'Alexis', 'Bell', 'alexis0219@gmail.com', '0352422336', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('28/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (152, 'ScottTucker0728', 'Scott0728', 3, 'Scott', 'Tucker', 'scott0728@gmail.com', '0776847564', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('13/11/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (153, 'MartinHicks1214', 'Martin1214', 3, 'Martin', 'Hicks', 'martin1214@gmail.com', '0776436185', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('20/08/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (154, 'AshleyFlores0925', 'Ashley0925', 3, 'Ashley', 'Flores', 'ashley0925@gmail.com', '0844116851', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('09/05/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (155, 'ValentinaSanders0301', 'Valentina0301', 3, 'Valentina', 'Sanders', 'vallentina0301@gmail.com', '0709666414', TO_DATE('18/01/2017', 'dd/mm/yyyy'), TO_DATE('12/02/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (156, 'JulianaBryant0514', 'Juliana0514', 3, 'Juliana', 'Bryant', 'juliana0514@gmail.com', '0886431282', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('29/08/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (157, 'KatelynnCox0216', 'Katelynn0216', 3, 'Katelynn', 'Cox', 'katelynn0216@gmail.com', '0940625657', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('28/07/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (158, 'OlivePeterson0517', 'Olive0517', 3, 'Olive', 'Peterson', 'olive0517@gmail.com', '0915599273', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('31/07/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (159, 'JulieRivera0419', 'Julie0419', 3, 'Julie', 'Rivera', 'julie0419@gmail.com', '0765270619', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('12/10/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (160, 'JoeyEllis0501', 'Joey0501', 3, 'Joey', 'Ellis', 'joey0501@gmail.com', '0822413137', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('24/09/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (161, 'ChaseLucas0202', 'Chase0202', 3, 'Chase', 'Lucas', 'chase0202@gmail.com', '0999339654', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('03/03/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (162, 'KenGross0212', 'Ken0212', 3, 'Ken', 'Gross', 'ken0212@gmail.com', '0564078590', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('02/10/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (163, 'TristanErickson1223', 'Tristan1223', 3, 'Tristan', 'Erickson', 'tristan1223@gmail.com', '0587551931', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('10/07/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (164, 'SaraSherman0405', 'Sara0405', 3, 'Sara', 'Sherman', 'sara0405@gmail.com', '0595120050', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('16/01/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (165, 'TracyJones1112', 'Tracy1112', 3, 'Tracy', 'Jones', 'tracy1112@gmail.com', '0947970519', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('16/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (166, 'MelissaLindsey1113', 'Melissa1113', 3, 'Melissa', 'Lindsey', 'melissa1113@gmail.com', '0926059164', TO_DATE('19/01/2017', 'dd/mm/yyyy'), TO_DATE('10/12/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (167, 'ShirleySimon1225', 'Shirley1225', 3, 'Shirley', 'Simon', 'shirley1225@gmail.com', '0853558977', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('23/09/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (168, 'OwenRodriguez0202', 'Owen0202', 3, 'Owen', 'Rodriguez', 'owen0202@gmail.com', '0906791842', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('15/09/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (169, 'NinaRodriguez1111', 'Nina1111', 3, 'Nina', 'Rodriguez', 'nina1111@gmail.com', '0948350621', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('15/09/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (170, 'VirginiaGarcia0707', 'Virginia0707', 3, 'Virginia', 'Garcia', 'virginia0707@gmail.com', '0991455043', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('17/12/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (171, 'ClaudeReynolds1212', 'Claude1212', 3, 'Claude', 'Reyno', 'claude1212@gmail.com', '0383911016', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('10/01/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (172, 'TraceyWarren0909', 'Tracey0909', 3, 'Tracey', 'Warren', 'tracey0909@gmail.com', '0973532344', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('14/02/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (173, 'MollyJordan0616', 'Molly0616', 3, 'Molly', 'Jordan', 'molly0616@gmail.com', '0927897995', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('12/05/2017','dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (174, 'HarveyFord0414', 'Harvey0414', 3, 'Harvey', 'Ford', 'harvey0414@gmail.com', '0787492787', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('29/03/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (175, 'TristinClawford0717', 'Tristin0717', 3, 'Tristin', 'Clawford', 'tristin0717@gmail.com', '0382187946', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('17/07/2017', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (176, 'FrancescaClawford1212', 'Francesca1212', 3, 'Francesca', 'Clawford', 'francesca1212@gmail.com', '0595652456', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('16/06/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (177, 'HaroldSimmons0919', 'Harold0919', 3, 'Harold', 'Simmons', 'harold0919@gmail.com', '0814795109', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('22/09/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (178, 'AidanButler1121', 'Aidan1121', 3, 'Aidan', 'Butler', 'aidan1121@gmail.com', '0945634445', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('04/07/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (179, 'SabrinaMcdonald1213', 'Sabrina1213', 3, 'Sabrina', 'Mcdonald', 'sabrina1213@gmail.com', '0342282107', TO_DATE('20/01/2017', 'dd/mm/yyyy'), TO_DATE('20/06/2018', 'dd/mm/yyyy'));
insert into USER_INFO (userID, userName, password, role, firstName, lastName, email, phoneNumber, createdDate, modifiedDate)
values (180, 'CarolinaGomez0517', 'Carolina0517', 3, 'Carolina', 'Gomez', 'carolina0517@gmail.com', '0827063416', TO_DATE('21/01/2017', 'dd/mm/yyyy'), TO_DATE('13/03/2018', 'dd/mm/yyyy'));

/* Data for table BRAND */
insert into BRAND (brandID, brandName) values (11, 'Toshiba');
insert into BRAND (brandID, brandName) values (12, 'Sony');
insert into BRAND (brandID, brandName) values (13, 'Samsung');
insert into BRAND (brandID, brandName) values (14, 'Apple');
insert into BRAND (brandID, brandName) values (15, 'Oppo');
insert into BRAND (brandID, brandName) values (16, 'Xiaomi');
insert into BRAND (brandID, brandName) values (17, 'Snickers');
insert into BRAND (brandID, brandName) values (18, 'Kit Kat');
insert into BRAND (brandID, brandName) values (19, 'Oreo');
insert into BRAND (brandID, brandName) values (20, 'UPS');
insert into BRAND (brandID, brandName) values (21, 'Dove');
insert into BRAND (brandID, brandName) values (22, 'Vaseline');
insert into BRAND (brandID, brandName) values (23, 'Colgate');
insert into BRAND (brandID, brandName) values (24, 'Neutrogena');
insert into BRAND (brandID, brandName) values (25, 'Nike');
insert into BRAND (brandID, brandName) values (26, 'Canon');
insert into BRAND (brandID, brandName) values (27, 'Adidas');
insert into BRAND (brandID, brandName) values (28, 'LG');
insert into BRAND (brandID, brandName) values (29, 'HP');
insert into BRAND (brandID, brandName) values (30, 'Dell');
insert into BRAND (brandID, brandName) values (31, 'Acer');
insert into BRAND (brandID, brandName) values (32, 'Panasonic');
insert into BRAND (brandID, brandName) values (33, 'Asus');
insert into BRAND (brandID, brandName) values (34, 'Huggies');
insert into BRAND (brandID, brandName) values (35, 'Pampers');
insert into BRAND (brandID, brandName) values (36, 'Johnson and Johnson');
insert into BRAND (brandID, brandName) values (37, 'Appaman');

/* Data for table METHOD_CHECKOUT */
insert into METHOD_CHECKOUT (methodCheckoutID, methodCheckOutName) values (01, 'Credit Cards');
insert into METHOD_CHECKOUT (methodCheckoutID, methodCheckOutName) values (02, 'Mobile Payments');
insert into METHOD_CHECKOUT (methodCheckoutID, methodCheckOutName) values (03, 'Bank Transfers');
insert into METHOD_CHECKOUT (methodCheckoutID, methodCheckOutName) values (04, 'Ewallets');
insert into METHOD_CHECKOUT (methodCheckoutID, methodCheckOutName) values (05, 'Prepaid Cards');
insert into METHOD_CHECKOUT (methodCheckoutID, methodCheckOutName) values (06, 'Cash');

/* Data for table PRODUCT_CATEGORY */
insert into PRODUCT_CATEGORY(productCategoryID, productCategoryName) values (21, 'Electronic Devices');
insert into PRODUCT_CATEGORY(productCategoryID, productCategoryName) values (22, 'Electronic Accessories');
insert into PRODUCT_CATEGORY(productCategoryID, productCategoryName) values (23, 'TV and Home Appliances');
insert into PRODUCT_CATEGORY(productCategoryID, productCategoryName) values (24, 'Health and Beauty');
insert into PRODUCT_CATEGORY(productCategoryID, productCategoryName) values (25, 'Babies and Toys');
insert into PRODUCT_CATEGORY(productCategoryID, productCategoryName) values (26, 'Women''s Fashsion');
insert into PRODUCT_CATEGORY(productCategoryID, productCategoryName) values (27, 'Men''s Fashsion');

/* Data for table PRODUCT */
insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (111, 21, 013, 'Samsung S10 PLUS', 21990000, 'C:\Local\ImageDir\Samsung_S10_PLUS.jpg', 
'The Galaxy S10 Plus is Samsung''s new ''everything phone'' for 2019, helping disrupt the sameness of the last few 
generations of handsets. Its 6.4-inch screen is so big it displaces the front camera, while its triple-lens rear camera 
can take ultra-wide photos. Hidden perks like an in-screen fingerprint sensor and Wireless PowerShare offer a lot of nifty 
features – just know Samsung is asking for a lot of money, too.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (112, 21, 013, 'Samsung Galaxy Note 5', 4000000, 'C:\Local\ImageDir\Samsung_Galaxy_Note5.jpg', 
'Bigger has always been better. Galaxy Note proved that time and again. It also changed the entire game with S Pen. 
A versatile tool for ideas, goals and dreams. This time it''s Galaxy Note5. The most powerful and beautiful version to date.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (113, 21, 013, 'Samsung Galaxy A50 SM-A505G 64GB 4GB RAM 25 MP 6.4" Factory Unlocked International Version', 5453997.50, 
'C:\Local\ImageDir\SamsungGalaxyA50.jpg', 
'The Samsung galaxy A50 is a complete device that provides for a onscreen fingerprint sensor along with the 6.4-inch (16.21 
centimeters) super AMOLED - infinity u cut display, FHD+ resolution (2340 x 1080), 404 ppi with 16m colours and triple camera
setup - 16mp (f1.9)+ 5mp (2.2) wide angle camera + 5mp (2.2) with flash and 25mp (f2.0) front facing camera. May come with 
foreign charger. charger may be foreign');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (114, 21, 013, 'Samsung Galaxy A10 32GB (A105M) 6.2" HD+ Infinity-V 4G LTE Factory Unlocked GSM Smartphone', 3016872.92, 
'C:\Local\ImageDir\SamsungGalaxyA10.jpg', 
'32GB Storage Unlocked 6.2" Display Android v9.0');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (115, 21, 013, 'Samsung G. Note 9 N960', 22990000, 'C:\Local\ImageDir\SamsungGNote9N960.jpg', 
'Powerful, 4000mAh battery. Store more, delete less with 128GB storage. All new Bluetooth enabled S Pen.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (116, 21, 013, 'Samsung Galaxy A70', 7429000, 'C:\Local\ImageDir\SamsungGalaxyA70.jpg', 
'Released 2019, April, 183g, 7.9mm thickness, Android 9.0, One UI 128GB storage, microSD slot');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (117, 21, 013, 'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone 12MP Camera', 11604017.92, 
'C:\Local\ImageDir\SamsungGalaxyS9.jpg', 
'Introducing the revolutionary Galaxy S9. The phone that reimagines the camera. And in doing so reimagines everything 
you can do, too.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (118, 21, 013, 'Galaxy Note10 256GB', 22047842.92, 'C:\Local\ImageDir\GalaxyNote10_256GB.jpg', 
'Intelligent power that learns from how you work and play to optimize battery life.
With nearly invisible bezels, Galaxy Note10''s cinema-quality display elevates everything you watch.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (119, 21, 013, 'Galaxy Note10+ 256GB', 25529117.92, 'C:\Local\ImageDir\GalaxyNote10+_256GB.jpg', 
'An all-day battery that intelligently powers every scroll, click, call, tap, playlist and season finale you can throw at it.
With nearly invisible bezels, Galaxy Note10+''s cinema-quality display elevates everything you watch.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (120, 21, 013, 'Galaxy Note10+ 512GB', 27849967.92, 'C:\Local\ImageDir\GalaxyNote10+_512GB.jpg', 
'An all-day battery that intelligently powers every scroll, click, call, tap, playlist and season finale you can throw at it.
With nearly invisible bezels, Galaxy Note10+''s cinema-quality display elevates everything you watch.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (121, 21, 014, 'Apple iPhone 11', 31990000, 'C:\Local\ImageDir\Apple_iPhone_11.jpg', 
'The iPhone 11 succeeds the iPhone XR, and it features a 6.1-inch LCD display that Apple calls a "Liquid Retina HD Display." 
It features a 1792 x 828 resolution at 326ppi, a 1400:1 contrast ratio, 625 nits max brightness, True Tone support for 
adjusting the white balance to the ambient lighting, and wide color support for true-to-life colors.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (122, 21, 014, 'Apple iPhone XR 64GB', 12850314.37, 'C:\Local\ImageDir\Apple_iPhone_XR64GB.jpg', 
'Only iPhone no other phone is like iPhone. Only when hardware and software are designed together can they truly work together. 
Apple teams design The world’s best products, with the most innovative displays, chips, cameras, operating systems, and 
services.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (123, 21, 014, 'Apple iPhone 8 64GB', 8443020.22, 'C:\Local\ImageDir\Apple_iPhone864GB.jpg', 
'iPhone 8 introduces an all?new glass design. The world’s most popular camera, now even better. The most powerful and smartest 
chip ever in a smartphone. Wireless charging that’s truly effortless. And augmented reality experiences never before possible. 
iPhone 8. A new generation of iPhone.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (124, 21, 014, 'Apple iPhone 6 16GB', 3945212.92, 'C:\Local\ImageDir\Apple_iPhone616GB.jpg', 
'This update to the popular iPhone 6 adds 3D Touch control which lets users deliberately choose between a light tap, a press, 
and a "deeper" Press, triggering a range of specific controls. Other notable additions include the Apple A9 Chipset, and a 
12MP rear camera with 4K resolution video recording.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (125, 21, 014, 'Apple iPhone 7 32GB', 4873552.92, 'C:\Local\ImageDir\Apple_iPhone732GB.jpg', 
'iPhone 7 dramatically improves the most important aspects of the iPhone experience. It introduces advanced new camera 
systems. The best performance and battery life ever in an iPhone. Immersive stereo speakers. The brightest, most colorful 
iPhone display. Splash and water resistance. And it looks every bit as powerful as it is. This is iPhone 7. iPhone 7 reaches 
a new level of innovation and precision.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (126, 21, 028, 'Laptop HP Pavilion', 15650000, 'C:\Local\ImageDir\Laptop_HP_Pavilion.jpg', 
'Power through your day with a stylish laptop created to keep you connected, and on top of everyday tasks. 
With reliable performance and long lasting battery life - you can easily surf, stream and stay in touch with what matters 
most.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (127, 21, 028, 'HP 2019 Newest Premium 15.6-inch HD Laptop', 8923668.25, 'C:\Local\ImageDir\HP2019_NewestPremium.jpg', 
'This listing has upgraded configurations for RAM, the manufacturer box is opened for it to be tested and inspected and to 
install the upgrades to achieve the specifications as advertised. Defects and blemishes are significantly reduced by our in 
depth inspection and testing.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (128, 21, 028, 'HP Chromebook 11 G4 11.6 Inch Laptop (Intel N2840 Dual-Core, 2GB RAM, 16GB Flash SSD, Chrome OS)', 
2320617.92, 'C:\Local\ImageDir\HPChromebook11G4.jpg', 
'Operating system: Chrome OS Processor family: Intel Celeron processor Processor: Intel Celeron N2840 with Intel HD Graphics 
(2.16 GHz, up to 2.58 GHz, 1 MB cache, 2 cores) Chipset: Chipset is integrated with processor Memory: 2 GB DDR3L-1600 SDRAM 
(2 GB onboard) Internal drive: 16 GB eMMC Display: 11.6" diagonal HD SVA WLED anti-glare (1366 x 768) Graphics: Intel HD 
Graphics integrated on processor Ports: 1 USB 3.0; 1 USB 2.0;');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (129, 21, 030, 'Laptop Dell Inspiron 5482 C4TI7007W Core i7-8565U/ Win10 (14 inch FHD IPS Touch)', 24099000 , 
'C:\Local\ImageDir\LaptopDellInspiron5482.jpg', 
'Available with Windows 10 Home or Windows 10 Pro – get the best combination of Windows features you know and new 
improvements you’ll love.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (130, 21, 030, 'Dell I3565-A453BLK-PUS Laptop (Windows 10 Home, AMD Dual-Core A6-9220, 15.6" LCD Screen, Storage: 500 GB, RAM: 4 GB)', 
6682887.58 , 'C:\Local\ImageDir\DellI3565_A453BLK_PUS_Laptop.jpg', 
'15.6" display: Bright View glossy screen maintains the vivid colors in your photos and videos. Typical 1366 x 768 HD 
resolution. WLED backlight. AMD Dual-Core A6-9200 Processor 2.50GHz, up to 2.90 GHz. 4GB system memory for basic 
multitasking: Adequate high-bandwidth RAM to smoothly run multiple applications and browser tabs all at once.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (131, 21, 031, 'Acer Aspire 5 Slim Laptop, 15.6 inch Full HD IPS Display, AMD Ryzen 3 3200U', 
7193242.49 , 'C:\Local\ImageDir\Acer_Aspire5_SlimLaptop.jpg', 
'Powerful and portable, the Aspire 5 laptop delivers on every aspect of everyday computing. Housing the AMD Ryzen 3 3200U 
Mobile Processor, this Aspire 5 can tackle any job no matter how complex.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (132, 21, 031, 'Acer Aspire E 15, 15.6" Full HD, 8th Gen Intel Core i3-8130U, 6GB RAM Memory, 1TB HDD, 8X DVD, E5-576-392H', 
7131275.80 , 'C:\Local\ImageDir\AcerAspireE15.jpg', 
'The new Aspire E Series laptops provide a comprehensive range of choices for every-day users, with many appealing features 
and an attractive design. Incredible performance, fast 802.11ac wireless with new MU-MIMO technology and great battery life 
make the Aspire E series shine in any situation.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (133, 21, 033, 'Asus Chromebook C425 Clamshell Laptop, 14 inch FHD 4-Way NanoEdge', 
8818997.92 , 'C:\Local\ImageDir\AsusChromebookC425_ClamshellLaptop.jpg', 
'ASUS Chromebook C425 is styled for today, with a metallic premium design that is finished with elegant diamond-cut edges. 
Thanks to the slim-bezel NanoEdge design, C425 has 14-inch screen with a compact 13-inch body so you’ll never have to leave 
it behind when you''re on-the-go.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (134, 21, 033, 'ASUS VivoBook 15 Thin and Light Laptop, 15.6 inch FHD', 
9283167.92 , 'C:\Local\ImageDir\ASUSVivoBook15_ThinandLightLaptop.jpg', 
'Whether at work or play, ASUS VivoBook 15 is the compact laptop that immerses you in whatever you set out to do. 
Its new frameless four-sided NanoEdge display boasts an ultraslim 5.7mm bezel, giving an amazing 88% screen-to-body ratio 
for supremely immersive visuals.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (135, 21, 014, 'New Apple MacBook Air (13-inch, 1.6GHz dual-core Intel Core i5, 8GB RAM, 128GB)', 
20887417.92 , 'C:\Local\ImageDir\AppleMacBookAir_13inch.jpg', 
'13.3-inch (diagonal) LED-backlit display with IPS technology; 2560-by-1600 native resolution at 227 pixels per inch with 
support for millions of colors; True Tone technology');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (136, 21, 014, 'Apple MacBook Pro 13.3-Inch Laptop 2.6GHz (MGX82LL/A) Retina, 8GB Memory, 256GB Solid State Drive', 
14505080.42 , 'C:\Local\ImageDir\AppleMacBookPro_13.3-Inch.jpg', 
'The MacBook Pro "Core i5" 2.6 13-Inch (Mid-2014 Retina Display) features a 22 nm "Haswell" 2.6 GHz Intel "Core i5" processor 
(4278U), with dual independent processor "cores" on a single silicon chip, a 3 MB shared level 3 cache, 8 GB of onboard 
1600 MHz DDR3L SDRAM (which could be upgraded to 16 GB at the time of purchase, but cannot be upgraded later), 256 GB of 
PCIe-based flash storage, and an integrated Intel Iris 5100 graphics processor that shares memory with the system.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (137, 21, 014, 'Apple MacBook Pro MD101LL/A 13.3-inch Laptop Intel Core i5 2.5Ghz, 8GB RAM, 512GB SSD', 
11719828.33 , 'C:\Local\ImageDir\AppleMacBookProMD101LL/A_13.3-inchLaptop.jpg', 
'MacBook Pro is machined from a single piece of aluminum, an engineering breakthrough that replaced many parts with just one. 
It''s called the unibody. And the first time you pick up a MacBook Pro, you''ll notice the difference it makes. The entire 
enclosure is thinner and lighter than other notebooks. It looks polished and refined. And it feels strong and durable - 
perfect for life inside (and outside) your briefcase or backpack.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (138, 21, 026, 'Canon EOS M50 Compact System Camera', 13990000, 'C:\Local\ImageDir\Canon_EOS_M50.jpg', 
'This entry in Canon''s renowned range of M series mirrorless cameras features 4K UHD capability for stunning movie footage, 
a Vari-angle touch screen so you can shoot dynamically and creatively, all driven by the power of Canon''s DIGIC 8 processor.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (139, 21, 014, 'Apple Watch Series 5 GPS Only', 11597000, 'C:\Local\ImageDir\AppleWatch_Series5_GPSOnly.jpg', 
'With the new Always-On Retina display, you always see the time and your watch face.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (140, 22, 013, 'Ram samsung 8GB REG ECC', 350000, 'C:\Local\ImageDir\RAM_Samsung8GB_REG_ECC.jpg', 
'The Samsung 8GB DDR4 2133MHz ECC Registered RAM product is a specialized product used for high-performance desktops. 
For strong performance, at an affordable price.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (141, 22, 030, 'PIN Laptop DELL Vostro Inspiron', 320000, 'C:\Local\ImageDir\Laptop_HP_Pavilion.jpg', 
'Compatible Part Numbers: 312-0543, 312-0584, 451-10516, FT079, FT080, FT092.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (142, 23, 011, 'Smart Tivi LED Toshiba 40 inch 40L5650', 5599000, 'C:\Local\ImageDir\SmartTiviLED_Toshiba40inch.jpg', 
'40 inch 40L5650 contributes to create impressive accents for your interior space, with sophisticated design, elegant, 
thin screen borders and a solid V-stand. With 40 inch size, you can place in small and medium spaces such as meeting rooms, 
living rooms, bedrooms.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (143, 23, 011, 'Smart Tivi Toshiba 58 inch 4K UHD 58U7880', 14990000, 'C:\Local\ImageDir\SmartTiviToshiba_58inch4KUHD.jpg', 
'Toshiba 58 inch 4K UHD Smart TV 58U7880 has a sophisticated and advanced design that makes your family entertainment space 
become the focus of attention. The extremely strong base and made of high quality metal create a modern and powerful TV.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (144, 23, 012, 'Android TV Sony 4K 65 inch KD-65S8500D', 36890000, 'C:\Local\ImageDir\AndroidTVSony4K65inch.jpg', 
'Operating System, GUI: Android TV. Resolution: Ultra HD 4K. Screen: 65 inch. HDMI: 4 slots, USB: 3 slots');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (145, 23, 013, 'Smart Tivi Samsung 49 inch UHD 4K UA49NU7100KXXV', 9190000, 
'C:\Local\ImageDir\SmartTiviSamsung_49inchUHD4K.jpg', 
'Samsung 49 inch UHD 4K Smart TV UA49NU7100KXXV has a sophisticated and modern design with a delicate thin screen, 
exudes luxurious yet modern beauty, in harmony with any space in your room. 3 ultra-thin edges help focus the eyes on every 
detail in every frame, providing an experience that covers all senses.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (146, 23, 028, 'Smart Tivi OLED LG 55 inch 4K UHD 55B8PTA', 26990000, 
'C:\Local\ImageDir\SmartTiviOLED_LG55inch_4KUHD55B8PTA.jpg', 
'LG 55 inch 4K UHD 55B8PTA Smart TV has an innovative, neat borderless design, durable aluminum alloy outer shell 
and ultra-thin screen that brings elegance and sophistication to the room space. Besides, the sturdy base helps the product 
stand firmly on many surfaces, you can comfortably arrange the TV in any space you love.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (147, 23, 028, 'Horizontal Door Washer Inverter LG FC1408S4W2 (8kg)', 7669000 , 
'C:\Local\ImageDir\HorizontalDoorWasherInverterLG8KG.jpg', 
'With modern inverter direct drive motor, washing machine LG FC1408S4W2 for smooth operation, minimize noise, you can be 
completely assured because the washing machine will not make a loud noise for the washing machine, even thought operated at 
night. In addition, Inverter technology also helps limit optimal power consumption, helping your family save electricity 
costs per month.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (148, 23, 028, 'Front-Load Washing Machine Inverter LG FC1409D4E (9kg)', 12779000, 
'C:\Local\ImageDir\FrontLoad_WashingMachine_InverterLG9KG.jpg', 
'LG FC1409D4E Front Load Dryer (9kg) has the function of drying up to 5 kg, laundry will be dried quickly, softer and 
reduce wrinkles effectively.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (149, 23, 028, 'Washing Machine On Door Inverter LG T2108VSPW (8kg)', 4590000, 
'C:\Local\ImageDir\WashingMachineOnDoor_InverterLG8KG.jpg', 
'LG Top Door Washer LG T2108VSPW is a top-loading washing machine with luxurious white shell design with powder coating metal 
and high-strength stainless steel, washing bucket, along with its glossy edges also help cleaning is made easier.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (150, 24, 024, 'Neutrogena Bright Boost Brightening Gel Moisturizing Face Cream with Neoglucosamine', 463937.92, 
'C:\Local\ImageDir\Gel_Moisturizing_Face_Cream.jpg', 
'Our best brightening face cream visibly reduces dullness and dark spots for smooth skin. Improves look of tone, texture, 
fine lines in 1 week. Made with Neoglucosamine, AHA, PHA to brighten and resurface.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (151, 24, 024, 'Neutrogena Bright Boost Resurfacing Micro Face Polish with Glycolic and Mandelic AHAs', 185435.92, 
'C:\Local\ImageDir\Resurfacing_Micro_Face.jpg', 
'Our best face polish exfoliates skin and removes skin aging dullness with 3x the polishing power of a normal scrub. 
Formulated with naturally-derived skin smoothers and Glycolic and Mandelic AHAs.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (152, 24, 024, 'Neutrogena Bright Boost Illuminating Serum with Neoglucosamine® and Turmeric Extract', 463937.92, 
'C:\Local\ImageDir\Illuminating_Serum.jpg', 
'Our best brightening face serum, formulated with turmeric extract and Neoglucosamine to visibly improve skin tone, texture and 
clarity. Exfoliates and reduces appearance of dark spots and hyperpigmentation.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (153, 24, 024, 'Neutrogena Bright Boost Facial Moisturizer with SPF 30 and Neoglucosamine', 463937.92, 
'C:\Local\ImageDir\Facial_Moisturizerwith_SPF30.jpg', 
'Our best sheer brightening moisturizer with broad spectrum sunscreen SPF 30 protects skin while improving tone and texture. 
It is formulated with Moringa Seed, Vitamin C, Vitamin E and Neoglucosamine.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (154, 25, 036, 'Baby Shampoo', 46184.92, 'C:\Local\ImageDir\Baby_Shampoo.jpg', 
'We know baby''s delicate hair needs special care during bath time. That''s why our baby shampoo, is specially designed to 
gently cleanse baby''s fine hair and delicate scalp. This baby shampoo cleanses gently and rinses easily, leaving your baby''s 
hair soft, shiny, manageable and clean while maintaining a fresh smell.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (155, 25, 036, 'Baby Powder', 32956.07 , 'C:\Local\ImageDir\Baby_Powder.jpg', 
'Our baby powder keeps skin comfortable, dry and feeling soft. With a clean, classic scent, this baby powder formula glides 
over your baby’s skin and leaves it feeling delicately soft and dry while providing soothing comfort.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (156, 26, 027, 'ULTIMATE INCL BRA', 1508552.50, 'C:\Local\ImageDir\ULTIMATE_INCL_BRA.jpg', 
'This sports bra has been designed specifically to help you tackle total body workouts with confidence and comfort, 
featuring a mesh lining for increased coverage and an adjustable strap to find the perfect fit, just for you.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (157, 26, 027, 'SOLAR RIDE SHOES', 2320850, 'C:\Local\ImageDir\SOLAR_RIDE_SHOES.jpg', 
'These shoes provide flexibility and support for daily distance running. They have a breathable mesh upper and springy 
cushioning for a comfortable ride.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (158, 27, 025, 'Air Jordan 1 Low', 2779000, 'C:\Local\ImageDir\AirJordan1Low.jpg', 
'Inspired by the original that debuted in 1985, the Air Jordan 1 Low offers a clean, classic look that''s familiar yet 
always fresh. It''s made for casual mode, with an iconic design that goes with everything and never goes out of style.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (159, 27, 027, 'FIREBIRD TRACK JACKET', 1856680, 'C:\Local\ImageDir\FIREBIRD_TRACK_JACKET.jpg', 
'Inspired by adidas heritage, Adicolor is authentic but modern. The Firebird Track Jacket is an adidas icon. This version 
is made of a lightweight tricot fabric with a smooth, shiny look.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (160, 24, 018, 'KitKat Ruby Cocoa Beans (3 x 41,5g)', 259935.20, 'C:\Local\ImageDir\KitKat_Ruby_Cocoa_Beans.jpg', 
'Statements regarding dietary supplements have not been evaluated by the FDA and are not intended to diagnose, treat, cure, 
or prevent any disease or health condition.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (161, 24, 018, 'Kit Kat Matcha (green tea) 12 sheets X2 bag set', 301246.33, 'C:\Local\ImageDir\KitKat_Matcha.jpg', 
'[Please read "Notes" prior to consuming this product] Please carefully read all allergy alerts and content details before 
purchasing. We assume no responsibility whatever for any food allergy reactions or incidents resulting from the use of this 
product.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (162, 24, 018, 'Kit Kat Japanese original taste Mini Adult Sweetness 6 Bags Set Japan', 1157639.98, 
'C:\Local\ImageDir\KitKat_Japanese_original.jpg', 'Ship from Japan.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (163, 24, 018, 'KIT KAT Snack Size Wafer Bars, 20.1 oz - 2 Pack', 1275307.08, 
'C:\Local\ImageDir\KITKAT_SnackSize_WaferBars.jpg', 
'Ensure you have enough KIT KAT Wafer Bars for every trick-or-treater! These individually wrapped candy bars are perfect 
for Halloween, harvest candy bowls, and everyday snacking.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (164, 24, 018, 'Kit Kat Japanese Mini Raspberry', 185435.92, 'C:\Local\ImageDir\KitKat_Japanese_MiniRaspberry.jpg', 
'Rare Japanese Kit Kat Mini Raspberry 12 pc per bag');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (165, 24, 019, 'Oreo Chocolate Sandwich Cookies - 30 Lunch Snack Pack (120 Cookies Total)', 475774.25, 
'C:\Local\ImageDir\Oreo_Chocolate_Sandwich_Cookies.jpg', 'Oreo Chocolate Sandwich cookies, 1.59 Ounce (Pack of 30)');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (166, 24, 019, 'Golden Oreo Sandwich Cookies Party Size Package, 25.5 Ounce', 106294.93, 
'C:\Local\ImageDir\Golden_Oreo_Sandwich_Cookies.jpg', 
'Wonderfilled Oreo is milk''s favorite cookie, and people aren''t far behind. Whether you''re craving the classic taste of 
childhood or wanting to delight in fun new flavors, there''s an Oreo Sandwich Cookie waiting to tease your taste buds.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (167, 24, 019, 'Oreo Strawberry Cheesecake 154g x 2', 185435.92, 'C:\Local\ImageDir\Oreo_Strawberry_Cheesecake.jpg', 
'Ingredients Wheat Flour, Sugar, Palm Oil, Rapeseed Oil, Fat-Reduced Cocoa Powder 4,5 %, Wheat Starch, Glucose-Fructose 
Syrup, Raising Agents (Potassium Carbonates, Ammonium Carbonates, Sodium Carbonates), Salt, Emulsifiers (Soya Lecithin, 
Sunflower Lecithin), Red Beet Juice Concentrate, Flavourings.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (168, 24, 019, 'Oreo O''s Cereal 500g (1.1 lb) South Korea', 649838, 'C:\Local\ImageDir\Oreo_OsCereal.jpg', 
'This product has been manufactured in the same manufacturing facility that used almond, walnut, pecan, peanuts, hazelnut, 
brazil nut, lupin, cashew in other products.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (169, 24, 017, 'SNICKERS Minis Size Chocolate Candy Bars 40-Ounce Bag', 603188.91, 'C:\Local\ImageDir\SNICKERS_MinisSize_ChocolateCandyBars.jpg', 
'Don''t be fooled by their size. SNICKERS Minis Candy Bars pack big chocolate flavor and satisfaction in every bite. Made 
with roasted peanuts, nougat, caramel and milk chocolate, SNICKERS Chocolate Candy Bars are individually wrapped, so they 
are great for piñatas, parties or your candy bowl. The party size stand up bag makes everyone''s favorite chocolate candy 
easy to share at home, in the office or on the go. Make celebrations big and small even more delicious with SNICKERS Minis 
Candy.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (170, 24, 017, 'Snickers Crisp 2x20g (pack of 5)', 347895.42, 'C:\Local\ImageDir\Snickers_Crisp2x20g.jpg', 
'Snickers Crisp 2x20g (pack of 5)');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (171, 24, 017, 'Snickers Candy Bar 2.07 oz', 116738.76, 'C:\Local\ImageDir\SnickersCandyBar.jpg', 
'||Flavor: chocolate ||Perishability: non-perishable ||Package Type: individual item single serving ||Container Material: 
plastic ||Product Weight: 2.070 ||Contains: soy, peanuts, Milk, eggs ||May Contain: tree nuts ||Made in the USA or Imported');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (172, 24, 017, 'Snickers Chocolate Bar - 48g - Pack of 3 (48g x 3 Bars)', 189613.44, 'C:\Local\ImageDir\SnickersChocolateBar.jpg', 
'Snickers is jam-packed with: Milk chocolate (35%) with soft nougat (14%) and caramel centre (27%) with fresh roasted peanuts 
(24%). A true British chocolate full of energy and peanuts. Suitable for vegetarians. Pack of 3');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (173, 24, 017, 'Snickers Protein Bar', 174063.75, 'C:\Local\ImageDir\SnickersProteinBar.jpg', 
'Snickers Protein Bar, sess than 200 calories and 18g of protein in one bar. One 51g Snickers Protein bar.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (174, 24, 022, 'Vaseline Intensive Care Body Lotion, Aloe Soothe, 20.3 Fl Oz (Pack of 3)', 389206.54, 
'C:\Local\ImageDir\Vaseline_Intensive_CareBody_Lotion.jpg', 
'Made with aloe vera and a special blend of Vaseline Jelly, Vaseline Intensive Care Aloe Soothe Body Lotion helps keep your 
skin looking healthy and fresh.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (175, 24, 022, 'Vaseline 100% Pure Petroleum Jelly Skin Protectant 3.75 oz (Pack of 2)', 131592.20, 
'C:\Local\ImageDir\Vaseline_PurePetroleum_JellySkinProtectant.jpg', 
'Vaseline 100% Pure Petroleum Jelly Skin Protectant 3.75 oz (Pack of 2)');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (176, 24, 022, 'Vaseline Body Lotion, Essential Healing, 20.3 Fl Oz (Pack of 3)', 410094.20, 
'C:\Local\ImageDir\VaselineBodyLotion.jpg', 
'Vaseline Intensive Care Essential Healing Body Lotion provides fast absorbing moisture to give you deeply moisturized, healthy skin.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (177, 25, 034, 'Huggies Little Snugglers Baby Diapers', 652158.85, 
'C:\Local\ImageDir\HuggiesLittleSnugglersBabyDiapers.jpg', 
'Huggies Little Snugglers diapers are specially designed for gentle skin protection. With features like the pocketed-back 
waistband and GentleAbsorb liner that contain and draw the mess away, Little Snugglers help keep your baby’s delicate skin 
clean and healthy.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (178, 25, 035, 'Pampers Baby-Dry Diapers Size 2 112 Count', 563270.30, 
'C:\Local\ImageDir\PampersBaby-DryDiapers.jpg', 
'Welcome to drier nights and Sesame Street dreams! Pampers Baby-Dry diapers are 3x drier* and feature our exclusive Air-Dry 
Channels for up to 12 hours of overnight dryness. They’re crafted of cottony-soft material with 5 layers of protection on 
the inside, and they feature a color-changing Wetness Indicator along with  fun Sesame Street designs on the outside.');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (179, 25, 037, 'Appaman Big Boys'' Two-Piece Classic Mod Suit In Black', 3318815.50, 
'C:\Local\ImageDir\AppamanBigBoys.jpg', 
'The perfect suit to keep your guys looking and feeling cool at any dressier occasion,the pieces can also be broken up and 
worn separately for a dressed down but still put together outfit');

insert into PRODUCT (productID, productCategoryID, brandID, productName, price, image, descriptions)
values (180, 25, 037, 'Appaman Kids Womens Extra Soft Laurel Top', 603188.91, 
'C:\Local\ImageDir\AppamanKidsWomensExtraSoftLaurel.jpg', 
'Appaman Kids'' Size Chart She''ll stand out in snuggly cuteness with the adorable Appaman Kids Extra Soft Laurel Top. 
Superbly-soft and textured faux-fur sweatshirt is lightweight and comfortable for all-day wear.');

/* Data for table COMMENT */
insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (211, 129, 102, TO_TIMESTAMP('20/10/2017 10:25 AM', 'dd/mm/yyyy hh12:mi AM'), 
'I was in need of a laptop and so happy I bought this one. The screen is amazing. 
I love the vivid touch screen display. Very easy to set up. Battery life is adverage. 
Definitely satisfied with this laptop');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (212, 129, 103, TO_TIMESTAMP('21/10/2018 01:42 PM', 'dd/mm/yyyy hh:mi PM'), 
'Wireless card was garbage. Spent 2 hours online with Dell. 
Returned for refund to Amazon the next day. Don''t have time or patience for junk.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (213, 129, 104, TO_TIMESTAMP('21/11/2018 09:39 AM', 'dd/mm/yyyy hh:mi AM'), 
'This computer is fast. The sound is excellent and the display is beautiful!
But the setup instructions were in another language and there was no product key. 
The seller was quick to respond that if I reset the computer, Windows 10 should automatically activate but it didn''t and 
I ended up paying another $119 to activate Windows. Anyway I''m okay with this purchase.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (214, 129, 112, TO_TIMESTAMP('22/11/2019 03:36 PM', 'dd/mm/yyyy hh:mi PM'), 
'Nice computer - lightweight fast and quiet with the SSHD.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (215, 129, 113, TO_TIMESTAMP('22/11/2019 04:00 PM', 'dd/mm/yyyy hh:mi PM'), 
'I like how fast it boots up and the touch screen. I don''t like the mouse pad, but that''s just a personal preference, 
so I will get a wireless mouse for it.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (216, 129, 115, TO_TIMESTAMP('23/11/2019 08:21 AM', 'dd/mm/yyyy hh:mi AM'), 
'I find Dell to be a very decent brand.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (217, 129, 161, TO_TIMESTAMP('23/11/2019 09:30 PM', 'dd/mm/yyyy hh:mi PM'), 
'Dell arrived without Windows 10 installed. Laptop does not run. Have attempted to reach seller 24 hours ago for the 
Windows product key to download without a reply. Very dissatisfied with purchase.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (218, 121, 144, TO_TIMESTAMP('03/10/2019 11:46 PM','dd/mm/yyyy hh:mi PM'), 
'It is not clearly stated that this is a T-mobile phone!');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (219, 121, 175, TO_TIMESTAMP('05/10/2019 08:42 AM', 'dd/mm/yyyy hh:mi AM'), 
'Great phone, but locked to simple mobile! Will NOT work for Verizon or ATT. Returned the phone:(
We returned the phone and after two weeks we still do not have a refund.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (220, 121, 169, TO_TIMESTAMP('06/10/2019 09:39 AM', 'dd/mm/yyyy hh:mi AM'), 
'It''s Tmobile and not sim-free');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (221, 121, 138, TO_TIMESTAMP('09/10/2019 03:36 PM', 'dd/mm/yyyy hh:mi PM'), 
'It''s a good phone just it''s sim locked to a T-Mobile account so unless you already have one you need to set up a 
T-Mobile account but when mine got here it turned out that the SIM card was expired.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (222, 121, 137, TO_TIMESTAMP('12/10/2019 04:00 PM', 'dd/mm/yyyy hh:mi PM'), 
'Have to wait (90 days) for it to unlock its self. Or switch to Verizon.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (223, 121, 115, TO_TIMESTAMP('13/10/2019 08:21 AM', 'dd/mm/yyyy hh:mi AM'), 
'I find Dell to be a very decent brand.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (224, 121, 121, TO_TIMESTAMP('13/10/2019 09:30 AM', 'dd/mm/yyyy hh:mi AM'), 
'It’s great and works great.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (225, 121, 165, TO_TIMESTAMP('13/10/2019 11:59 AM', 'dd/mm/yyyy hh:mi AM'), 
'Never buy this product they won''t send you a SIM card for the phone and it won''t activate with an simple mobile sim. 
The biggest waste of time ever save your time and money.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (226, 121, 126, TO_TIMESTAMP('13/10/2019 05:23 PM', 'dd/mm/yyyy hh:mi PM'), 
'It''s only for new customer at SIMPLE MOBILE. 1 year to unlock to other companies. I returned the unopened box.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (227, 139, 132, TO_TIMESTAMP('14/10/2019 02:21 PM', 'dd/mm/yyyy hh:mi PM'), 
'Watch will not work unless you have a phone with iOS 13. I have a 6 iphone can not up to iOS 13. WOW useless!!');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (228, 139, 126, TO_TIMESTAMP('14/10/2019 06:39 PM', 'dd/mm/yyyy hh:mi PM'), 
'I just got my apple watch and it is such a nice watch. It is packaged so professionally. 
I love how strong the watch band is too. I am older so I need a good face size on my watch and this has a very nice and 
easy to see face. I am learning all the great things it does and plan to take advantage of them. I will be using it at the 
gym especially for my spinning classes.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (229, 139, 112, TO_TIMESTAMP('15/10/2019 03:36 PM', 'dd/mm/yyyy hh:mi PM'), 
'It''s a good phone just it''s sim locked to a T-Mobile account so unless you already have one you need to set up a 
T-Mobile account but when mine got here it turned out that the SIM card was expired.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (230, 139, 141, TO_TIMESTAMP('15/10/2019 05:01 PM', 'dd/mm/yyyy hh:mi PM'), 
'The Series 5 GPS/Cellular 44 watch is of high quality, I installed a screen protector and edge protector, would be nice if 
Apple would just provide those accessories, the band was comfortable. Having a hard time working with Cellular carriers, 
still not working yet on cellular, the sync from Apple to Fitbit app challenges with third-party sync, not working yet. As 
for look and feel of watch, excellent.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (231, 139, 137, TO_TIMESTAMP('15/10/2019 07:32 PM', 'dd/mm/yyyy hh:mi PM'), 
'Great build quality, looks outstanding and just works plus you can track everything form sleep to heart rate to calories! 
It''s awesome.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (232, 139, 146, TO_TIMESTAMP('18/10/2019 08:49 AM', 'dd/mm/yyyy hh:mi AM'), 
'I just bought this to replace my 1st gen watch. It was on its last leg and time to be replaced. Its been a huge upgrade. 
Ive gotten used to the bigger screen (coming from the 38mm model was a bit of a shock). And the new (or at least new to me) 
features of cellular and wifi is a huge plus. I picked up some wireless airpods too so I can still listen to music and books 
on the go.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (233, 139, 129, TO_TIMESTAMP('18/10/2019 12:59 PM', 'dd/mm/yyyy hh:mi PM'), 
'Best smartwatch ever! This is the series 5 so it has the always-on display and then it gets brighter when you bring the 
watch to your attention but you can also turn that feature on and off if you didn''t want it to always be on dimly but it''s 
nice to be able to glance at the time without having to wake it up if you are in a business meeting and you want to casually 
glance at the time.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (234, 139, 127, TO_TIMESTAMP('18/10/2019 09:32 PM', 'dd/mm/yyyy hh:mi PM'), 
'Confused. When I turned it on, it shows that I must place an iPhone next to the watch; I guess to activate it. 
I bought the watch for the health features and to use as a phone. I did not see anything in the fine print explaining this 
requirement. Now, it seems I must find someone with an iPhone to activate it. Bummer!');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (235, 139, 139, TO_TIMESTAMP('21/10/2019 05:01 PM', 'dd/mm/yyyy hh:mi PM'), 
'The Series 5 GPS/Cellular 44 watch is of high quality, I installed a screen protector and edge protector, would be nice if 
Apple would just provide those accessories, the band was comfortable. Having a hard time working with Cellular carriers, 
still not working yet on cellular, the sync from Apple to Fitbit app challenges with third-party sync, not working yet. As 
for look and feel of watch, excellent.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (236, 154, 177, TO_TIMESTAMP('01/12/2019 09:37 AM', 'dd/mm/yyyy hh:mi AM'), 
'Works, I use baby shampoo as a body wash. But, throw the pump away, it spits out tiny squirts and hard to use in the shower.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (237, 154, 142, TO_TIMESTAMP('06/03/2019 02:49 PM', 'dd/mm/yyyy hh:mi PM'), 
'I love this shampoo for my hair, and I am 62. It softens and thickens it. I tried an organic thickening shampoo, and it 
strips my hair, and leaves it thin and limp. This thickens it and nourishes it. Shines it right up. I do not use any dyes 
on my hair. I am very pleased with these HUGE bottles. I get about half this much, in the grocery or pharmacy stores. Thank 
you for one day shipping!');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (238, 154, 133, TO_TIMESTAMP('30/07/2019 07:39 PM', 'dd/mm/yyyy hh:mi PM'), 
'I''m an adult and use this to clean my very sensitive face. It is also a great makeup brush/sponge cleaner. I also 
sometimes use it on my hair but since it''s so thick it takes a lot.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (239, 154, 166, TO_TIMESTAMP('27/08/2019 03:30 PM', 'dd/mm/yyyy hh:mi PM'), 
'I love the product, but the pump was a problem. I use baby shampoo daily to clean my dry eyes and to wash my sensitive skin. 
This shampoo works wonders for me. I get huge bottles because I use a lot of it. The scent of this product strikes me as 
slighty acrid, but i don''t want to use a product with a lot of fragrance. A pump is important when using huge bottles. 
I could not get the pumo to pop up. Then the long cylinder came out.');

insert into COMMENTS (numComment, productID, userID, datetime, contentCmt)
values (240, 154, 148, TO_TIMESTAMP('10/11/2019 11:32 AM', 'dd/mm/yyyy hh:mi AM'), 
'I''ve been using the yellow tint for 20 years and I used to really love it. Never EVER had a problem with irritation. 
In fact, I was using H and S and it gave me terrible dandruff! Since I switched to JandJ I''ve never had another problem with that.
The yellow color was never a problem either. I don''t think I like this so-called ''improvement'' as much. Seems thinner and 
I''m not sure my head is as comfortable as it was before - after I shower.');

/* Data for table BILL */
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (301, 112, 06, 700000, TO_TIMESTAMP('05/08/2019 7:58 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (302, 120, 05, 21990000, TO_TIMESTAMP('05/09/2019 8:00 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (303, 105, 02, 13990000, TO_TIMESTAMP('05/09/2019 9:00 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (304, 132, 04, 27849968, TO_TIMESTAMP('05/09/2019 5:58 PM', 'dd/mm/yyyy hh:mi PM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (305, 108, 01, 1009105, TO_TIMESTAMP('05/09/2019 10:00 PM', 'dd/mm/yyyy hh:mi PM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (306, 140, 03, 1577250, TO_TIMESTAMP('05/09/2019 10:30 PM', 'dd/mm/yyyy hh:mi PM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (307, 140, 03, 79141, TO_TIMESTAMP('05/09/2019 10:34 PM', 'dd/mm/yyyy hh:mi PM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (308, 138, 01, 12779000, TO_TIMESTAMP('05/10/2019 7:00 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (309, 120, 01, 9190000, TO_TIMESTAMP('05/10/2019 7:12 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (310, 170, 01, 1215429, TO_TIMESTAMP('05/10/2019 7:24 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (311, 115, 06, 2730246, TO_TIMESTAMP('05/10/2019 7:58 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (312, 121, 06, 3922004, TO_TIMESTAMP('05/10/2019 8:00 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (313, 157, 02, 520799, TO_TIMESTAMP('05/10/2019 9:15 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (314, 162, 01, 4000000, TO_TIMESTAMP('05/10/2019 2:58 PM', 'dd/mm/yyyy hh:mi PM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (315, 138, 01, 25529117, TO_TIMESTAMP('05/10/2019 7:00 PM', 'dd/mm/yyyy hh:mi PM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (316, 130, 04, 12850315, TO_TIMESTAMP('05/11/2019 10:30 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (317, 120, 03, 2320618, TO_TIMESTAMP('05/11/2019 11:04 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (318, 168, 02, 14505080, TO_TIMESTAMP('05/11/2019 11:54 AM', 'dd/mm/yyyy hh:mi AM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (319, 171, 01, 5558000, TO_TIMESTAMP('05/11/2019 5:12 PM', 'dd/mm/yyyy hh:mi PM'));
insert into BILL (numBill, userID, methodCheckoutID, totalBill, createdBill)
values (320, 150, 01, 3946139, TO_TIMESTAMP('05/11/2019 6:21 PM', 'dd/mm/yyyy hh:mi PM'));

/* Data for table BILL */
insert into BILL_DETAIL (productID, numBill, quantity) values (140, 301, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (141, 301, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (111, 302, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (138, 303, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (120, 304, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (164, 305, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (165, 305, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (170, 305, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (150, 306, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (151, 306, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (152, 306, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (153, 306, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (154, 307, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (155, 307, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (148, 308, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (145, 309, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (177, 310, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (178, 310, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (166, 311, 5);
insert into BILL_DETAIL (productID, numBill, quantity) values (169, 311, 3);
insert into BILL_DETAIL (productID, numBill, quantity) values (174, 311, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (179, 312, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (180, 312, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (174, 313, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (175, 313, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (112, 314, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (119, 315, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (122, 316, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (128, 317, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (136, 318, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (158, 319, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (160, 320, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (161, 320, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (162, 320, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (163, 320, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (164, 320, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (165, 320, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (171, 320, 1);
insert into BILL_DETAIL (productID, numBill, quantity) values (173, 320, 1);


-- tao view hien thi thong tin cua nguoi dung da tao tai khoan trong nam 2017
create view LIST_USER_ACCOUNT as
select * from user_info where extract(year from createddate) = 2017;
select * from LIST_USER_ACCOUNT;

-- tao view hien thi so luong comment theo tung san pham
create view nbComments as
select productid, count(*) as nbcmt from comments group by productid;
select * from nbComments;

-- ham hien thi tong doanh thu trong 1 nam
create or replace function getTotalSales(inYear integer)
return number is totalPrice number := 0;
begin
    select sum(price*quantity) into totalPrice
    from bill, bill_detail, product 
    where bill.numbill = bill_detail.numbill
    and bill_detail.productid = product.productid
    group by extract (year from createdbill)
    having extract (year from createdbill) = inYear;
    
    return totalPrice;
end;
-- goi ham getTotalSales de kiem tra
set serveroutput on;
declare
    totalSales number := 0;
begin
    totalSales := getTotalSales(&nhap_nam);
    dbms_output.put_line(totalSales);
end;

-- ham hien thi thong tin nguoi dung va noi dung comment san pham Apple iPhone 11 cua nguoi dung do
create table listUserInfo as (select firstName, lastName, contentcmt, datetime from user_info, product, comments
    where user_info.userid = comments.userid 
    and product.productid = comments.productid and product.productName = 'Apple iPhone 11');
set serveroutput on;
declare
cursor c_userInfo is select * from listUserInfo;
    v_userInfo c_userInfo%rowtype;
begin
    open c_userInfo;
    loop
        fetch c_userInfo into v_userInfo;
        dbms_output.put_line(v_userInfo.firstName || ' ' || v_userInfo.lastName || ' ' || v_userInfo.contentCmt || ' ' || v_userInfo.datetime);
        exit when c_userInfo%notfound;
    end loop;
    close c_userInfo;
end;

-- ham hien thi tat ca san pham (ten + gia san pham) trong danh muc san pham Electronic Devices (su dung con tro)
create table listProduct as (select productname, price from PRODUCT, PRODUCT_CATEGORY 
where PRODUCT.productcategoryid = PRODUCT.productcategoryid 
and PRODUCT_CATEGORY.productcategoryname = '&Nhap_vao_ten_danh_muc_san_pham');

select * from listProduct;
drop table listProduct;
set serverout on;
declare
    cursor c_listProduct is select * from listProduct;
    -- khai bao bien de chua du lieu cua cursor
    v_listProduct c_listProduct%rowtype;
begin
     open c_listProduct; -- open cursor
     loop -- using to to get all values in cursor
        fetch c_listProduct into v_listProduct;
        dbms_output.put_line(v_listProduct.productName || ' | ' || v_listProduct.price);
        exit when c_listProduct%notfound;
     end loop;
     close c_listProduct; -- dong cursor
end;

-- tao thu tuc nhan vao id cua 1 danh muc san pham, sau do tra ve gia tien cao nhat va thap nhat cua cua san pham trong
-- danh muc san pham do
select * from PRODUCT_CATEGORY;
select * from PRODUCT;
create or replace procedure productPrice (categoryID integer, minPrice out float, maxPrice out float) is
begin
    select min(price), max(price) into minPrice, maxPrice from PRODUCT, PRODUCT_CATEGORY
    where PRODUCT.productCategoryID = PRODUCT_CATEGORY.productCategoryID
    and PRODUCT_CATEGORY.productCategoryID = categoryID;
end;
-- goi thu tuc
set serveroutput on;
declare
    idProduct int;
    minp float;
    maxp float;
begin
    idProduct := '&Nhap_ma_danh_muc_san_pham';
    if idProduct between 21 and 27 then 
        productPrice(idProduct, minp, maxp);
        dbms_output.put_line('Min price = ' || minp || ' | ' || 'Max price = ' || maxp);
    else
        dbms_output.put_line('Khong co ma nay!');
    end if;
end;

-- tao bang nhat ky de luu lai thong tin da chinh sua tren bang BILL
create table BILL_LOG(
    editUserName varchar2(30),
    editDate timestamp,
    oldBill float,
    newBill float,
    difference float
);
drop table BILL_LOG;

-- tao trigger
create or replace trigger displayBillChanges after delete or insert or update of totalBill on BILL for each row
declare
    billDifference float;
begin
    billDifference := :new.totalBill - :old.totalBill;
    insert into BILL_LOG(editUserName, editDate, oldBill, newBill, difference)
    values (user, sysdate, :old.totalBill, :new.totalBill, billDifference);
end;

select * from BILL;
-- cot totalBill co numBill = 301 truoc khi sua la 700000
update BILL set totalBill = 2000000 where numBill = 301;
select * from BILL_LOG;