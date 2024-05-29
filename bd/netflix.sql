CREATE DATABASE Netflix;
USE Netflix;

CREATE TABLE Movie (
idMovies int auto_increment not null primary key,
title varchar (45) not null,
genre varchar (45) not null,
image varchar (1000) not null,
category varchar (45) not null,
year smallint
);

CREATE TABLE User (
idUser int auto_increment not null primary key,
user varchar (45) not null unique,
password varchar (45) not null,
name varchar (45) not null,
email varchar (45) not null unique,
plan_details varchar (45) not null
); 

CREATE TABLE actors (
idActor int auto_increment not null primary key,
name varchar (45) not null,
lastName varchar (45) not null,
country varchar (45) not null,
birthday date
); 

INSERT INTO movie (title, genre, image, category, year)
VALUES (' Pulp Fiction', 'Crimen', 'https://pics.filmaffinity.com/pulp_fiction-210382116-large.jpg', 'Top 10', '1994'),
	(' La vita è bella', 'Comedia', 'https://pics.filmaffinity.com/la_vita_e_bella-646167341-mmed.jpg', 'Top 10', '1996'),
    (' Forrest Gump', 'Comedia', 'https://pics.filmaffinity.com/forrest_gump-212765827-mmed.jpg', 'Top 10', '1994');

INSERT INTO user (user, password, name, email, plan_details)
VALUES ('laura_dev', 'laura', 'Laura', 'laura@gmail.com', 'Standard'),
		('maria_dev', 'maria', 'Maria', 'maria@gmail.com', 'Standard'),
        ('ester_dev', 'ester', 'Ester', 'ester@gmail.com', 'Standard');

INSERT INTO actors (name, lastname, country, birthday)
VALUES ('Tom', 'Hanks', 'Estados Unidos', '1956-07-09'),
		('Roberto', 'Benigni', 'Italia', '1952-10-27'),
        ('John', 'Travolta', 'Estados Unidos', '1954-02-18'); 
	
    #esta es una prueba
    
SELECT * FROM movie;
SELECT title, genre FROM movie WHERE year > '1990';
SELECT * FROM movie WHERE category = 'Top 10';
UPDATE movie set year = 1997 WHERE title = ' La vita è bella';

SELECT * FROM actors;
SELECT * FROM actors WHERE birthday > '1950-01-01' and birthday < '1960-01-01';
SELECT name, lastname FROM actors WHERE country = 'Estados unidos';

SELECT * FROM user;
DELETE FROM user WHERE name LIKE 'M%';

ALTER TABLE actors ADD img text;
SELECT * FROM actors;


#eliminar tabla
# DROP [TEMPORARY] TABLE [IF EXISTS]
# tbl_name [, tbl_name] ...
# [RESTRICT | CASCADE]

#delete DB
# DROP {DATABASE | SCHEMA} [IF EXISTS] db_name
    