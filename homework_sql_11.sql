use northwind;

-- 1. Расчет площади круга
drop function if exists circle_area;

delimiter //
create function circle_area(r double)
returns double
deterministic
begin
	return pi() * pow(r, 2);
end //
delimiter ;

select circle_area(3);

-- 2. Функция для расчета гипотенузы треугольника
drop function if exists hypotenuse_calculation;
delimiter //
create function hypotenuse_calculation(a double, b double)
returns double
deterministic
begin
	return sqrt(pow(a, 2) + pow(b, 2));
end //
delimiter ;

select hypotenuse_calculation(3, 4);

