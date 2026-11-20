DROP TABLE IF EXISTS a_merkulov_psb.test_table;

CREATE TABLE a_merkulov_psb.test_table (
	test_id Serial PRIMARY KEY,
	"name" varchar(20),
	book varchar(40),
	genre varchar(20),
	amount int
) 
DISTRIBUTED BY (test_id);

SELECT * FROM a_merkulov_psb.test_table ORDER BY 1;

INSERT INTO a_merkulov_psb.test_table (
	"name", book, genre, amount
)
VALUES
('А. Блок', 'Двеннадцать', 'Поэзия', 1),
('А. Пушкин', 'Руслан и Людмила', 'Поэзия', 2),
('М. Булгаков', 'Мастер и Маргарита', 'Роман', 3),
('Ф. Достоевский', 'Преступление и наказание', 'Роман', 1);
