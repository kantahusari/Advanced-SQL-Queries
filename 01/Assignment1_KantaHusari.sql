/*1*/
select category_name, count(product_id) as count, max(list_price) as mostexpensive 
from categories join products 
on categories.category_id=products.category_id 
group by category_name 
order by count(product_id) desc;

/*2*/
select email_address, sum(item_price * quantity) as itempricetotal,
sum(discount_amount * quantity) as discountamounttotal
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by email_address
order by itempricetotal desc;

/*3*/
select email_address, count(o.order_id) as ordercount,
sum((item_price - discount_amount) * quantity) as ordertotal
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by email_address
having count(o.order_id) > 1
order by ordertotal desc;

/*4*/
select product_name, sum((item_price - discount_amount) * quantity) as producttotal
from products p
join order_items oi on p.product_id = oi.product_id
group  by rollup(product_name);

/*5*/
select email_address,
count(distinct oi.product_id) as numberofproducts
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by email_address
having count(distinct oi.product_id) > 1
order by email_address;

/*6*/
select distinct category_name from categories c 
where c.category_id in ( select p.category_id from products p)
order by category_name;

/*7*/
select product_name, list_price 
from products 
where list_price > (select avg(p.list_price) 
from products p)order by list_price;

/*8*/
select c.category_name 
from categories c 
where not exists (select 1 from products p where p.category_id = c.category_id); 

/*9*/
select p1.product_name, p1.discount_percent 
from products p1 
where p1.discount_percent 
not in(select p2.discount_percent from products p2 where p1.product_name <> p2.product_name)
order by product_name;

/*10*/
select email_address, order_date, order_id 
from(select row_number() over(partition by c.customer_id order by order_date desc)rno,email_address, 
order_date, order_id 
from customers c join orders o on c.customer_id = o.customer_id)tab where rno=1;
