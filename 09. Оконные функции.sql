Link: https://dbfiddle.uk/?rdbms=postgres_12&fiddle=3e7dc619ab7a17c262b3e0032cd41b51&hide=1

/* Напишите SQL-запрос, возвращающий все строки и все колонки таблицы 
с продажами skill_sales
К набору колонок добавьте две вычисляемые колонки: */
SELECT *, 
row_number() OVER (ORDER BY sale_dt DESC) N_by_dt,
row_number() OVER (ORDER BY cnt DESC) N_by_cnt
FROM skill_sales;

/* Напишите SQL-запрос, возвращающий все строки и все колонки таблицы 
с продажами skill_sales
К набору колонок добавьте две вычисляемые колонки */
SELECT *,
COUNT(cnt) OVER (PARTITION BY product_category ORDER BY sale_dt) N_by_category,
COUNT(cnt) OVER (PARTITION BY product_category, product_name ORDER BY sale_dt) N_by_product
FROM skill_sales;

/* count(result) - порядковый номер результата, sum_result - сумма cnt нарастающим итогом в зависимости
от порядка count */
SELECT manager, cnt,
count(cnt) over (PARTITION BY MANAGER ORDER BY order_date, order_time) count_result,
sum(cnt) over (PARTITION BY MANAGER ORDER BY order_date, order_time) sum_result
FROM skill_orders
ORDER BY manager, order_date, order_time;

/* Напишите SQL-запрос, возвращающий все строки и все колонки таблицы с продажами 
skill_sales
К набору колонок добавьте вычисляемую колонку total_by_document_type, которая 
должна содержать общую сумму продаж (cnt*price_usd) по всем сделкам с текущим 
типом документа (тип определяется по колонке document_type */

SELECT *,
SUM(cnt*price_usd) OVER (PARTITION BY document_type) total_dy_document_type
FROM skill_sales

SELECT cnt,
row_number() over (order by cnt) cnt_row_number /* порядковый номер строки, не зависит от значений колонки cnt */,
rank() over (order by cnt) cnt_rank /* для одинаковых значений одинаковые ранги, новое значение - новый порядковый номер
(то есть идут не по порядку)*/,
dense_rank() over (order by cnt) cnt_dense_rank /* то же самое, что rank, но номера идут по порядку */
from skill_orders
order by cnt;

SELECT manager, cnt,
ntile(3) over (order by cnt) ntile_3 /* равномерное распределение по 3 группам */,
ntile(10) over (order by cnt) ntile_10 /* равномерное распределение по 10 группам */
from skill_orders order by cnt;

/* сортировка по группам в зависимости от имени менеджера */
SELECT manager, cnt,
ntile(3) over (order by manager) ntile_3 /*равномерное распределение по 3 группам */,
ntile(10) over (order by manager) ntile_10 /* равномерное распределение по 10 группам */
from skill_orders order by cnt;

/* Напишите SQL-запрос, возвращающий все строки и все колонки таблицы с продажами 
skill_sales
К набору колонок добавьте две вычисляемые колонки: 
total_rank: Колонка должна содержать ранги, без пропусков. 
Первый ранг должен быть у продажи на самую большую 
сумму и далее по уменьшению суммы сделки
document_type_rank: Колонка должна содержать ранги, без пропусков. Ранги 
присваиваются для каждой группы продаж по типу 
документа отдельно. Первый ранг должен быть у сделки 
на самую большую сумму в группе и далее 
по уменьшению суммы сделки
*/
SELECT *,
rank() over (order by cnt*price_usd DESC) total_rank,
rank() over (partition by document_type order by cnt*price_usd DESC) document_type_rank 
FROM skill_sales;

/* Напишите SQL-запрос, возвращающий все строки и все колонки таблицы с продажами 
skill_sales
К набору колонок добавьте две вычисляемые колонки: 
Название колонки Содержимое
total Сумма продажи товара текущей строки
total_prev Сумма продажи товара из предыдущей строки
total_next Сумма продажи товара из cледующей строки
first_total Сумма продажи по первой строке в рамках наименования товара
last_total Сумма продажи по последней строке в рамках наименования товара
*/

SELECT *, (cnt * price_usd) AS total,
LAG (cnt * price_usd) OVER (PARTITION BY product_name) total_prev,
LEAD (cnt * price_usd) OVER (PARTITION BY product_name) total_next,
FIRST_VALUE (cnt*price_usd) OVER (PARTITION BY product_name) first_total,
LAST_VALUE (cnt*price_usd) OVER (PARTITION BY product_name) last_total
FROM skill_sales;

