/* 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.*/

SELECT DISTINCT
	(SELECT name FROM users WHERE user_id = id) AS 'name'
FROM 
	orders;

/* второй вариант */
SELECT name FROM users WHERE id IN (SELECT DISTINCT user_id FROM orders);
	
/* 2. Выведите список товаров products и разделов catalogs, который соответствует товару.*/

SELECT
	name,
	(SELECT name FROM catalogs WHERE id = catalog_id) AS 'catalog'
FROM
	products;
	
/* 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label
содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов. */

SELECT
	id,
	(SELECT name FROM cities WHERE label = `from`) AS 'from',
	(SELECT name FROM cities WHERE label = `to`) AS 'to'
FROM
	flights;