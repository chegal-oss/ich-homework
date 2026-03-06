use northwind;

-- 1 Для каждого product_id выведите inventory_id, а также предыдущий
--  и последующей inventory_id по убыванию quantity

select od.product_id, inventory_id,
lag(inventory_id) over (partition by product_id order by quantity desc) as lag1,
lead(inventory_id) over (partition by product_id order by quantity desc) as lead1
from order_details as od
inner join
(select product_id, count(inventory_id) as ic from order_details 
group by product_id) as t1 on t1.product_id = od.product_id and t1.ic > 1
order by product_id, quantity desc;


-- 2 Выведите максимальный и минимальный unit_price для каждого order_id с помощью
--  функции FIRST VALUE.  Вывести order_id и полученные значения

select distinct order_id,
first_value(unit_price) over (partition by order_id order by unit_price desc) as max_price,
first_value(unit_price) over (partition by order_id order by unit_price) as min_price
from order_details order by order_id;

-- 3 Выведите order_id и столбец с разницей между  unit_price для
-- каждого заказа и минимальным unit_price в рамках одного 
-- заказа. Задачу решить двумя способами - с помощью First VAlue и MIN

select od.order_id, unit_price,t.mi,  unit_price - t.mi as diff
from order_details as od 
inner join(
select order_id, min(unit_price) as mi
from order_details group by order_id) as t
on t.order_id = od.order_id;

select order_id, unit_price, 
first_value(unit_price) over (partition by order_id order by unit_price) as mi, 
unit_price - first_value(unit_price) over (partition by order_id order by unit_price) as diff
from order_details;

-- 4 Присвойте ранг каждой строке используя RANK по убыванию quantity

select quantity, rank() over (order by quantity desc) as r from order_details
order by quantity desc;

-- 5  Из предыдущего запроса выберите только строки с рангом до 10 включительно

select * from (
select quantity, rank() over (order by quantity desc) as r from order_details
order by quantity desc) as t
where r >= 10;





