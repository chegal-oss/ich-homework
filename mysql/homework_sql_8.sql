use 121225ptm_serg;

set foreign_key_checks = 0;
drop table if exists product;
drop table if exists pc;
drop table if exists laptop;
drop table if exists printer;
set foreign_key_checks = 1;


create table if not exists product (
	model varchar(50) primary key,
	maker varchar(10), 
    type varchar(50)
);

create table if not exists pc (
	code int primary key auto_increment,
    model varchar(50),
    speed smallint,
    ram smallint,
    hd float,
    cd varchar(10),
    price float not null, 
	foreign key (model) references product(model)
);

create table if not exists laptop (
	code int primary key auto_increment,
    model varchar(50),
    speed smallint,
    ram smallint,
    hd float,
    price float not null, 
    screen tinyint,
    foreign key (model) references product(model)
);

create table if not exists printer (
	code int primary key auto_increment,
    model varchar(50),
    color char(1),
    type varchar(10),
    price float not null, 
    foreign key (model) references product(model)
);

insert into product (model, maker, type) values
('m100', 'apple', 'pc'),
('m101', 'apple', 'laptop'),
('d200', 'dell', 'pc'),
('d201', 'dell', 'laptop'),
('d202', 'dell', 'printer'),
('h300', 'hp', 'pc'),
('h301', 'hp', 'laptop'),
('h302', 'hp', 'printer'),
('l400', 'lenovo', 'pc'),
('l401', 'lenovo', 'laptop'),
('s500', 'samsung', 'printer'),
('c600', 'canon', 'printer');

insert into pc (model, speed, ram, hd, cd, price)
select 
    model, 
    (floor(20 + rand() * 21) * 100),
    elt(floor(1 + rand() * 4), 8, 16, 32, 64),
    elt(floor(1 + rand() * 3), 256, 512, 1024),
    elt(floor(1 + rand() * 2), '12x', '52x'),
    round(300 + rand() * 900, 2)
from product where type = 'pc';

insert into laptop (model, speed, ram, hd, price, screen)
select 
    model, 
    (floor(15 + rand() * 16) * 100),
    elt(floor(1 + rand() * 3), 4, 8, 16),
    elt(floor(1 + rand() * 3), 128, 256, 512),
    round(500 + rand() * 1500, 2),
    elt(floor(1 + rand() * 3), 13, 15, 17)
from product where type = 'laptop';

insert into printer (model, color, type, price)
select 
    model, 
    elt(floor(1 + rand() * 2), 'y', 'n'),
    elt(floor(1 + rand() * 3), 'laser', 'jet', 'matrix'),
    round(50 + rand() * 450, 2)
from product where type = 'printer';

select * from printer where color = "y";


with temp as (
	select model, price from printer
	union 
	select model, price from pc
	union 
	select model, price from laptop
) 
select temp.model, temp.price, p.type, p.maker from temp
inner join product as p on p.model = temp.model and p.maker = "hp";

select distinct maker from product where type = "pc";

select distinct p.maker from pc as pc
inner join product as p
on p.model = pc.model and pc.speed < 3200;

select round(avg(speed)) from pc;

select p.maker, round(avg(lap.screen)) from laptop as lap
inner join product as p on p.model = lap.model
group by p.maker;






