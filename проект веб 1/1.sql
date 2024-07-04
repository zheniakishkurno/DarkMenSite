drop DATABASE if exists pharmacy;
CREATE DATABASE if not exists pharmacy;
use pharmacy;

/*База данных «Аптека»
База данных предназначена для ведения учета лекарств в аптеке. В базе данных должна  храниться  информация:
- о лекарствах (id лекарства, название, производитель, действующее вещество);*/
CREATE TABLE Medecine(
id int primary key,
name varchar(50),
manufacturer varchar(50),
active_subst varchar(50)
);
/* - о наличии на складе (лекарство, дозировка, срок годности, цена, количество на складе, скидка); */
CREATE TABLE Storehouse(
id int primary key,
medecine_id int,
dosage double,
expiration_date date,
price double,
amount int,
discount int
);
/*- о продажах (лекарство, количество, дата продажи).*/
CREATE TABLE Sales(
id int primary key,
storage_id int,
amount int,
sale_date date
);

ALTER TABLE Storehouse ADD FOREIGN KEY (medecine_id) REFERENCES  Medecine(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Sales ADD FOREIGN KEY (storage_id) REFERENCES  Storehouse(id) ON UPDATE CASCADE ON DELETE CASCADE;

/*Написать хранимые процедуры для добавления информации во все таблицы.*/
delimiter //
create procedure insertMedecine(id int,name varchar(50), manufacturer varchar(50), active_subst varchar(50))
begin
insert into Medecine values(id,name, manufacturer, active_subst);
end //
create procedure insertStorehouse(id int,medecine_id int, dosage double,expiration_date date, price double, amount int, discount int )
begin
insert into Storehouse values(id,medecine_id,dosage, expiration_date, price, amount,discount);
end //
create procedure insertSales(id int,storage_id int, amount int, sale_date date)
begin
insert into Sales values(id,storage_id, amount, sale_date);
end //
delimiter ;

CALL insertMedecine(1,"Ибупрофен","Лекфарм","Ибупрофен");
CALL insertMedecine(2,"Валерьянка","Ферейн","Аспирин");
CALL insertMedecine(3,"Антигриппин","Экзон","Аспирин");
CALL insertMedecine(4,"Немозол ","Ферейн","Аспирин");
CALL insertMedecine(5,"Детралтекс ","Сердикс","Флавоноид");

CALL insertStorehouse(1,2,0.5,"2034-07-03",8.99,1000,1);
CALL insertStorehouse(2,1,10,"2025-10-03",5.99,504,0);
CALL insertStorehouse(3,3,200,"2025-06-03",29.99,300,1);
CALL insertStorehouse(4,1,121,"2025-10-03",9.99,200,20);
CALL insertStorehouse(5,4,50,"2027-04-04",3.99,1448,10);


CALL insertSales(1,3,5,"2024-05-21");
CALL insertSales(2,1,1,"2024-04-30");
CALL insertSales(3,2,3,"2024-03-05");
CALL insertSales(4,4,50,"2024-02-16");


SELECT * FROM Medecine;
SELECT * FROM Storehouse;
SELECT * FROM Sales;
/*Написать хранимую процедуру вычисляющую среднее количество проданного лекарства.
ID_товара передается в процедуру в качестве параметра.*/
delimiter //
create procedure avgSoldAmount(medecine_id int,out avg_amount int)
begin
set avg_amount =
    (SELECT AVG(Sa.amount) FROM Sales Sa LEFT JOIN Storehouse St ON Sa.storage_id = St.id
    WHERE St.medecine_id = medecine_id);
end //
delimiter ;

CALL avgSoldAmount(1, @avg_amount);
SELECT @avg_amount;

/*Написать триггер на добавление который устанавливает для данного товара скидку 5% при продаже,
 если среднее количество имеющегося на складе товара больше 5. */
 
DELIMITER //
CREATE TRIGGER  `after_add_sales`
AFTER INSERT on Sales for each row
begin
DECLARE avg_amount int;
SET avg_amount = (SELECT AVG(amount) FROM Storehouse WHERE id = NEW.storage_id);
IF(avg_amount>5)
    THEN
UPDATE Storehouse SET discount = 5 WHERE id = NEW.storage_id;
    END IF;
end //
DELIMITER ;

SELECT * FROM Storehouse;
SELECT * FROM Sales;
INSERT INTO Sales VALUES(5,5,10,"2024-01-03");
SELECT * FROM Storehouse;
SELECT * FROM Sales;
 
 
/*Написать триггер, срабатывающий при удалении продажи из таблицы Продажи.
Если среднее количество проданного товара меньше 5, то данный товар должен быть
удален из таблицы Товары.*/

DELIMITER //
CREATE TRIGGER  `after_delete_sales`
before DELETE on Sales for each row
begin
DECLARE avg_amount int;
SET avg_amount = (SELECT AVG(amount) FROM Sales WHERE id = OLD.id);
IF(avg_amount<5)
    THEN
DELETE FROM Storehouse WHERE id = OLD.storage_id;
    END IF;
end //
DELIMITER ;

SELECT * FROM Storehouse;
SELECT * FROM Sales;
DELETE FROM Sales WHERE id = 3;
SELECT * FROM Storehouse;
SELECT * FROM Sales;

/*Написать триггер, который при добавлении нового товара, создает для него продажу
с нулевыми значениями полей и текущей датой. */

DELIMITER //
CREATE TRIGGER  `after_add_storehoouse`
before INSERT on Storehouse for each row
begin
DECLARE sale_id int;
SET sale_id = (SELECT MAX(id) FROM Sales)+1;
INSERT INTO SALES VALUES(sale_id,null,null,CURDATE());
end //
DELIMITER ;


SELECT * FROM Storehouse;
SELECT * FROM Sales;
INSERT INTO Storehouse VALUES(2,5,50,"2030-01-01",99.99,50,6);
SELECT * FROM Storehouse;
SELECT * FROM Sales;
