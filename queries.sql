-- write your queries here
--1
SELECT * FROM owners o
    FULL OUTER JOIN vehicles v
        ON o.id=v.owner_id;

--2
SELECT o.first_name, o.last_name, COUNT(o.id)  FROM owners o
    JOIN vehicles v ON o.id = v.owner_id
    GROUP BY (first_name, last_name)
ORDER BY first_name;
--3
SELECT o.first_name, o.last_name, ROUND(AVG(v.price)) AS average_price, COUNT(o.id)
FROM  owners o
JOIN vehicles v ON o.id = v.owner_id
GROUP BY (first_name,last_name)
HAVING COUNT(owner_id)> 1 AND ROUND (AVG(v.price)) > 10000
ORDER BY first_name DESC;

--SQL ZOO
--TUTORIAL 6
--1.
SELECT g.matchid, g.player FROM goal g
    WHERE g.teamid = 'GER';
--2.
SELECT g.id,g.stadium,g.team1,g.team2
FROM game g
WHERE g.id = 1012;
--3.
SELECT player, teamid, stadium, mdate
    FROM game 
JOIN goal ON (id=matchid)
WHERE teamid = 'GER';
--4.
SELECT team1, team2, player
    FROM game 
JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%';
--5
SELECT player, teamid, coach, gtime
    FROM goal 
JOIN eteam ON teamid=id
WHERE gtime<=10;
--6.
SELECT mdate, teamname
    FROM game
JOIN eteam ON team1=eteam.id
WHERE coach LIKE 'Fernando Santos';
--7.
SELECT player 
    FROM goal
JOIN game ON game.id = matchid
WHERE game.stadium = 'National Stadium, Warsaw';
--8.
SELECT DISTINCT player
    FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'GER' OR team2 = 'GER') AND goal.teamid != 'GER';
--9.
SELECT teamname, COUNT(teamid)
    FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
ORDER BY COUNT(teamid) DESC;
--10.
SELECT stadium, COUNT(matchid)
    FROM game JOIN goal ON id = matchid
GROUP BY stadium
ORDER BY COUNT(matchid) DESC;
--11.
SELECT id,mdate, COUNT(matchid)
    FROM goal
JOIN game ON matchid = id 
    WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY game.id, game.mdate;
--12.
SELECT matchid, mdate, COUNT(matchid)
    FROM goal
JOIN game on matchid = id
WHERE teamid = 'GER'
GROUP BY goal.matchid, game.mdate;
--13.
SELECT mdate,
    team1, SUM(CASE WHEN goal.teamid=team1 THEN 1 ELSE 0 END) as score1,
    team2, SUM(CASE WHEN goal.teamid=team2 THEN 1 ELSE 0 END) as score2
    FROM game LEFT JOIN goal ON matchid = id
GROUP by game.mdate, matchid, team1, team2
ORDER by mdate, matchid, team1, team2;

--SQL ZOO
--TUTORIAL 7
--1.
SELECT id, title
    FROM movie
WHERE yr=1962;
--2.
SELECT yr
    FROM movie
    WHERE title = 'Citizen Kane'
--3.
SELECT id, title, yr
    FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr ASC;
--4.
SELECT id FROM actor
WHERE actor.name = 'Glenn Close';
--5.
SELECT id FROM movie
WHERE movie.title = 'Casablanca'
--6.
SELECT name FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 27;
--7.
SELECT name FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Alien';
--8.
SELECT title FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';
--9.
SELECT title FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford' AND casting.ord != 1;
--10.
SELECT title, actor.name FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962 AND casting.ord = 1;
--11.
SELECT yr,COUNT(title) 
    FROM movie 
    JOIN casting ON movie.id=movieid
    JOIN actor   ON actorid=actor.id
WHERE actor.name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1;
--12.
SELECT title, actor.name FROM movie
JOIN casting ON casting.movieid = movie.id 
JOIN actor ON actor.id = casting.actorid
WHERE movie.id IN (
    SELECT casting.movieid FROM casting 
        JOIN actor ON actor.id = casting.actorid
        WHERE name='Julie Andrews') AND casting.ord = 1;
--13.
SELECT DISTINCT actor.name FROM casting
JOIN actor ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(ord) >= 15;
--14.
SELECT title, COUNT(casting.actorid) FROM movie
JOIN casting ON casting.movieid = movie.id
WHERE movie.yr= 1978
GROUP BY movie.title
ORDER BY COUNT(casting.actorid)DESC, movie.title ASC;
--15.
SELECT DISTINCT actor.name FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE movieid 
    IN (SELECT casting.movieid FROM actor JOIN casting ON casting.actorid = actor.id 
        WHERE actor.name = 'Art Garfunkel') 
    AND actor.name != 'Art Garfunkel';