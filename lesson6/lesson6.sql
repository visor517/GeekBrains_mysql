# 1 Пусть задан некоторый пользователь. Найдите человека, который больше всех общался с нашим пользователем, иначе, кто написал
# пользователю наибольшее число сообщений. (можете взять пользователя с любым id)

SELECT
	from_user_id,
	(SELECT concat(first_name, " ", last_name) FROM users WHERE id = from_user_id) AS from_user,
	count(*) AS total
FROM messages
WHERE to_user_id = 3
GROUP BY from_user_id
ORDER BY total DESC
LIMIT 1;

#2 Подсчитать общее количество лайков на посты, которые получили пользователи младше 18 лет.

SELECT
	SUM((SELECT SUM(like_type) FROM posts_likes WHERE post_id = id))
FROM posts
WHERE user_id IN (SELECT user_id FROM profiles WHERE timestampdiff(YEAR, birthday, now()) < 18);

#3 Определить, кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	IF (gender = 'm', 'мужчины', 'женщины') AS gen,
	SUM((SELECT SUM(like_type) FROM posts_likes WHERE user_id = profiles.user_id)) AS total
FROM profiles
WHERE gender IN ('f', 'm')
GROUP BY gender
ORDER BY total DESC
LIMIT 1;

#4 Найти пользователя, который проявляет наименьшую активность в использовании социальной сети.

SELECT
	id,
	first_name,
	last_name,
	(SELECT count(*) FROM messages WHERE from_user_id = users.id) +	(SELECT count(*) FROM posts_likes WHERE user_id = users.id) AS total
FROM users
ORDER BY total
LIMIT 1;
