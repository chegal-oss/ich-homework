-- 1. Вывести среднее, минимум, максимум и сумму по столбцу standard_cost
select 
	avg(standard_cost) as cost_avg,
    min(standard_cost) as cost_min,
    max(standard_cost) as cost_max,
	sum(standard_cost) as cost_sum
from northwind.products;


-- 2. Посчитайте количество товаров в каждой категории category 
-- Выведите только записи с количеством
-- товаров не менее 3
select category, count(id) as product_count from northwind.products
group by category
having count(id) > 2;

-- 3. Выведите среднюю себестоимость standard_cost 
-- для пары supplier_ids + category
select supplier_ids, category, avg(standard_cost) as avg_cost 
from northwind.products
group by supplier_ids, category
order by supplier_ids, category;

-- 4. Посчитайте количество продуктов, для которых отсутсвует 
-- minimum_reorder_quantity
select count(id) as id_count from northwind.products
where minimum_reorder_quantity is null;

-- 5. Посчитайте количество уникальных категорий
select count(distinct category) from northwind.products;

-- 6. Разделите все товары на группы по reorder_level если reorder_level
-- меньше 10 то 'low' , от 10 до 20
-- включительно - 'medium' , осталные - 'hight' Вывести среднее, 
-- максимум и минимум столбца list_price для
-- каждой группы

select 
	case 
		when reorder_level < 10 then 'low'
        when reorder_level <= 20 then 'medium'
        else 'hight'
	end as level,
    avg(list_price) as avg_price,
    max(list_price) as max_price,
    min(list_price) as min_price
 from northwind.products
group by level;

-- 7. Найти средний standard_cost только для тех продуктов, 
-- которые продаются коробками quantity_per_unit
select quantity_per_unit, avg(standard_cost) avg_cost from northwind.products
where lower(quantity_per_unit) like '%box%'
group by quantity_per_unit
order by quantity_per_unit;

-- 8. Вычислите суммарную прибыль компании для каждой 
-- категории для продуктов с target_level больше 40
-- Прибыль компании вычисляется как list_price - standard_cost
select category, sum(list_price - standard_cost) as profit 
from northwind.products
where target_level > 40
group by category;
    


