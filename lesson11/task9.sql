#1 Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата
# создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;

CREATE TABLE logs (
	created_at datetime DEFAULT CURRENT_TIMESTAMP,
	table_name varchar(32) NOT NULL,
	created_id INT UNSIGNED,
	name VARCHAR(255)	
) engine = archive;

DROP TRIGGER IF EXISTS log_users;
DROP TRIGGER IF EXISTS log_products;
DROP TRIGGER IF EXISTS log_catalogs;

DELIMITER // 

CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW BEGIN
	INSERT INTO logs (created_at, table_name, created_id, name) VALUES (now(), 'users', NEW.id, NEW.name);
END //

CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
	INSERT INTO logs (created_at, table_name, created_id, name) VALUES (now(), 'catalogs', NEW.id, NEW.name);
END //

CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW BEGIN
	INSERT INTO logs (created_at, table_name, created_id, name) VALUES (now(), 'products', NEW.id, NEW.name);
END //

DELIMITER ;

#INSERT INTO users(name) VALUES ('Павел');
#INSERT INTO catalogs(name) VALUES ('Новинки');
#INSERT INTO products(name) VALUES ('Новый продукт');

