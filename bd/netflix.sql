USE Netflix;

-- Buscar cuantas películas como favorita tiene cada usuario.
SELECT user.user, COUNT(movie_has_user.fkMovies) as favourite_movies
FROM user INNER JOIN movie_has_user ON user.idUser = movie_has_user.fkUser
GROUP BY movie_has_user.fkUser;


-- Buscar el usuario con mayor cantidad de películas favoritas.
SELECT user.user, COUNT(movie_has_user.fkMovies) AS favourite_movies
FROM user
INNER JOIN movie_has_user ON user.idUser = movie_has_user.fkUser
GROUP BY user.user
ORDER BY favourite_movies DESC
LIMIT 1;