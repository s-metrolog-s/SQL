USE seminar4;

/*
	1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
*/

SELECT COUNT(*) AS 'Лайки младше 12 лет' FROM likes l
JOIN 
	(SELECT * FROM `profiles` WHERE birthday > '2011-01-01') AS p 
ON l.user_id = p.user_id;

/*
	2. Определить кто больше поставил лайков (всего): мужчины или женщины.
*/

SELECT
	p.gender AS 'Пол',
    COUNT(*) AS 'Количество лайков'
FROM `profiles` p
JOIN likes l ON p.user_id = l.user_id
GROUP BY gender;

/*
	3. Вывести всех пользователей, которые не отправляли сообщения.
*/

SELECT
	id,
    CONCAT(firstname, ' ', lastname) AS 'Пользователь',
    email
FROM users u
WHERE id NOT IN 
	(SELECT from_user_id FROM messages);

/*
	4. (по желанию)* Пусть задан некоторый пользователь. Из всех друзей
	этого пользователя найдите человека, который больше всех написал
	ему сообщений.
*/