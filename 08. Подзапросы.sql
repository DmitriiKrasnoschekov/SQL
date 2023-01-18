Link : https://dbfiddle.uk/?rdbms=sqlserver_2017&fiddle=5a304ac9ae070cf985474a5a8fd419f4&hide=1

/* Выбрать в таблице за март все записи, даты которых есть в сентябрьской таблице */
SELECT *
FROM skill_sales_march
WHERE dt IN (
SELECT dt
FROM skill_sales_september);

/* Выбрать продажи HDD из таблицы skill_sales_march */
SELECT *
FROM skill_sales_march
WHERE product_id = (
SELECT product_id
FROM skill_product
WHERE product_name = 'HDD')

/* Выбрать продажи менеджеров по фамилии Форбс или Уолл */
SELECT *
FROM skill_sales_march
WHERE manager_id IN (
SELECT manager_id
FROM skill_managers
WHERE last_name = 'Forbes' OR last_name = 'Wall'
)

/* Выбрать количество продаж в марте и апреле в разрезе имен и фамилиий менеджеров */
SELECT first_name, last_name,
(SELECT SUM(t2.cnt) FROM skill_sales_march t2
WHERE t1.manager_id = t2.manager_id) cnt_march,
(SELECT SUM(t3.cnt) FROM skill_sales_april t3
WHERE t1.manager_id = t3.manager_id) cnt_april
FROM skill_managers t1;

/* Выбрать топ 5 дат по продаже за март и апрель */
SELECT TOP 5 dt, SUM(cnt) AS 'Sum of Sales'
FROM
(SELECT * FROM skill_sales_march
UNION ALL
SELECT * FROM skill_sales_april) a
GROUP BY dt
ORDER BY SUM(cnt) DESC;

/* 1.	Напишите запрос к таблице skill_sales_april, получающий все столбцы. Наложите условие 
на значения колонки product_id, получающее значения из таблицы skill_product подзапросом, 
в котором задаётся условие product_name='Motherboard’ в явном виде. */
SELECT *
FROM skill_sales_april
WHERE product_id = 
(
SELECT product_id
FROM skill_product
WHERE product_name = 'Motherboard'
)

/* 2.	Напишите запрос к таблице skill_product. Выведите следующие столбцы: - название товаров (product_name), - 
количество продаж данного товара за март (подзапрос 
к таблице skill_sales_march), - количество продаж данного товара за апрель (подзапрос к таблице skill_sales_april). */
SELECT product_name,
(SELECT SUM(cnt) FROM skill_sales_march t2
WHERE t2.product_id = t1.product_id) cnt_march,
(SELECT SUM(cnt) FROM skill_sales_april t3
WHERE t3.product_id = t1.product_id) cnt_april
FROM skill_product t1;

Link: https://dbfiddle.uk/?rdbms=sqlserver_2017&fiddle=4450352316aad14e6308424c7932e01f&hide=1

/* 1. Создайте таблицу test со следующими столбцами:
• field1 — тип int,
• field2 — тип float,
• field3 — тип varchar(50) */
CREATE TABLE test(
field1 INT,
field2 FLOAT,
field3 VARCHAR(50))

/* 2. Напишите select к таблице test */
SELECT * 
FROM test;

/* 3. Удалите таблицу test из базы данных. */
DROP TABLE IF EXISTS test;

/* 1. Добавьте в таблицу skill_sales следующие строки данных: */
INSERT into skill_sales
(dt, manager_id, product_id, cnt)
VALUES
('2020-12-31', 1, 1, 100),
('2020-12-31', 2, 1, 100),
('2020-12-31', 3, 1, 100)

SELECT * FROM skill_sales;

/* 2. Добавьте в таблицу skill_sales все строки из таблицы skill_sales_september
с датами продаж за апрель. */
INSERT INTO skill_sales
SELECT * FROM skill_sales_september
WHERE dt IN (
SELECT dt FROM skill_sales_april
)

SELECT * FROM skill_sales;

/* 1. Увеличьте количество проданного товара в таблице skill_sales_september
в 100 раз по product_id 1 и 5 */
UPDATE skill_sales_september
SET cnt = cnt*100
WHERE product_id IN (1,5)

SELECT * FROM skill_sales_september

/* 2. Из таблицы skill_sales_september удалите строки, дата продаж которых 
не относится к сентябрю. */

DELETE FROM skill_sales_september
WHERE MONTH(dt) != 9

SELECT * FROM skill_sales_september;

/* SELECT * FROM skill_sales_march_monthly; */
ALTER TABLE skill_sales_march_monthly
DROP COLUMN year, month;

/* 2. Добавьте столбец dt с типом данных date. */
ALTER TABLE skill_sales_march_monthly 
ADD dt date;

/* Проверьте корректность изменения структуры таблицы skill_sales_march_monthly
следующим запросом вставки данных из таблицы skill_sales_march_monthly: */
insert into skill_sales_march_monthly
select manager_id,product_id,cnt,dt from skill_sales_march