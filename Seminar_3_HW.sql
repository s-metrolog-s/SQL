DROP DATABASE IF EXISTS seminar3_hw;
CREATE DATABASE seminar3_hw;

USE seminar3_hw;

CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(45),
    lastname VARCHAR(45),
    post VARCHAR(100),
    seniority INT,
    salary INT,
    age INT
);

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

SELECT * FROM staff;

# 1. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания 
SELECT * FROM staff
ORDER BY salary;

SELECT * FROM staff
ORDER BY salary DESC;

# 2. Выведите 5 максимальных заработных плат (saraly)
-- Написал запрос, при котором данные заранее уже не отсортированы как у нас в условии
SELECT salary FROM staff
ORDER BY salary DESC
LIMIT 5;

# 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary) FROM staff
GROUP BY post;

# 4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
Select COUNT(*) FROM staff
WHERE (post = 'Рабочий') AND (age BETWEEN 24 AND 49);
-- Скобки вставил для читаемости кода

# 5. Найдите количество специальностей
-- Вариант без подзапроса
SELECT COUNT(DISTINCT post) FROM staff;

-- Вариант с подзапросом
SELECT COUNT(*) FROM
(SELECT DISTINCT post FROM staff) AS List_post;
 
# 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет 
SELECT post, AVG(age) FROM staff
GROUP BY post;

-- Все средние либо строго 30, либо больше 30 лет
SELECT post, AVG(age) AS AV_ag_per_post FROM staff
GROUP BY post
HAVING AV_ag_per_post < 30;