-- echo Building Oracle demonstration tables.  Please wait.
DROP TABLE Challan_details;
DROP TABLE Challan_master;
DROP TABLE sales_order_details;
DROP TABLE sales_order;
DROP TABLE salesman_master;
DROP TABLE product_master;
DROP TABLE client_master;
DROP TABLE DUMMY;

create table client_master(client_no varchar2(6) primary key check(client_no like'c%'),
name varchar2(20) not null,
address1 varchar2(30),
address2 varchar2(30),
city varchar2(15),
state varchar2(15),
pincode number(8),
bal_due number(10,2));

insert into client_master values('c00001','IvanBayros','ward','chruch','Mumbai','Maharastra',400054,15000);
insert into client_master values('c00002','Vandana','ward','chruch','Banglore','Karnataka',780001,0);
insert into client_master values('c00003','Basu','ward','chruch','Delhi','Delhi',400054,3000);
insert into client_master values('c00004','Vijay','ward','chruch','Chennai','Tamilnadu',400074,2000);
insert into client_master values('c00005','Gayathri','ward','chruch','Mumbai','Maharastra',400054,5000);

create table product_master(product_no varchar2(6) primary key check(product_no like'p%'),
description varchar2(15) not null,
profit_percent number(4,2) not null,
unit_measure varchar2(10),
qty_on_hand number(8),
reorder_lvl number(8),
sell_price number(8,2) not null check(sell_price<>0),
cost_price number(8,2) not null check(cost_price<>0));

insert into product_master values('p00001','1.44Flopys',0.50,'piece',100,20,525,500);
insert into product_master values('p00002','Monitors',0.60,'piece',10,3,12000,11280);
insert into product_master values('p00003','540HDD',0.40,'piece',10,3,8400,8000);
insert into product_master values('p00004','1.44Drive',0.50,'piece',100,3,1050,1000);
insert into product_master values('p00005','PenDrive',0.50,'piece',50,130,5050,5000);


create table salesman_master(salesman_no varchar2(6) primary key check(salesman_no like's%'),
salesman_name varchar2(20) not null,
address1 varchar2(30),
address2 varchar2(30),
city varchar2(20),
state varchar2(20),
pincode number(8),
sal_amt number(8,2) not null check(sal_amt<>0),
target_to_get number(6,2) not null check(target_to_get<>0),
ytd_sales number(6,2) not null,
remarks varchar2(20));


insert into salesman_master values('s00001','Kiran','A/14','Worli','Mumbai','Maharastra',400002,3000,100,2000,'Good');
insert into salesman_master values('s00002','Manish','65','Nariman','Mumbai','Maharastra',400001,3000,200,3500,'Good');
insert into salesman_master values('s00003','Ravi','P-7','Bandra','Mumbai','Maharastra',400032,3000,200,2200,'Good');
insert into salesman_master values('s00004','Ashish','A/5','Juhu','Mumbai','Maharastra',400044,3500,200,3000,'Good');
insert into salesman_master values('s00005','Anil','B/5','Bhuhu','Mumbai','Maharastra',400044,5500,200,4000,'Good');

create table sales_order(order_no varchar2(6) primary key check(order_no like 'o%'),
order_date date,
client_no varchar2(6) references client_master(client_no),
dely_address varchar2(25),
salesman_no varchar2(6) references salesman_master(salesman_no),
dely_type varchar2(1) default 'f' check(dely_type in('p','f')), 
bill_yn char(1),
dely_date date,
order_status varchar2(10) check(order_status in('InProcess','Fulfilled', 'BackOrder', 'Cancelled')),
check(dely_date>order_date));

insert into sales_order values('o19001','12-Jul-15','c00001','vjei block1','s00001','f','N','20-Aug-15','InProcess');
insert into sales_order values('o19002','25-Jul-15','c00002','vjei block2','s00002','p','N','27-Jul-15','Cancelled');
insert into sales_order values('o19003','18-Mar-15','c00003','vjei block3','s00003','f','Y','20-Mar-15','Fulfilled');
insert into sales_order values('o19004','03-May-15','c00004','vjei block4','s00004','f','Y','07-Sep-15','Fulfilled');
insert into sales_order values('o19005','03-Jun-15','c00005','vjei block5','s00005','f','Y','07-Jun-15','Fulfilled');
insert into sales_order values('o19006','03-May-08','c00005','vjei block5','s00005','f','Y','07-May-08','Fulfilled');

create table sales_order_details(order_no varchar2(6)  references sales_order(order_no),
product_no varchar2(6) references product_master(product_no),
qty_ordered number(8),
qty_disp number(8),
product_rate number(10,2),
primary key(order_no,product_no));

insert into sales_order_details values('o19001','p00001',4,4,525);
insert into sales_order_details values('o19002','p00002',2,1,8400);
insert into sales_order_details values('o19003','p00003',2,1,5250);
insert into sales_order_details values('o19004','p00004',4,4,525);
insert into sales_order_details values('o19005','p00005',4,4,525);

