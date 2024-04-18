drop table orders;
drop table inventory;


create table inventory(
     product_id integer primary key,
     quantity integer
);

create table orders(
     order_id integer primary key,
     product_id integer,
     quantity integer,
     order_date date,
     foreign key(product_id) references inventory(product_id) on delete cascade
);

insert into inventory(product_id,quantity) values(11,80);
insert into inventory(product_id,quantity) values(12,60);
insert into inventory(product_id,quantity) values(13,40);
insert into inventory(product_id,quantity) values(14,20);

insert into orders(order_id, product_id, quantity, order_date) values(1,11,1,to_date('2024-1-01', 'YYYY-MM-DD'));
insert into orders(order_id, product_id, quantity, order_date) values(2,12,1,to_date('2024-1-01', 'YYYY-MM-DD'));
insert into orders(order_id, product_id, quantity, order_date) values(3,13,1,to_date('2024-1-01', 'YYYY-MM-DD'));
insert into orders(order_id, product_id, quantity, order_date) values(4,14,1,to_date('2024-1-01', 'YYYY-MM-DD'));

select * from inventory where INVENTORY.QUANTITY > (
select avg(inventory.quantity) from inventory
);

set serveroutput on
create or replace trigger update_inventory_trigger
after insert on orders
--REFERENCING OLD AS o NEW AS n
for each row
begin
    --select * from orders;
    update inventory set inventory.quantity = inventory.quantity + :new.quantity where INVENTORY.PRODUCT_ID = :new.product_id; 
end;  

insert into orders(order_id, product_id, quantity, order_date) values(16,11,3,to_date('2024-1-01', 'YYYY-MM-DD'));
