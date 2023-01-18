Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=4d411f0bb173ebe7f0c62f338d6e4c98&hide=1

/* Напишите SQL-запросы, получающие текущее системное время, с использованием
функции CURRENT_TIMESTAMP для баз данных MS SQL, MySQL и Postgres */
SELECT CURRENT_TIMESTAMP AS 'CURRENT_TIME';

/* Напишите SQL-запросы, получающие текущее системное время, с использованием
функции getdate() для базы данных MS SQL. */
SELECT GetDate() AS 'Дата и время';

/* Функциями CAST выделите из результата функции GETDATE() в одну колонку часть, 
содержащую дату, а во вторую — часть, содержащую время */

SELECT GETDATE();
SELECT CAST(CURRENT_TIMESTAMP AS Date) AS 'Дата', CAST(CURRENT_TIMESTAMP AS Time) AS 'Время';
SELECT CONVERT(Date, CURRENT_TIMESTAMP) AS 'Дата', CONVERT(Time, CURRENT_TIMESTAMP) AS 'Время';

/* Функцией DATE_FORMAT преобразуйте результат действия функции NOW() в одну
колонку по формату ‘%Y -%m-%d’, а во вторую — по формату ‘%H:%i’ */

SELECT GETDATE() AS 'Системное время';
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd') AS 'Текущая дата'
SELECT FORMAT(GETDATE(), 'hh-mm') AS 'Часы и минуты'

SELECT CURRENT_TIMESTAMP AS 'CURRENT TIME';
SELECT DATEPART(year, current_timestamp) AS 'Год', DATEPART(month, current_timestamp) AS 'Месяц', DATEPART(day, current_timestamp) AS 'День', DATEPART(hour, current_timestamp) AS 'Часы', DATEPART(minute, current_timestamp) AS 'Минуты'; 

/* Напишите SQL-запрос к таблице skill_managers, который выполняет следующие
действия:
1. Запрашивает поле birth_date в виде Год/Месяц/День. Год должен состоять из
двух цифр, в качестве разделителя — использоваться символ ‘/’.
2. Запрашивает всех менеджеров, которые родились в январе, марте или мае. */

SELECT *
FROM skill_managers;

Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=ba2d887fb892a8e4bddffe2e76a8cf91&hide=1

/* Напишите SQL-запрос к таблице skill_managers, который выполняет следующие
действия:
1. Запрашивает поле birth_date в виде Год/Месяц/День. Год должен состоять из
двух цифр, в качестве разделителя — использоваться символ ‘/ */

SELECT FORMAT(birth_date, 'yy/MM/d')
FROM skill_managers;

/* 2. Запрашивает всех менеджеров, которые родились в январе, марте или мае. */
SELECT FORMAT(birth_date, 'yy/MM/d')
FROM skill_managers
WHERE DATEPART(month, birth_date) IN (01, 03, 05);

Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=e28dbd49dbd342dbf54acaac1ba6d28b&hide=1

/* 1. Напишите SQL-запрос к таблице skill_managers, получающий строку, у которой значение поля last_transaction_dt соответствует метке времени 2020-02-06 09:01:43. */
SELECT *
FROM skill_managers
WHERE last_transaction_dt = '2020-02-06 09:01:43';

/* 2. Напишите SQL-запрос к таблице skill_managers, получающий менеджеров с днём рождения (столбец birth_date) 1995-01-01. */
SELECT *
FROM skill_managers
WHERE birth_date = '1995-01-01';

/* 3. Напишите SQL-запрос к таблице skill_managers, получающий строки, у которых значения поля last_transaction_dt соответствуют дате 2020-11-15. */
SELECT *
FROM skill_managers
WHERE FORMAT(last_transaction_dt, 'yyyy-MM-dd') = '2020-11-15';

/* 4. Напишите SQL-запрос к таблице skill_managers, получающий строки, у которых значения поля last_transaction_dt соответствуют времени 12:36:43. */
SELECT *
FROM skill_managers
WHERE FORMAT(last_transaction_dt, 'hh:mm:ss') = '12:36:43';

/* Напишите SQL-запрос к таблице skill_managers, получающий все строки, у которых поле
last_transaction_dt датировано 2020-02-06.
1. В условии where не используйте никаких функций, только операторы сравнения.
2. В условии where используйте одно условие равенства и функцию конвертирования
типов данных.
3. В условии where используйте только функции datepart */

SELECT *
FROM skill_managers
WHERE last_transaction_dt BETWEEN '2020-02-06 00:00:00.000' AND '2020-02-06 23:59:59.999';

SELECT *
FROM skill_managers
WHERE FORMAT(last_transaction_dt, 'yyyy-MM-dd') = '2020-02-06' 

SELECT *
FROM skill_managers
WHERE DATEPART(year, last_transaction_dt) = '2020' AND DATEPART(month, last_transaction_dt) = '02' AND DATEPART(day, last_transaction_dt) = '06' 

/* С помощью функции CONVERT или CAST конвертируйте поле dt_string_v2 
в тип date и отформатируйте внешний вид даты функцией FORMAT по
формату 'yyyy MM dd’ */
SELECT FORMAT((CONVERT(DATETIME, dt_string_v2)), 'yyyy MM dd')
FROM skill_events;

/* Напишите SQL-запрос к таблице skill_managers, получающий менеджеров с
днём рождения (столбец birth_date) 1995-01-01. Для составления условия
используйте функцию DATEFROMPARTS */

SELECT *
FROM skill_managers
WHERE birth_date = DATEFROMPARTS(1995, 01, 01)

/* Напишите SQL-запрос к таблице skill_managers, получающий строку, 
у которой значение поля last_transaction_dt соответствует метке времени
2020-02-06 09:01:43. Для составления условия используйте функцию
DATETIMEFROMPARTS */
SELECT *
FROM skill_managers
WHERE last_transaction_dt = DATETIMEFROMPARTS(2020, 02, 06, 09, 01, 43, 000)

/* Напишите SQL-запросы к таблице skill_managers, выберите записи, у которых
значение поля last_transaction_dt >= ‘2020-03-27’ И <= следующего значения:
1. ‘2020-03-27’ плюс 720 часов
2. ‘2020-03-27’ плюс 30 дней
3. ‘2020-03-27’ плюс 1 месяц */

SELECT *
FROM skill_managers
WHERE last_transaction_dt >= '2020-03-27' AND last_transaction_dt <= DATEADD(hour, 720, '2020-03-27');