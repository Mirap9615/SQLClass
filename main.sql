-- Concad database, about the 163rd class
-- https://www.datacamp.com/tutorial/tutorial-sql-commands-for-data-scientists
CREATE DATABASE Concad;
USE Concad;

-- temporarily disable and reenable in order to allow for table drops
SET foreign_key_checks  = 0;

DROP TABLE IF EXISTS Students ;
DROP TABLE IF EXISTS Academic_Information;
DROP TABLE IF EXISTS Professors;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS ClassGrades;

SET foreign_key_checks  = 1;

CREATE TABLE Students (
    -- auto increment allows the database to automatically create and implement the values for you
    id INT PRIMARY KEY AUTO_INCREMENT,
    noble_rank VARCHAR(255),
    province VARCHAR(255),
    gender VARCHAR(255),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255)
);

CREATE TABLE Academic_Information (
    id INT AUTO_INCREMENT, -- primary key
    owner_id INT NOT NULL, -- foreign key, UNIQUE ensures that a student can only have one entry in academic record
    gpa FLOAT,
    dueling_performance FLOAT,
    semester INT,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES Students(id), -- links foreign key to column in another table
    UNIQUE(owner_id, semester), -- ensures that there are no duplicate semester values for a student
    CHECK(semester BETWEEN 1 and 20) -- ensures that the semester values remain within a reasonable range
);

CREATE TABLE Professors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    gender VARCHAR(255),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255),
    rating FLOAT
);

CREATE TABLE Classes (
    class_code VARCHAR(16) PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(64),
    description TEXT,
    students INT,
    professor INT,
    FOREIGN KEY (students) REFERENCES Students(id),
    FOREIGN KEY (professor) REFERENCES Professors(id)
);

CREATE TABLE ClassGrades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    class_code VARCHAR(16) NOT NULL,
    semester INT,
    grade FLOAT,
    FOREIGN KEY (owner_id) REFERENCES Students(id),
    FOREIGN KEY (class_code) REFERENCES Classes(class_code),
    UNIQUE(owner_id, class_code, semester),
    CHECK(grade BETWEEN 0 AND 120)
);

-- CREATE INDEX name_index ON Students(first_name);

INSERT INTO Students (noble_rank, province, gender, first_name, last_name)
VALUES
     ('None', 'Central', 'Female', 'Pecora', 'Vesta'),
    ('Marquess', 'Central', 'Female', 'Tami', 'Setai'),
    ('Marquess', 'Central', 'Female', 'Saki', 'Setai'),
    ('Archduke', 'Central', 'Female', 'Lyrasis', 'Pronco'),
    ('Grand Duke', 'Central', 'Female', 'Pentalon', 'Mirai'),
    ('Archduke', 'Lubryne', 'Female', 'Elira', 'Quante'),
    ('Baron', 'Ostia', 'Female', 'Felia', 'Brason'),
    ('Princess', 'Central', 'Female', 'Terra', 'Nova'),
    ('Knight', 'Stioqua', 'Female', 'Kira', 'Yelson'),
    ('Viscount', 'Noshar', 'Female', 'Lucia', 'Veran'),
    ('None', 'Overseas Territory', 'Female', 'Ulia', 'Merton'),
    ('Viscountess', 'Ascal', 'Female', 'Nora', 'Estelle'),
    ('None', 'Noshar', 'Female', 'Talia', 'Stellwyn'),
    ('Baron', 'Ostia', 'Female', 'Celia', 'Vayne'),
    ('Duke', 'Stioqua', 'Female', 'Irene', 'Almora'),
    ('Duke', 'Stioqua', 'Male', 'Julian', 'Estar'),
    ('Baron', 'Ascal', 'Male', 'Nevin', 'Liore'),
    ('None', 'Ostia', 'Male', 'Cassian', 'Ardel'),
    ('Knight', 'Lubryne', 'Male', 'Lysander', 'Fyrea'),
    ('Viscount', 'Central', 'Male', 'Edwin', 'Crest'),
    ('Count', 'Ascal', 'Male', 'Liam', 'Solaris'),
    ('None', 'Stioqua', 'Male', 'Alaric', 'Dawn'),
    ('None', 'Central', 'Male', 'Terrence', 'Locke'),
    ('Viscount', 'Lubryne', 'Male', 'Orion', 'Wylde'),
    ('Marquess', 'Noshar', 'Male', 'Victor', 'Slate'),
    ('None', 'Overseas Territory', 'Male', 'Dorian', 'Smiya'),
    ('Viscount', 'Ostia', 'Male', 'Finn', 'Marrow'),
    ('None', 'Central', 'Male', 'Callum', 'Brovost'),
    ('Archduke', 'Stioqua', 'Male', 'Julian', 'Earhart'),
    ('Marquess', 'Ostia', 'Female', 'Amy', 'Astra'), -- Note: Insert this entry based on the backstory provided for after the first year.
    ('Baron', 'Karjude', 'Female', 'Yara', 'Ndiaye'),
    ('Grand Duke', 'Etheria', 'Female', 'Kate', 'Vale'),
    ('Viscount', 'Dalnicia', 'Female', 'Selene', 'Quill'),
    ('Earl', 'Berland', 'Male', 'Nikolai', 'Arlen'),
    ('Duke', 'Etheria', 'Male', 'Matthias', 'Ritter');

INSERT INTO Classes (class_code, name, type, description)
VALUES
('LIB-101', 'Etiquette for the magic-capable', 'Culture', 'An introduction to etiquette when dealing with other magical-capables, high magical society in general'),
('LIB-155', 'Magical Laws I', 'Culture', 'Introduction to special laws that primarily apply to magic-capables.'),
('MG-100', 'History of Magic', 'History', 'An introductory course on the history of magic, foundation theory and other principles derived by the greats throughout history'),
('MG-101', 'Principles of Magic I', 'Theory', 'An introduction on the fundamental principles of magic, following an element-driven approach'),
('MG-102', 'Active Magic I', 'Practical', 'Deals with basic attack and transformative (moving) magic.'),
('MG-103', 'Defensive and Passive Magic I', 'Practical', 'Deals with barriers, defense theory and basic introduction to healing.'),
('MG-104', 'Magical Ethics I', 'Theory', 'When should magic be used, and when should it not be used?'),
('MG-105', 'Soft Magic I', 'Theory', 'Soft magic concerns oneself with the world with the absence of sicutian magic: observing natural phenomena, such as the moon, sun, other stars, the ocean, and more, and deriving meaning from them.');


INSERT INTO ClassGrades(owner_id, class_code, semester, grade)
VALUES
    -- Pecora Vesta
    (1, 'LIB-101', 1, 91.5),
    (1, 'LIB-155', 1, 91.5),
    (1, 'MG-100', 1, 108.5),
    (1, 'MG-101', 1, 105),
    (1, 'MG-102', 1, 115),
    (1, 'MG-103', 1, 105),
    (1, 'MG-104', 1, 98.5),
    (1, 'MG-105', 1, 107.5),
    -- Tami Setai
    (2, 'LIB-101', 1, 93),
    (2, 'LIB-155', 1, 87),
    (2, 'MG-100', 1, 88),
    (2, 'MG-101', 1, 92),
    (2, 'MG-102', 1, 85),
    (2, 'MG-103', 1, 90),
    (2, 'MG-104', 1, 92.5),
    (2, 'MG-105', 1, 94),

    -- Saki Setai
    (3, 'LIB-101', 1, 102),
    (3, 'LIB-155', 1, 105),
    (3, 'MG-100', 1, 113),
    (3, 'MG-101', 1, 107),
    (3, 'MG-102', 1, 78),
    (3, 'MG-103', 1, 81),
    (3, 'MG-104', 1, 99),
    (3, 'MG-105', 1, 88),

    -- Lyrasis Pronco
    (4, 'LIB-101', 1, 101),
    (4, 'LIB-155', 1, 104),
    (4, 'MG-100', 1, 110),
    (4, 'MG-101', 1, 108),
    (4, 'MG-102', 1, 112),
    (4, 'MG-103', 1, 109),
    (4, 'MG-104', 1, 105.5),
    (4, 'MG-105', 1, 107),

    -- Pentalon
    (5, 'LIB-101', 1, 98),
    (5, 'LIB-155', 1, 96),
    (5, 'MG-100', 1, 98),
    (5, 'MG-101', 1, 95),
    (5, 'MG-102', 1, 101),
    (5, 'MG-103', 1, 96),
    (5, 'MG-104', 1, 93),
    (5, 'MG-105', 1, 97);


-- @block
-- SELECT first_name, gender FROM Students
-- colons serve as block destroyers in mySQL.

-- Bulk calculate and insert GPA information:
/*
INSERT INTO Academic_Information(owner_id, gpa, semester)
-- removing WHERE is ideal for performing bulk operations efficiently.
SELECT
    owner_id,
    AVG(grade) AS gpa,
    ClassGrades.semester
FROM
    ClassGrades
GROUP BY
    owner_id, semester;
*/

-- SELECT * FROM Students
-- WHERE province = 'Central' AND id > 1
-- LIKE selects all entries that fits the pattern; in this case, all that starts with P
-- AND first_name LIKE 'P%'
-- ORDER BY id DESC;
-- LIMIT 2;

INSERT INTO Academic_Information (owner_id, gpa, semester)
VALUES
    (1, 102.812, 1),
    (2, 94.3, 1),
    (3, 85, 1),
    (4, 107, 1),
    (5, 96.8, 1),
    (6, 83, 1),
    (7, 40, 1),
    (8, 92, 1),
    (9, 53, 1),
    (10, 49, 1),
    (11, 98.4, 1),
    (12, 89.5, 1),
    (13, 51, 1),
    (14, 61.2, 1),
    (15, 77.4, 1),
    (16, 94, 1),
    (17, 54.2, 1),
    (18, 58.8, 1),
    (19, 88.1, 1),
    (20, 93, 1),
    (21, 82.8, 1),
    (22, 73, 1),
    (23, 68.3, 1),
    (24, 96.2, 1),
    (25, 98.7, 1),
    (26, 65, 1),
    (27, 63, 1),
    (28, 71.6, 1),
    (29, 89.2, 1),
    (30, NULL, 1),
    (31, 70.1, 1),
    (32, 97.3, 1),
    (33, 79, 1),
    (34, 80, 1),
    (35, 88.7, 1);

INSERT INTO Professors(gender, first_name, last_name, rating)
VALUES
    ();

-- SELECT * FROM Academic_Information
-- ORDER BY gpa DESC;

-- DISTINCT returns all unique values
/*
SELECT DISTINCT province
FROM Students;
 */


-- in SQL, you can pool multiple tables together using FROm and JOIN, and SELECT attributes from any of the pooled classes.
SELECT
    Students.first_name AS First_Name,
    Students.last_name AS Last_Name,
    Students.noble_rank AS 'Rank',
    Students.province AS Province,
    Students.gender AS Gender,
    Academic_Information.gpa AS GPA,
    Academic_Information.semester AS `Term`,
    ROUND((Academic_Information.gpa - (SELECT AVG(gpa) FROM Academic_Information))) AS Deviation_From_the_Mean
FROM
    Academic_Information
JOIN
    -- ON basically picks out the rows when the boolean evaluates to True
    Students ON Academic_Information.owner_id = Students.id
ORDER BY
    Academic_Information.gpa DESC;

