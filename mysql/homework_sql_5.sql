-- 1. Посчитайте основные статистики - среднее, сумму, минимум, максимум столбца unit_cost.
select 
	avg(unit_cost) as avg_cost,
    sum(unit_cost) as sum_cost,
	max(unit_cost) as max_cost,
	min(unit_cost) as mic_cost
from northwind.purchase_order_details;

-- 2. Посчитайте количество уникальных заказов purchase_order_id
select count(distinct purchase_order_id) as purchase_count
from northwind.purchase_order_details;
    
-- 3. Посчитайте количество продуктов product_id в каждом заказе purchase_order_id 
-- Отсортируйте полученные данные по убыванию количества
select purchase_order_id, count(product_id) as product_count from northwind.purchase_order_details
group by purchase_order_id order by product_count desc;

-- 4. Посчитайте заказы по дате доставки date_received 
-- Считаем только те продукты, количество quantity которых больше 30
select date_received, count(purchase_order_id) from northwind.purchase_order_details
where quantity > 30
group by date_received;

-- 5. Посчитайте суммарную стоимость заказов в каждую из дат
-- Стоимость заказа - произведение quantity на unit_cost
select date_received, sum(quantity * unit_cost) as order_sum from northwind.purchase_order_details
group by date_received;

-- 6. Сгруппируйте товары по unit_cost и вычислите среднее и максимальное 
-- значение quantity только для товаров где purchase_order_id не больше 100
select unit_cost, avg(quantity) as avg_quantity, max(quantity) as max_quantity 
from northwind.purchase_order_details
where purchase_order_id <= 100
group by unit_cost order by unit_cost;

-- 7. Выберите только строки где есть значения в столбце inventory_id 
-- Создайте столбец category - если unit_cost > 20 то 'Expensive' 
-- в остальных случаях 'others' Посчитайте количество продуктов в каждой категории
select if(unit_cost > 20, 'Expensive', 'Others') as category, count(product_id) as product_count
from northwind.purchase_order_details
group by category;

