USE lesson5;

#1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE users SET created_at = now() WHERE created_at IS NULL;
UPDATE users SET updated_at = now() WHERE updated_at IS NULL;

#2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время
# помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

UPDATE users
SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

ALTER TABLE users MODIFY created_at DATETIME;
ALTER TABLE users MODIFY updated_at DATETIME;

#3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и
# выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения
# значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.

SELECT * FROM storehouses_products sp ORDER BY value = 0, value;

#4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)

SELECT * FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august');

#5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY Field(id, 5,1,2);

#1. Подсчитайте средний возраст пользователей в таблице users.

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, CURDATE())) FROM users;

#2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
	DATE_FORMAT(CONCAT( YEAR(CURDATE()), '-', DATE_FORMAT(birthday_at, '%m-%d')), '%W') AS day,
	count(*) AS total
FROM users GROUP BY day;

#3. Подсчитайте произведение чисел в столбце таблицы.

SELECT EXP(SUM(LN(id))) FROM x;
