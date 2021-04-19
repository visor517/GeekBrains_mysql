#1 В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;

COMMIT;

#2 Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

USE shop;

CREATE OR REPLACE VIEW myview AS
SELECT 
	name,
	(SELECT name FROM catalogs WHERE id = catalog_id) AS category
FROM products;

SELECT * FROM myview;