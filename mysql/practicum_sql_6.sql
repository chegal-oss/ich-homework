-- Объедините с помощью UNION ALL названия компаний сотрудников из
-- таблицы employees, названия компаний клиентов из таблицы customers и
-- названия компаний для поставщиков из таблицы suppliers.

select company from northwind.employees
union
select company from northwind.customers
union 
select company from northwind.suppliers;

-- Объясните почему в предыдущем запросе не стоит использовать UNION ALL.
-- Добавьте к предыдущему запросу столбец, показывающий из какой таблицы
-- была взята запись.

select company, "employees" as table_name from northwind.employees
union
select company, "customers" from northwind.customers
union 
select company, "suppliers" from northwind.suppliers;

-- У каких сотрудников в таблице employees нет привилегий таблица
-- employee_privileges. Выведите имя и фамилию .

select id, employee_id from northwind.employees as e
left join northwind.employee_privileges as p
on e.id = p.employee_id
where p.employee_id is null;

-- Работаем с таблице inventory_transactions. Выведите transaction_created_date,
-- а также название типа транзакции и название продукта.
select t.transaction_type, t.transaction_created_date, p.product_name
from northwind.inventory_transactions as t
left join northwind.products as p
on p.id = t.product_id;

-- В таблице orders расшифруйте значения всех столбцов, в именах которых
-- присутствует 'id' и для которых в базе данных имеются соответствующие
-- таблицы. Выведите все строки в которых ship_city Seattle. Объясните почему в
-- данном случае важно использовать LEFT JOIN.

select o.id, o.ship_city,
	e.last_name as employee, 
	c.last_name as customers,
	if(s.company is null, "No shippers",s.company) as shippers,
    st.status_name as status,
    if(tx.tax_status_name is null, "Free", tx.tax_status_name) as tax
from northwind.orders as o
left join northwind.employees as e
on o.employee_id = e.id
left join northwind.customers as c
on o.customer_id = c.id
left join northwind.shippers as s
on o.shipper_id = s.id
left join northwind.orders_status as st
on o.status_id = st.id
left join northwind.orders_tax_status as tx
on o.tax_status_id = tx.id
where o.ship_city = "Seattle";

