use northwind;


-- 1 Вывести id департамента , в котором работает сотрудник, 
-- в зависимости от Id сотрудника

drop procedure if exists select_dep_id;

delimiter //
create procedure select_dep_id(in employee_id int)	
begin
	select department_id from employees_3 where id = employee_id;
end //
delimiter ;

call select_dep_id(1);

-- 2 Создайте хранимую процедуру get_employee_age, которая принимает id сотрудника
--  (IN-параметр) и возвращает его возраст через OUT-параметр.

drop procedure if exists get_employee_age;

delimiter //
create procedure get_employee_age(in employee_id int, out out_age int)
begin 
	select age into out_age from employees_3 where employee_id = id;
end //
delimiter ;

set @age = 0;
call get_employee_age(1, @age);
select @age;


-- 3 Создайте хранимую процедуру decrease_salary, которая принимает зарплату
--  сотрудника (INOUT-параметр) и уменьшает ее на 10%.

drop procedure if exists decrease_salary;

delimiter //
create procedure decrease_salary(inout salary double)
begin 
	set salary = salary * 0.9;
end //
delimiter ;

set @salary = 1000;
call decrease_salary(@salary);
select @salary;


