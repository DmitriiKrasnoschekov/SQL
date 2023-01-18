Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=c72f733eeeefd8a5fb5fb2ac09badf12&hide=1

/* Напишите SQL-запросы к таблице skill_managers, которые выводят списки менеджеров по следующим условиям:
1.	Менеджеры с возрастом 25 лет
2.	Менеджеры с возрастом 33 года
3.	Менеджеры женского пола
4.	Менеджеры с именем Piter
*/

SELECT *
FROM skill_managers
WHERE age = 25;

SELECT *
FROM skill_managers
WHERE age = 33;

SELECT * 
FROM skill_managers
WHERE gender = 'F'

SELECT *
FROM skill_managers
WHERE first_name = 'Piter'

/* Напишите SQL-запросы к таблице skill_managers, которые выводят списки менеджеров по следующим условиям:
1.	Менеджеры с возрастом более 25 лет 
2.	Менеджеры с возрастом 25 и более лет
3.	Менеджеры с возрастом менее 33 лет
4.	Менеджеры с возрастом 33 и менее лет
*/

SELECT *
FROM skill_managers
WHERE age > 25;

SELECT *
FROM skill_managers
WHERE age >= 25;

SELECT *
FROM skill_managers 
WHERE age < 33;

SELECT *
FROM skill_managers
WHERE age <= 33;

/* 
Напишите SQL-запросы к таблице skill_managers, которые выводят списки менеджеров по следующим условиям:
1.	Менеджеры с возрастом, не равным 25 годам
2.	Менеджеры с возрастом 27, 29 или 31 год
3.	Менеджеры женского пола с возрастом 25 и старше
4.	Менеджеры женского пола с возрастом 21 или 31
*/

SELECT *
FROM skill_managers
WHERE NOT age = 25;

SELECT * 
FROM skill_managers
WHERE age = 27 OR age = 29 OR age = 31;

SELECT * 
FROM skill_managers
WHERE gender = 'F' AND age >= 25;

SELECT *
FROM skill_managers
WHERE gender = 'F' AND (age = 21 OR age = 31)

/* 
Напишите SQL-запросы к таблице skill_managers, которые выводят списки менеджеров по следующим условиям:
1.	Менеджеры с возрастом 25, 33, 37, 42 – используйте оператор IN
2.	Менеджеры с именами Piter, Kaiden, Lacey – используйте оператор IN
3.	Менеджеры возрастом в диапазоне от 40 до 50 лет – используйте оператор BETWEEN
4.	Менеджеры, фамилия которых начинается на ‘Mac’
5.	Менеджеры, фамилия которых заканчивается на ‘nen’
*/

SELECT * 
FROM skill_managers
WHERE age IN (25, 33, 37, 42);

SELECT *
FROM skill_managers
WHERE first_name IN ('Piter', 'Kaiden', 'Lacey')

SELECT *
FROM skill_managers
WHERE age BETWEEN 40 AND 50;

SELECT *
FROM skill_managers
WHERE last_name LIKE 'Mac%'

SELECT *
FROM skill_managers
WHERE last_name LIKE '%nen'