USE seminar4;

/*
Задача 1. Создайте представление, в которое попадет информация о пользователях 
(имя, фамилия, город и пол), которые не старше 20 лет.
*/
-- погрешность на нашей выборке не существенная в случае высокосных лет, 
-- поэтому взял 365 за расчет возраста

CREATE OR REPLACE VIEW yanger_20 AS
	SELECT firstname, lastname, hometown, gender
	FROM users JOIN `profiles` ON id = profiles.user_id
    WHERE (DATEDIFF(CURRENT_DATE(), birthday) / 365) < 20;
    
SELECT * FROM yanger_20;

/*
Задача 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите 
ранжированный список пользователей, указав имя и фамилию пользователя, количество 
отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным количеством сообщений). 
(используйте DENSE_RANK)
*/

SELECT from_user_id, fio, count_mess,
	DENSE_RANK() OVER (ORDER BY count_mess DESC) as ranking FROM (
		SELECT
			from_user_id,
			CONCAT(firstname, ' ', lastname) as fio,
			COUNT(from_user_id) OVER (PARTITION BY from_user_id) AS count_mess
		FROM messages
		JOIN users u ON u.id = from_user_id) as new_table
	GROUP BY from_user_id;

/*
Задача 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и 
найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)
*/
SELECT
	id,
    body,
    from_user_id,
    to_user_id,
    created_at,
    TIMESTAMPDIFF(SECOND, LAG(created_at, 1, 0) OVER (ORDER BY created_at), created_at) AS diff_prev,
    TIMESTAMPDIFF(SECOND, created_at, LEAD(created_at, 1, 0) OVER (ORDER BY created_at)) AS diff_next 
FROM messages
ORDER BY created_at;

