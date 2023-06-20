USE seminar4;

/*
Задача 1. Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, 
с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно)
*/

DROP PROCEDURE IF EXISTS move_user;

DELIMITER //
CREATE PROCEDURE move_user (move_id INT)
BEGIN
	INSERT INTO users_old (id, firstname, lastname, email)
	SELECT * FROM users
    WHERE users.id = move_id;
    
    DELETE FROM users
    WHERE users.id = move_id;
    
END //
DELIMITER ;

START TRANSACTION;

DROP TABLE IF EXISTS users_old;
-- создаем новую таблицу
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);
-- Запускаем процедуру
CALL move_user(10);

COMMIT;

/*
Задача 2. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать 
фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи"
*/
DROP FUNCTION IF EXISTS hello;

DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(50) READS SQL DATA
BEGIN
	DECLARE result VARCHAR(50);
    SET result = CASE
		WHEN CURRENT_TIME() BETWEEN '06:00:00' AND '12:00:00' THEN "Доброе утро"
		WHEN CURRENT_TIME() BETWEEN '12:00:00' AND '18:00:00' THEN "Добрый день"
		WHEN CURRENT_TIME() BETWEEN '18:00:00' AND '23:59:999' THEN "Добрый вечер"
		WHEN CURRENT_TIME() BETWEEN '00:00:00' AND '06:00:00' THEN "Доброй ночи"
	END;
    RETURN result;
END //
DELIMITER ;

SELECT hello();

/*
Задача 3 (По желанию)*. Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, communities и messages в таблицу logs 
помещается время и дата создания записи, название таблицы, идентификатор первичного ключа
*/