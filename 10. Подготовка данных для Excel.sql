Link: https://dbfiddle.uk/?rdbms=mysql_8.0&fiddle=da24508b83837e358e985b931a15f528&hide=1

/* Используя функцию split_str, напишите запрос (запросы), разделяющий (разделяющие) данные из таблицы skill_raw_data_mix на отдельные колонки. 
При написании запроса необходимо учесть,  что часть строк таблицы использует как разделитель между колонками символ запятой, а другая  часть — символ точку с запятой. */
UPDATE skill_raw_data_mix
SET data = REPLACE(data, ';', ',');

SELECT split_str(data,',',1) id,
       split_str(data,',',2) dt,
       split_str(data,',',3) tm,
       split_str(data,',',4) product_categoty,
       split_str(data,',',5) product,
       split_str(data,',',6) office,
       split_str(data,',',7) cnt,
       split_str(data,',',8) price
FROM skill_raw_data_mix;

/* Напишите SQL-запросы к таблице skill_sales:
1.	Получающий SQL-скрипт создания таблицы
*/
SHOW create table skill_sales; 

/* 2.	Получающий названия и типы всех колонок таблицы */
DESCRIBE skill_sales;

/* 3.	Получающий список уникальных названий офисов */
SELECT DISTINCT office
FROM skill_sales;

/* 1.	Получающий SQL-скрипт создания таблицы
2.	Получающий названия и типы всех колонок таблицы
3.	Получающий список уникальных названий офисов
4.	Если в данных присутствует название офисов на русском языке, напишите запрос, получающий все колонки и все строки таблицы с исправлением названий офисов. Офисы должны называться единообразно, на английском языке — ‘office’ и буква названия офиса 
*/
UPDATE skill_sales
SET office = REPLACE(office, 'оффис', 'office');

SELECT DISTINCT office 
FROM skill_sales;

/* Ссылка № 1 — тестовая среда — в описании к модулю.
Напишите SQL-запросы к таблице skill_sales:
1. Получающий общие суммы проданного товара по дням, за весь период 
данных, распределённого по типам офисов */
SELECT dt, office, SUM(cnt*price) AS 'Total By Day'
FROM skill_sales
GROUP BY dt, office;

/* 2. Получающий список наименований товаров, проданных за весь период 
данных, отсортированный в порядке уменьшения общей суммы, полученной 
по каждому наименованию товара */

SELECT product, SUM(cnt*price) AS Total
FROM skill_sales
GROUP BY product
ORDER BY Total DESC;

Link: https://dbfiddle.uk/?rdbms=mysql_8.0&fiddle=eca6a84e266029a7d2801caf2fa273b6&hide=1

/* Выполните следующие действия:
1. Напишите SQL-запрос, получающий скрипт создания таблицы справочника product */
SHOW CREATE TABLE product;

/* 2. Измените полученный скрипт для создания справочника для названий офисов (назовите 
справочник office) */
CREATE TABLE `office` (
  `office_id` int NOT NULL AUTO_INCREMENT,
  `office` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

/* 3. Напишите SQL-запросы, заполняющие справочники product и созданный справочник в п. 2 — 
office данными из таблицы skill_sales 
4. Выведите содержимое справочников product и office на экран
*/
INSERT INTO office (office)
SELECT DISTINCT office
FROM skill_sales;

SELECT * FROM office;

INSERT INTO product (product)
SELECT DISTINCT product
FROM skill_sales;

SELECT * FROM product;