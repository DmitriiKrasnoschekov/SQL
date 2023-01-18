Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=3075241a309629f7cab9065301e065a3&hide=1

/* Напишите SQL-запросы к таблице skill_cities, которые выводят все столбцы, а также:
1. Все строки, отсортировав их по возрастанию численности населения (поле population).
2. Все строки, отсортировав их по убыванию численности населения (поле population).
3. Все строки, отсортировав их по коду страны (поле country_id), а внутри страны отсортировав по убыванию численности населения (поле population).
4. Данные только по России (country_id = 9) и все колонки, отсортировав их по убыванию численности населения (поле population). 
*/

SELECT * 
FROM skill_cities
ORDER BY population;

SELECT *
FROM skill_cities
ORDER BY population DESC;

SELECT *
FROM skill_cities
ORDER BY country_id, population DESC;

SELECT *
FROM skill_cities
WHERE country_id = 9
ORDER BY population DESC;

/* Напишите SQL-запросы к таблице skill_customers.
1. Выведите строки таблицы, которые удовлетворяют условию:
Имя (first_name) — это имя ‘Piter’, независимо от наличия концевых пробелов.
Для задания условия отбора используете функцию trim. В результат необходимо вывести все колонки таблицы.
2. Доработайте предыдущий SQL-запрос так, чтобы колонки first_name и last_name не содержали концевых пробелов. Сохраните в результирующей таблице наименования колонок такими, какими они заданы в базе данных.
3. Отсортируйте запрос из предыдущего пункта задания по колонке age (по возрастанию). 
*/

SELECT customer_id, TRIM(first_name) AS first_name, TRIM(last_name) AS last_name, age, gender
FROM skill_customers
WHERE TRIM(first_name) = 'Piter'

/* Напишите SQL-запросы к таблице skill_managers, которые выводят:
1. Столбцы first_name и last_name ПРОПИСНЫМИ буквами.
2. Столбцы first_name и last_name строчными буквами. 
*/

SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name
FROM skill_customers;

SELECT LOWER(first_name) AS first_name, LOWER(last_name) AS last_name
FROM skill_customers;
/* 1. Напишите SQL-запрос к таблице skill_fix, который выводит данные: в первую колонку имя менеджера, а во вторую — фамилию менеджера.
Данные нужно выделить из поля str_columns с помощью функции SUBSTRING и очистить от концевых пробелов.
2. Напишите SQL-запрос к таблице skill_managers, который выводит данные по фильтру: last_name начинается с ’Mac’. В результирующую таблицу выведите две колонки — last_name и колонку из last_name без начальных букв ’Mac’. 

/* Substring(<колонка>, стартовая позиция, длина */
SELECT TRIM(SUBSTRING(str_columns, 5, 8)) AS first_name, TRIM(SUBSTRING(str_columns, 14, 13)) AS last_name
FROM skill_fix;

SELECT last_name, TRIM(SUBSTRING(last_name, 4, 6)) AS last_name_without_MAC
FROM skill_managers
WHERE last_name LIKE 'Mac%';

/* Напишите SQL-запросы к таблице skill_managers, получающие список менеджеров по условию: фамилия начинается на ‘Mac’.
Для разных БД напишите запросы, использующие следующие функции:
1. Для MS SQL: charindex.
2. Для MySQL: locate, instr и position.
3. Для PostgreSQL: strpos и position. 
*/

SELECT *
FROM skill_managers
WHERE charindex('Mac', last_name) = 1;