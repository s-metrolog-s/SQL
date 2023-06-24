USE seminar1_hw;
-- Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными

-- Задача 2: Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT ProductName, Manufacturer, Price FROM mobilephones
WHERE ProductCount > 2;

-- Задача 3: Выведите весь ассортимент товаров марки “Samsung”
SELECT * FROM mobilephones
WHERE Manufacturer LIKE 'Samsung';

-- Задача 4: Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000
SELECT * FROM mobilephones
WHERE ProductCount * Price > 100000 AND ProductCount * Price < 145000;

-- Задачи 5*
-- 5.1: Товары, в которых есть упоминание "Iphone"
SELECT * FROM mobilephones
WHERE ProductName LIKE '%iPhone%';

-- 5.2: Товары, в которых есть упоминание "Galaxy"
SELECT * FROM mobilephones
WHERE ProductName LIKE '%Galaxy%';

-- 5.3: Товары, в которых есть ЦИФРЫ
SELECT * FROM mobilephones
WHERE ProductName RLIKE '[0-9]';

-- 5.4: Товары, в которых есть ЦИФРА "8"
SELECT * FROM mobilephones
WHERE ProductName RLIKE '[8]';
