Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=918fc043deb3b5d6497ea57afc372855&hide=1

/* Напишите SQL-запросы к таблице skill_sales, в которой содержатся накладные по продаже компьютерных комплектующих
и программного обеспечения:
1. Подсчитайте количество накладных (одна накладная – это одна строка в таблице). */
SELECT COUNT(sale_dt) AS 'Количество накладных'
FROM skill_sales;

/* 2. Подсчитайте общее количество всех товаров в накладных (поле cnt содержит количество товара в одной накладной */
SELECT SUM(cnt) AS 'Общее количество товаров в накладных'
FROM skill_sales;

/* 3. Подсчитаете одним запросом среднюю, минимальную и максимальную цену товара среди всех накладных (для расчёта
используйте колонку price_usd – цена товара в долларах). */
SELECT ROUND(AVG(price_usd), 2) AS 'Средняя цена', MIN(price_usd) AS 'Минимальная цена', MAX(price_usd) AS 'Максимальная цена'
FROM skill_sales;

/* 1. Запросите список всех товаров (столбец product_name) без повторов */
SELECT DISTINCT(product_name)
FROM skill_sales;

/* 2. Запросите список всех категорий товаров (столбец product_category) и всех товаров по этим категориям (столбец
product_name) без повторов. */
SELECT DISTINCT(product_name), product_category
FROM skill_sales;

/* 3. Подсчитайте агрегатной функцией count с директивой distinct уникальное количество значений в колонке product_name */
SELECT COUNT(DISTINCT(product_name)) AS 'Количество уникальных product name'
FROM skill_sales;

/* Напишите SQL-запросы к таблице skill_sales, в которой содержатся накладные по продаже компьютерных комплектующих
и программного обеспечения:
1. Группировкой по колонке product_name подсчитайте количество накладных по каждому товару. */
SELECT product_name, COUNT(product_name) AS 'Количество накладных'
FROM skill_sales
GROUP BY product_name;

/* 2. По каждому товару посчитайте количество во всех накладных (столбец cnt) и среднюю цену (столбец price_usd). */
SELECT product_name, SUM(cnt) AS 'Количество всех накладных', ROUND(AVG(price_usd), 2) AS 'Средняя цена'
FROM skill_sales
GROUP BY product_name;

/* 3. По каждой группе товаров, которая состоит из категории (столбец product_category) и наименования товара (столбец 
product_name), посчитайте общую стоимость по формуле cnt* price_usd */
SELECT product_category, SUM(cnt*price_usd) AS 'Общая стоимость'
FROM skill_sales
GROUP BY product_category;

/* Напишите SQL-запросы к таблице skill_sales, в которой содержатся накладные по продаже компьютерных комплектующих
и программного обеспечения:
1. Выполните группировку по столбцам product_category и product_name с подсчетом количества накладных и расчетом суммы
всех товаров. Наложите условие на выборку так, чтобы в запросе учитывались только закрытые накладные
(document_type='closed’) */
SELECT product_category, product_name, sum(cnt*price_usd) AS 'Общая стоимость'
FROM skill_sales
WHERE document_type = 'closed'
GROUP BY product_category, product_name;

/* 2. Добавьте к запросу из пункта 1 дополнительное ограничение: сумма товара в каждой подгруппе должна быть больше 20 тысяч. */
SELECT product_category, product_name, sum(cnt*price_usd) AS 'Общая стоимость'
FROM skill_sales
WHERE document_type = 'closed'
GROUP BY product_category, product_name
HAVING SUM(cnt*price_usd) > 20000;

/* Напишите SQL-запросы к таблице skill_sales, в которой содержатся накладные по продаже компьютерных комплектующих
и программного обеспечения:
1. Подсчитайте количества накладных с группировкой по полю product_name. Результат отсортируйте в порядке убывания
количества накладных. */
SELECT product_name, COUNT(sale_dt) AS 'Количество накладных'
FROM skill_sales
GROUP BY product_name
ORDER BY COUNT(sale_dt) DESC;

/* 2. Переключите тестовую среду на БД MySQL 8.0 и напишите запрос, который подсчитывает количества накладных
с группировкой по столбцам: document_type, product_category, product_name. Отсортируйте результат по этим же
полям. В инструкциях ORDER BY и GROUP BY вместо названий полей используйте их порядковые номера */
SELECT document_type, product_category, product_name, COUNT(sale_dt) AS 'Количество накладных'
FROM skill_sales
GROUP BY document_type, product_category, product_name
ORDER BY document_type, product_category, product_name;