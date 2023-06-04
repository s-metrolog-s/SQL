CREATE DATABASE seminar2_hw;
USE seminar2_hw;

/*
Задание № 1: Используя операторы языка SQL, 
создайте таблицу “sales”. Заполните ее данными.
*/
CREATE TABLE sales
(
	id SERIAL PRIMARY KEY,
	order_date DATE NOT NULL,
    count_product INT UNSIGNED NOT NULL
);

INSERT INTO sales (order_date, count_product) VALUES
('2022-01-01', 156), 
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

SELECT * FROM seminar2_hw.sales;
    
/*
Задание № 2: Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ
*/
SELECT id as "id заказа",
CASE
	WHEN count_product < 100 THEN 'Маленький заказ'
    WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
    WHEN count_product > 300 THEN 'Большой заказ'
END AS 'Тип заказа'
FROM sales;

/*
Задание № 3: Создайте таблицу “orders”, заполните ее значениями: 
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»
*/

DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
	id SERIAL PRIMARY KEY,
    employee_id VARCHAR(6) NOT NULL,
    amount DECIMAL(9, 2) NOT NULL,
    order_status VARCHAR(10) NOT NULL
);

INSERT INTO orders (employee_id, amount, order_status) VALUES
("e03", 15.00, "OPEN"),
("e01", 25.50, "OPEN"),
("e05", 100.70, "CLOSED"),
("e02", 22.18, "OPEN"),
("e04", 9.50, "CANCELLED");

SELECT * FROM orders;

# Из задания не совсем понятно, что именно отобразить, поэтому поступаю по умолчанию, 
# что отчет идет менеджменту, который не знает английский и хочет видеть весь заказ

SELECT 
id AS "№ заказа",
employee_id AS "Табельный номер сотрудника",
amount AS "Количество",
IF (order_status = "OPEN", "Order is in open state", 
	IF (order_status = "CLOSED", "Order is closed",
		IF (order_status = "CANCELLED", "Order is cancelled", ""))) AS 'Полный статус заказа'
FROM orders;

# Прописал в блоке ELSE "", чтобы проверялось именно соответствие на CANCELLED, 
# а не в случае всех остальных вариантов

/*
Задание № 4: Чем 0 отличается от NULL?

Ответ: 0 - это все таки число, с которым возможно производить математические действия и влиять на результат.
Например, к нулю можно добавить количество какого-то товара или отнять.
NULL - больше походит на пустоту, т.е. НИЧЕГО, соответственно с ним нельзя производить математических действий.
И в такоом случае для внесения изменения в ячейке необходимо будет не складывать или отнимать, а менять значение ячейки.
Кроме того, в случае присутствия NULL в одном столбце совместно с обычными числами, и применением математической операции
ко всему столбцу, вероятно может привести к ошибке.
*/


