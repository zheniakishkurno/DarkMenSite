
drop DATABASE if exists my_database;
CREATE DATABASE if not exists my_database;
use my_database;

CREATE TABLE IF NOT EXISTS darkmen (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
age INT,
gender VARCHAR(10),
availableTime VARCHAR(50),
phoneNumber VARCHAR(20),
rating FLOAT,
image VARCHAR(255)
);

-- Inserting data with adjusted id values
INSERT INTO darkmen (id, name, age, gender, availableTime, phoneNumber, rating, image)
VALUES
(1, 'Омар', 30, 'Мужчина', '8:00 - 18:00', '+375441234567', 0, './img/worker.jpg'),
(2, 'Алексей', 28, 'Мужчина', '9:00 - 19:00', '+375441234568', 0, './img/3.jpg'),
(3, 'Иван', 35, 'Мужчина', '10:00 - 20:00', '+375441234569', 0, './img/4.png'),
(4, 'Максим', 25, 'Мужчина', '7:00 - 17:00', '+375441234111', 0, './img/5.jpg'),
(5, 'Дмитрий', 32, 'Мужчина', '8:00 - 18:00', '+375441114569', 0, './img/6.jpg'),
(6, 'Николай', 29, 'Мужчина', '9:00 - 19:00', '+375441211169', 0, './img/14.png'),
(7, 'Андрей', 27, 'Мужчина', '8:00 - 18:00', '+375441214569', 0, './img/8.jpg'),
(8, 'Евгений', 31, 'Мужчина', '9:00 - 19:00', '+375441234511', 0, './img/9.jpg'),
(9, 'Сергей', 33, 'Мужчина', '10:00 - 20:00', '+375441233569', 0, './img/10.jpg'),
(10, 'Андрей', 27, 'Мужчина', '8:00 - 18:00', '+375441234599', 0, './img/11.jpg'),
(11, 'Евгений', 31, 'Мужчина', '9:00 - 19:00', '+375441234559', 0, './img/7.png'),
(12, 'Сергей', 33, 'Мужчина', '10:00 - 20:00', '+375441234469', 0, './img/13.jpg');

-- Retrieve data from darkmen table
SELECT * FROM darkmen;