-- 1. Выведите одним запросом с использованием UNION столбцы id, 
-- employee_id из таблицы orders и соответствующие им столбцы из таблицы purchase_orders. 
-- В таблице purchase_orders  created_by соответствует employee_id.

select id, employee_id from northwind.orders
union 
select id, created_by from northwind.purchase_orders;

-- 2. Из предыдущего запроса удалите записи там, где employee_id не имеет значения.
--  Добавьте дополнительный столбец со сведениями из какой таблицы была взята запись.
select id, employee_id, "orders" as tab_name from northwind.orders
union 
select id, created_by, "purchase" from northwind.purchase_orders
having created_by is not null;

-- 3. Выведите все столбцы таблицы order_details, а также дополнительный столбец payment_method 
-- из таблицы purchase_orders. Оставьте только заказы для которых известен payment_method.
select d.*, p.payment_method from northwind.order_details as d
inner join northwind.purchase_orders as p
on d.purchase_order_id = p.id and p.payment_method is not null;

-- 4 Выведите заказы orders и фамилии клиентов customers для
--  тех заказов по которым были инвойсы таблица invoices
select i.id as id_invoce, o.id as id_order, c.last_name from northwind.orders as o
left join northwind.customers as c
on c.id = o.employee_id
inner join northwind.invoices as i
on o.id = i.order_id
order by last_name;

-- 5. Подсчитайте количество инвойсов для каждого клиента из предыдущего запроса
select c.last_name,count(i.id) as count_inv
from northwind.orders as o
left join northwind.customers as c
on c.id = o.employee_id
inner join northwind.invoices as i
on o.id = i.order_id
group by c.last_name
order by last_name;


