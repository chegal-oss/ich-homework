-- 1   Вывести названия продуктов таблица products, включая количество 
-- заказанных единиц quantity для каждого продукта 
-- таблица order_details.

with temp as (
	select product_id, sum(quantity) as s
    from order_details
    group by product_id
)
select id, product_name, s from products 
left join temp 
on product_id = id;

select p.product_name as name, sum(o.quantity) as s from products as p
left join order_details as o
on o.product_id = p.id
group by p.id;

-- 2  Найти все заказы таблица orders, сделанные после 
-- даты самого первого заказа клиента Lee таблица customers.

with temp as (
	select min(order_date) as min_date
    from orders as o
    inner join (select id from customers where last_name = "Lee" limit 1) as c
    on c.id = o.customer_id)
select order_date, (select min_date from temp) as test_date 
from orders where order_date > (select min_date from temp);

select o.order_date, t.min_date from orders as o
inner join (
	select min(order_date) as min_date from orders as o
    inner join (select id from customers where last_name = "Lee" limit 1) as c
    on c.id = o.customer_id) as t
on t.min_date < o.order_date;

-- 3 Найти все продукты таблицы  products c максимальным target_level
-- медленно
with temp as (
	select max(target_level) as m
    from products
)
select target_level, (select m from temp) as test from products
where target_level = (select m from temp);

-- быстро
select target_level from products
where target_level in (select max(target_level) from products);

-- быстрее
select target_level from products as p
inner join (select max(target_level) as m from products) as m
on target_level = m;

