-- Drop database if exists and create a new one
DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;
USE movies;

-- Create the Genres table
CREATE TABLE Genres (
genre_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50)
);

-- Create the Directors table
CREATE TABLE Directors (
director_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50)
);

-- Create the Actors table
CREATE TABLE Actors (
actor_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
birth_date DATE
);

-- Create the Movies table
CREATE TABLE Movies (
movie_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255),
release_date DATE,
duration INT,
genre_id INT,
director_id INT,
synopsis TEXT,
rating FLOAT,
CONSTRAINT FK_Movies_Genres FOREIGN KEY (genre_id) REFERENCES Genres (genre_id),
CONSTRAINT FK_Movies_Directors FOREIGN KEY (director_id) REFERENCES Directors (director_id)
);

-- Create the Movie_Actors table
CREATE TABLE Movie_Actors (
movie_id INT,
actor_id INT,
character_name VARCHAR(255),
CONSTRAINT PK_Movie_Actors PRIMARY KEY (movie_id, actor_id),
CONSTRAINT FK_Movie_Actors_Movies FOREIGN KEY (movie_id) REFERENCES Movies (movie_id) ON DELETE CASCADE,
CONSTRAINT FK_Movie_Actors_Actors FOREIGN KEY (actor_id) REFERENCES Actors (actor_id) ON DELETE CASCADE
);

-- Create the Users table
CREATE TABLE Users (
user_id INT PRIMARY KEY,
username VARCHAR(255),
email VARCHAR(255)
);

-- Create the Reviews table
CREATE TABLE Reviews (
review_id INT PRIMARY KEY,
movie_id INT,
user_id INT,
rating FLOAT,
comment VARCHAR(255),
CONSTRAINT FK_Reviews_Movies FOREIGN KEY (movie_id) REFERENCES Movies (movie_id) ON DELETE CASCADE,
CONSTRAINT FK_Reviews_Users FOREIGN KEY (user_id) REFERENCES Users (user_id) ON DELETE CASCADE
);


-- Insert sample data into Genres table
INSERT INTO Genres (genre_id, name)
VALUES
(1, 'Drama'),
(2, 'Crime'),
(3, 'Sci-Fi'),
(4, 'Animation');

-- Insert sample data into Directors table
INSERT INTO Directors (director_id, name)
VALUES
(1, 'Frank Darabont'),
(2, 'Francis Ford Coppola'),
(3, 'Christopher Nolan'),
(4, 'Rob Minkoff, Roger Allers');


-- Insert sample data into Actors table
INSERT INTO Actors (actor_id, name, birth_date)
VALUES
(1, 'Tom Hanks', '1956-07-09'),
(2, 'Meryl Streep', '1949-06-22'),
(3, 'Robert Downey Jr.', '1965-04-04'),
(4, 'Leonardo DiCaprio', '1974-11-11'),
(5, 'Emma Stone', '1988-11-06');


-- Insert sample data into Movies table
INSERT INTO Movies (movie_id, title, release_date, genre_id, director_id, synopsis, rating)
VALUES
(1, 'The Shawshank Redemption', '1994-09-22', 1, 1, 'About two imprisoned men bond over several years...', 9.3),
(2, 'The Godfather', '1972-03-14', 2, 2, 'The aging patriarch of an organized crime dynasty...', 9.2),
(3, 'Inception', '2010-07-16', 3, 3, 'About a thief who steals corporate secrets...', 8.8),
(4, 'The Lion King', '1994-06-24', 4, 4, 'Life of a young lion prince...', 8.5);

-

-- Insert sample data into Movie_Actors table
INSERT INTO Movie_Actors (movie_id, actor_id, character_name)
VALUES
(1, 1, 'Andy Dufresne'),
(1, 2, 'Red'),
(2, 3, 'Michael Corleone'),
(3, 4, 'Cobb'),
(3, 5, 'Mia');


-- Insert sample data into Users table
INSERT INTO Users (user_id, username, email)
VALUES
(1, 'user1', 'user1@gmail.com'),
(2, 'user2', 'user2@yahoo.com'),
(3, 'user3', 'user3@icloud.com');


-- Insert sample data into Reviews table
INSERT INTO Reviews (review_id, movie_id, user_id, rating, comment)
VALUES
(1, 1, 1, 8.5, 'It’s a great movie! Loved the performances of the actors.'),
(2, 1, 2, 9.0, 'The story was captivating. Highly recommended.'),
(3, 2, 1, 9.5, 'It’s a Classic masterpiece. Must-watch.'),
(4, 3, 2, 8.0, 'Mind-bending plot plus it has stunning visuals.');




-- Inserting rows into the Actors table
INSERT INTO `Actors` (`actor_id`, `name`, `birth_date`) VALUES
(6, 'Brad Pitt', '1963-12-18'),
(7, 'Jennifer Lawrence', '1990-08-15'),
(8, 'Johnny Depp', '1963-06-09');

-- Inserting rows into the Directors table
INSERT INTO `Directors` (`director_id`, `name`) VALUES
(5, 'Quentin Tarantino'),
(6, 'Steven Spielberg'),
(7, 'Martin Scorsese');

-- Inserting rows into the Genres table
INSERT INTO `Genres` (`genre_id`, `name`) VALUES
(5, 'Action'),
(6, 'Comedy'),
(7, 'Romance');

-- Inserting rows into the Movies table
INSERT INTO `Movies` (`movie_id`, `title`, `release_date`, `duration`, `genre_id`, `director_id`, `synopsis`, `rating`) VALUES
(5, 'Fight Club', '1999-10-15', NULL, 5, 5, 'An insomniac office worker and a devil-may-care soapmaker...', 8.8),
(6, 'The Shawshank Redemption', '1994-09-22', NULL, 1, 1, 'About two imprisoned men bond over several years...', 9.3),
(7, 'Pulp Fiction', '1994-10-14', NULL, 5, 5, 'The lives of two mob hitmen, a boxer, a gangster...', 8.9);

-- Inserting rows into the Movie_Actors table
INSERT INTO `Movie_Actors` (`movie_id`, `actor_id`, `character_name`) VALUES
(5, 6, 'Tyler Durden'),
(6, 3, 'Andy Dufresne'),
(6, 2, 'Red'),
(7, 6, 'Jules Winnfield');

-- Inserting rows into the Reviews table
INSERT INTO `Reviews` (`review_id`, `movie_id`, `user_id`, `rating`, `comment`) VALUES
(5, 5, 1, 9.5, 'A mind-blowing movie with an amazing performance by Brad Pitt.'),
(6, 6, 3, 10, 'One of the best movies ever made. Highly recommended.'),
(7, 7, 2, 9, 'A cult classic with memorable dialogues and scenes.');

-- Inserting rows into the Users table
INSERT INTO `Users` (`user_id`, `username`, `email`) VALUES
(4, 'user4', 'user4@example.com'),
(5, 'user5', 'user5@example.com'),
(6, 'user6', 'user6@example.com');


-- Multi-table Query Example
SELECT
    m.title AS movie_title,
    a.name AS actor_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM
    Movies m
JOIN
    Movie_Actors ma ON m.movie_id = ma.movie_id
JOIN
    Actors a ON ma.actor_id = a.actor_id
LEFT JOIN
    Reviews r ON m.movie_id = r.movie_id
GROUP BY
    m.title, a.name
HAVING
    COUNT(r.review_id) > 0
ORDER BY
    average_rating DESC;
    
    

-- Multi-table Subquery Example
SELECT
    m.title AS movie_title,
    m.release_date,
    (
        SELECT
            COUNT(ra.actor_id)
        FROM
            Movie_Actors ra
        WHERE
            ra.movie_id = m.movie_id
    ) AS actor_count
FROM
    Movies m
WHERE
    m.genre_id = 1
ORDER BY
    m.release_date DESC;
    
    
    
-- Updatable Single Table View Example
CREATE VIEW UpdatableMovies AS
SELECT
    movie_id,
    title,
    release_date,
    duration,
    genre_id,
    director_id,
    synopsis,
    rating
FROM
    Movies
WHERE
    release_date > '2000-01-01';

-- Query against the Updatable View before changes
SELECT * FROM UpdatableMovies;

-- 2. Update Statement against the View to make a change in the state of the data
UPDATE UpdatableMovies
SET duration = 150
WHERE movie_id = 3;

-- 3. Query against the view to show the state of the data changed because of the Update Statement
SELECT * FROM UpdatableMovies;

-- 4. Insert Statement against the View to add a new record
INSERT INTO UpdatableMovies (movie_id, title, release_date, duration, genre_id, director_id, synopsis, rating)
VALUES (8, 'New Movie', '2023-01-01', 120, 1, 1, 'A brand new movie', 7.5);

-- 5. Query against the view to show the state of the data changed because of the Insert Statement
SELECT * FROM UpdatableMovies;




-- Stored Procedure Example
DROP PROCEDURE IF EXISTS CalculateAverageRating;
DELIMITER //

CREATE PROCEDURE CalculateAverageRating()
BEGIN
    DECLARE avg_rating DECIMAL;

    -- Calculate average rating
    SELECT ROUND(AVG(rating), 2) INTO avg_rating
    FROM Reviews;

    -- Print the calculated value
    SELECT CONCAT('Average Rating: ', avg_rating) AS result;

END //

DELIMITER ;

-- Call the Stored Procedure
CALL CalculateAverageRating();




-- Stored Function Example
DROP FUNCTION IF EXISTS CalculateAge;
-- Stored Procedure Example
DELIMITER //
CREATE PROCEDURE CalculateAge(IN birthdate DATE)
BEGIN
    DECLARE current_date DATE;
    DECLARE age INT;

    -- Get the current date
    SELECT CURDATE() INTO current_date;

    -- Calculate age
    SET age = YEAR(current_date) - YEAR(birthdate);

    -- Print the calculated age
    SELECT age;
END //
DELIMITER ;








-- Creating indexes
CREATE INDEX idx_movies_release_date ON Movies(release_date);
CREATE INDEX idx_movies_genre_id ON Movies(genre_id);
CREATE INDEX idx_movies_director_id ON Movies(director_id);

CREATE INDEX idx_actors_birth_date ON Actors(birth_date);

CREATE INDEX idx_reviews_movie_id ON Reviews(movie_id);
CREATE INDEX idx_reviews_user_id ON Reviews(user_id);