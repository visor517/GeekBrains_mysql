#1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
# С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
# с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP PROCEDURE IF EXISTS hello;

DELIMITER //

CREATE PROCEDURE hello()
BEGIN
	SET @h = HOUR(CURTIME());
	SELECT
		CASE 
			WHEN @h < 6 THEN "Доброй ночи"
			WHEN @h IN (6,7,8,9,10,11) THEN "Доброе утро"
			WHEN @h IN (12,13,14,15,16,17) THEN "Добрый день"
			WHEN @h >= 18 THEN "Добрый вечер"
		END;
END //

DELIMITER ;

CALL hello();

#2 В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация,
# когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
# При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS check_name_description;

DELIMITER //

CREATE TRIGGER check_name_description BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Update Canceled. И name, и description не могут быть Null';
	END IF;
END //

DELIMITER ;

UPDATE products SET name=NULL, description=NULL WHERE id = 6;

#3 (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число равно
# сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55

DROP FUNCTION IF EXISTS fibonacci;

DELIMITER //

CREATE FUNCTION fibonacci(num int UNSIGNED)
RETURNS int NO SQL 
BEGIN
	IF num IN (0,1) THEN
		RETURN num;
	ELSE
		SET @a = 0, @b = 1, @num=2, @res=0; 
		WHILE @num <= num DO
			SET @res = @a + @b,
				@a = @b,
				@b = @res,
				@num = @num + 1;
		END WHILE;
		RETURN @res;
	END IF;
END //

DELIMITER ;
 
SELECT fibonacci(10);