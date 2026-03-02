use northwind;

-- 1. Для каждого заказа order_id выведите минимальный, максмальный и средний unit_cost
select purchase_order_id, 
	min(unit_cost) over (partition by purchase_order_id), 
	max(unit_cost) over (partition by purchase_order_id), 
	avg(unit_cost) over (partition by purchase_order_id)
from purchase_order_details;

-- 2.  Оставьте только уникальные строки из предыдущего запроса
select purchase_order_id, 
	min(unit_cost) over (partition by purchase_order_id), 
	max(unit_cost) over (partition by purchase_order_id), 
	avg(unit_cost) over (partition by purchase_order_id)
from purchase_order_details
group by purchase_order_id;

-- 3. Посчитайте стоимость продукта в заказе как quantity*unit_cost. 
-- Выведите суммарную стоимость продуктов 
-- с помощью оконной функции. Сделайте то же самое с помощью GROUP BY

select purchase_order_id, 
	sum(quantity * unit_cost) over (partition by purchase_order_id)
from purchase_order_details;

select purchase_order_id, sum(quantity * unit_cost)
from purchase_order_details group by purchase_order_id;

-- 4. Посчитайте количество заказов по дате получения и posted_to_inventory.
-- Если оно превышает 1 то выведите '>1' в противном случае '=1'.
-- Выведите purchase_order_id, date_received и вычисленный столбец

select purchase_order_id, date_received, -- count(purchase_order_id) over (partition by date_received,posted_to_inventory),
if(count(purchase_order_id) over 
	(partition by date_received, posted_to_inventory) > 1, ">1","=1") as t
from purchase_order_details order by purchase_order_id;



