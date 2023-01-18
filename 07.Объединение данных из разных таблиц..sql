Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=2b92133d56439e23e958792681441b1a&hide=1

/* Напишите SQL-запросы, получающие следующие данные:
1. Все строки из таблиц city_customers и city_suppliers */
SELECT *
FROM city_customers;

SELECT *
FROM city_suppliers;

/* 2. Объединённое без повторов множество строк таблиц city_customers и city_suppliers */
SELECT * FROM city_customers
UNION 
SELECT * FROM city_suppliers;

/* 3. Объединённое c повторами множество строк таблиц city_customers и city_suppliers */
SELECT * FROM city_customers
UNION ALL
SELECT * FROM city_suppliers;

/* Напишите SQL-запросы, получающие следующие данные:
1. Все строки, которые присутствуют и в таблице city_customers, и в таблице city_suppliers */
SELECT * FROM city_customers
INTERSECT
SELECT * FROM city_suppliers;

/* 2. Все строки, которые присутствуют в таблице city_customers и отсутствуют в таблице city_suppliers */
SELECT * FROM city_customers
EXCEPT
SELECT * FROM city_suppliers;

/* 3. Все строки, которые присутствуют в таблице city_ suppliers и отсутствуют в таблице city_customers */
SELECT * FROM city_suppliers
EXCEPT
SELECT * FROM city_customers;

Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=01524317c08e7ca77f881daf6f194828&hide=1

/* suits - масть, cards - номинал карты. Вывести все 36 карт через CROSS JOIN */
SELECT * FROM suits
CROSS JOIN cards;

/* В базе есть таблицы:
• sizes — содержит варианты размеров
• colors — содержит варианты цветов
Выведите результирующую таблицу из двух колонок. В первой содержится размер из таблицы sizes,
а во второй — цвет из таблицы colors. Результат должен содержать все возможные
комбинации пар размер — цвет (48 строк) */
SELECT * FROM sizes
CROSS JOIN colors;

/* Выполните запрос, соединяющий все строки таблицы sizes со всеми строками таблицы colors. Из результатов исключите размер ‘XXL’ и цвет ‘red’. */
SELECT * FROM sizes
CROSS JOIN colors
WHERE size != 'XXL' and color != 'red';

/* Выполните запрос, соединяющий все строки таблицы sizes со всеми строками таблицы colors без использования оператора CROSS JOIN. Из результатов исключите размер ‘XXL’ и цвет ‘red’. */
SELECT * FROM sizes, colors
WHERE size != 'XXL' and color != 'red';

Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=7da2ac78293df95fe63d2efc1a32535e&hide=1

/* Таблица city_customers_suppliers — справочник городов для таблицы skill_customers_suppliers. 
Связь данных осуществляется через общее поле city_id
1. Напишите SQL-запрос с INNER JOIN, объединяющий обе таблицы */
SELECT * 
FROM city_customers_suppliers tbl_1
INNER JOIN skill_customers_suppliers tbl_2
    ON tbl_1.city_id = tbl_2.city_id;

/* 2. Добавьте к запросу ещё одну таблицу-справочник — gender, свяжите таблицы
city_customers_suppliers и gender по полю gender_id, которое присутствует в обеих
таблицах */
SELECT * 
FROM city_customers_suppliers tbl_1
INNER JOIN skill_customers_suppliers tbl_2
    ON tbl_1.city_id = tbl_2.city_id
INNER JOIN gender tbl_3
    ON tbl_2.gender_id = tbl_3.gender_id;

/* 3. Модернизируйте запрос, связывающий три таблицы, так, чтобы в результирующей выборке
остались только поля name, city и gende */
SELECT name, city, gender 
FROM city_customers_suppliers tbl_1
INNER JOIN skill_customers_suppliers tbl_2
    ON tbl_1.city_id = tbl_2.city_id
INNER JOIN gender tbl_3
    ON tbl_2.gender_id = tbl_3.gender_id;

/* Таблица city_customers_suppliers — справочник городов для таблицы skill_customers_suppliers. 
Связь данных осуществляется через общее поле city_id
1. Напишите SQL-запрос с INNER JOIN, объединяющий обе таблицы. Наложите условие на выборку: 
названия городов начинаются с ’K’ */
SELECT *
FROM city_customers_suppliers tbl_1
JOIN skill_customers_suppliers tbl_2
    ON tbl_1.city_id = tbl_2.city_id
WHERE city LIKE 'K%'

/* 2. Добавьте к запросу ещё одну таблицу-справочник — gender, свяжите таблицы city_customers_suppliers
и gender по полю gender_id, которое присутствует в обеих таблицах. В результирующую выборку должны
попасть только женщины */
SELECT *
FROM city_customers_suppliers tbl_1
JOIN skill_customers_suppliers tbl_2
    ON tbl_1.city_id = tbl_2.city_id
JOIN gender tbl_3
    ON tbl_2.gender_id = tbl_3.gender_id
WHERE city LIKE 'K%' and gender = 'F';

/* 3. Модернизируйте запрос, связывающий три таблицы, так, чтобы в результирующей выборке остались только
поля name, city и gender. В результирующую выборку должны попасть только мужчины из городов, названия
которых начинаются с ’K */
SELECT name, city, gender
FROM city_customers_suppliers tbl_1
JOIN skill_customers_suppliers tbl_2
    ON tbl_1.city_id = tbl_2.city_id
JOIN gender tbl_3
    ON tbl_2.gender_id = tbl_3.gender_id
WHERE city LIKE 'K%' and gender = 'F';

/* 1. Напишите SQL-запрос к таблице city_customers_suppliers. С помощью INNER JOIN присоедините две таблицы
справочника: gender по полю gender_id и age_range по полю age_range_id
2. Измените запрос, оставив в результирующей выборке только поля name, gender и age_range
3. Модернизируйте запрос, посчитав количество людей в каждой поло-возрастной группе: */
SELECT gender, age_range, COUNT(gender) AS Cnt
FROM skill_customers_suppliers c
INNER JOIN gender g
    ON c.gender_id = g.gender_id 
INNER JOIN age_range a
    ON c.age_range_id = a.age_range_id
GROUP BY gender, age_range;

Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=fc55d5f432638a65d5e6157598902aaf&hide=1

/* В таблице со сделками skill_deals есть идентификаторы:
• customer_id — идентификатор покупателя
• supplier_id — идентификатор продавца
Свяжите с помощью INNER JOIN оба идентификатора с таблицей-справочником skill_customers_suppliers, которая
является справочником продавцов и покупателей одновременно (поле-идентификатор customers_suppliers_id */
SELECT dt, t2.name AS 'customer_name', t3.name AS 'supplier_name'
FROM skill_deals t1
INNER JOIN skill_customers_suppliers t2
    ON t1.customer_id = t2.customers_suppliers_id
INNER JOIN skill_customers_suppliers t3
    ON t1.supplier_id = t3.customers_suppliers_id

/* таблице со сделками skill_deals есть идентификаторы:
• customer_id — идентификатор покупателя
• supplier_id — идентификатор продавца
Свяжите с помощью INNER JOIN оба идентификатора с таблицей-справочником skill_customers_suppliers, которая
является справочником продавцов и покупателей одновременно (поле-идентификатор customers_suppliers_id)
При оформлении условия соединения с таблицей покупателей исключите покупателей женского пола, а в условии
соединения справочника продавцов исключите продавцов мужского пола */
SELECT dt, t1.name AS 'Customer_name', t2.name AS 'Supplier_name'
FROM skill_deals t0
INNER JOIN skill_customers_suppliers t1
ON t0.customer_id = t1.customers_suppliers_id
INNER JOIN skill_customers_suppliers t2
ON t0.supplier_id = t2.customers_suppliers_id;

LINK: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=940c348fd05904297a82ce8c7bef934b&hide=1

/* 1.	С помощью INNER JOIN присоедините к таблице с сотрудниками employee справочник возрастных диапазонов age_range. 
Поля-идентификаторы для условия соединения в обеих таблицах называются age_range_id.  */
SELECT *
FROM employee e
INNER JOIN age_range a
    ON e.age_range_id = a.age_range_id

/* 2.	С помощью INNER JOIN присоедините к таблице с сотрудниками employee справочник полов gender. 
Поля-идентификаторы для условия соединения в обеих таблицах называются gender_id. */
SELECT name, gender
FROM employee e
INNER JOIN gender g
    ON e.gender_id = g.gender_id 

/* 3.	С помощью INNER JOIN присоедините к таблице с сотрудниками employee справочник департаментов department. 
Поля-идентификаторы для условия соединения в обеих таблицах называются department_id. */
SELECT e.name, d.name AS 'department'
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.department_id

/* 4.	В справочнике департаментов department присутствуют не все значения идентификаторов department_id, которые используются в таблице с сотрудниками employee, 
поэтому для исключения потери строк при присоединении таблиц employee и department используйте LEFT JOIN. */
SELECT e.name, d.name AS 'department'
FROM employee e
RIGHT JOIN department d
    ON e.department_id = d.department_id

/* 1.	С помощью INNER JOIN присоедините к таблице с сотрудниками employeeследующие справочники:
o	справочник возрастных диапазонов age_range;
o	справочник полов gender;
o	справочник департаментов department.
В результирующую выборку должны попасть следующие колонки: 
•	имя сотрудника;
•	возраст;
•	название возрастного диапазона;
•	наименование департамента (используйте название для вывода — department).
*/
SELECT e.name, a.age_range, g.gender, d.name AS 'Department' 
FROM employee e
INNER JOIN age_range a
    ON e.age_range_id = a.age_range_id
INNER JOIN gender g
    ON e.gender_id = g.gender_id
INNER JOIN department d
    ON d.department_id = e.department_id

/* 2.	В справочнике департаментов department присутствуют не все значения идентификаторов department_id, которые используются в таблице с сотрудниками employee. Доработайте запрос из предыдущего 
пункта задания так, чтобы в результирующую выборку попали все строки из таблицы с сотрудниками employee, независимо от значения поля department_id. */
SELECT e.name, a.age_range, g.gender, d.name AS 'Department' 
FROM employee e
INNER JOIN age_range a
    ON e.age_range_id = a.age_range_id
INNER JOIN gender g
    ON e.gender_id = g.gender_id
LEFT JOIN department d
    ON d.department_id = e.department_id

/* 3.	Доработайте запрос из предыдущего пункта так, чтобы в результирующую выборку попадали строки, 
в которых длина имени и фамилии сотрудника (поля name) строго больше 10 символов. */
SELECT e.name, a.age_range, g.gender, d.name AS 'Department' 
FROM employee e
INNER JOIN age_range a
    ON e.age_range_id = a.age_range_id
INNER JOIN gender g
    ON e.gender_id = g.gender_id
LEFT JOIN department d
    ON d.department_id = e.department_id
WHERE LEN(TRIM(e.name)) > 10;

/* 4.	Доработайте запрос из пункта 2 так, чтобы в результирующую выборку попадали сотрудники, 
которые работают либо в департаменте Marketing, либо в департаменте IT, а также возраст которых равен или больше 25. */
SELECT e.name, a.age_range, g.gender, d.name AS 'Department' 
FROM employee e
INNER JOIN age_range a
    ON e.age_range_id = a.age_range_id
INNER JOIN gender g
    ON e.gender_id = g.gender_id
LEFT JOIN department d
    ON d.department_id = e.department_id
WHERE d.name IN ('IT', 'Marketing') AND e.age >= 25;

/* Задание 4
В пункте 4 задания 2 выполняется присоединение справочника департаментов к таблице сотрудников. При этом используются псевдонимы таблиц e — employee и d — department. 
В результирующую выборку выводятся следующие колонки: имя сотрудника, возраст и наименование департамента. Для последней колонки используйте название для вывода — department.
*/

SELECT e.name, d_t.name
FROM employee e
LEFT JOIN department_test d_t
    ON e.department_id = d_t.department_id
WHERE d_t.department_id NOT IN (4, 5, 6)

/* 1. К таблице со списком сотрудников employee (псевдоним e) присоедините справочник возрастных категорий age_range_band (псевдоним r1).
Для условия соединения используйте правило: возраст age таблицы employee должен быть строго больше значения from_value таблицы age_range_band и одновременно меньше или равен значению to_value.
В результирующую выборку должны попасть следующие поля: имя сотрудника, возраст и название временного диапазона с именем столбца true_range.
*/
SELECT name, age, age_range
FROM employee e
INNER JOIN age_range_band r1
    ON e.age_range_id = r1.age_range_id
WHERE e.age > r1.from_value and e.age <= r1.to_value;

/* 2. К запросу из предыдущего пункта присоедините ещё одну таблицу — справочник возрастных категорий age_range (псевдоним r2) со следующим условием присоединения: равенство идентификаторов age_range_id обеих таблиц.
К колонкам результата добавьте ещё одно поле с именем возрастного диапазона из таблицы age_range, назовите колонку id_range.
*/
SELECT name, age, r1.age_range_id, r2.age_range_id
FROM employee e
INNER JOIN age_range_band r1
    ON e.age_range_id = r1.age_range_id
INNER JOIN age_range r2
    ON e.age_range_id = r2.age_range_id
WHERE e.age > r1.from_value and e.age <= r1.to_value;

Link: https://dbfiddle.uk/?rdbms=sqlserver_2017&fiddle=94f55c9997aa7ebb6b55580766035189&hide=1

/* 1.	К таблице-справочнику менеджеров skill_managers присоедините таблицу с данными skill_sales_september. 
Для присоединения используйте колонки-идентификаторы manager_id. */
SELECT *
FROM skill_managers t1
RIGHT JOIN skill_sales_september t2
    ON t1.manager_id = t2.manager_id

/* 2.	К таблице-справочнику товаров skill_product присоедините таблицу с данными 
skill_sales_september. Для присоединения используйте колонки-идентификаторы product_id. */
SELECT *
FROM skill_product t3
RIGHT JOIN skill_sales_september t4
    ON t3.product_id = t4.product_id

/* Соединение таблицы с данными продаж за апрель skill_sales_april 
с таблицей-справочником менеджеров skill_managers. Для присоединения используйте колонки-идентификаторы manager_id. */
SELECT *
FROM skill_sales_april t5
FULL JOIN skill_managers t6
    ON t5.manager_id = t6.manager_id;

/* Соединение таблицы с данными продаж за сентябрь 
skill_sales_september с таблицами-справочниками skill_managers и skill_product.*/
SELECT *
FROM skill_sales_september t7
FULL JOIN skill_managers t8
    ON t7.manager_id = t8.manager_id
FULL JOIN skill_product t9
    ON t7.product_id = t9.product_id;

/* •	С помощью FULL JOIN соедините таблицы skill_sales_september и skill_product. 
•	После WHERE укажите условия на колонку skill_product.product_id, исключающие значения NULL.
*/
SELECT *
FROM skill_sales_september ss
FULL JOIN skill_product sp
    ON ss.product_id = sp.product_id
WHERE sp.product_id IS NOT NULL;

/* К таблице с данными skill_sales_september с помощью LEFT JOIN 
присоедините справочники skill_product и skill_managers_dup */
SELECT *
FROM skill_sales_september s_s_s
LEFT JOIN skill_product s_p
    ON s_s_s.product_id = s_p.product_id
LEFT JOIN skill_managers_dup s_m_d
    ON s_s_s.manager_id = s_m_d.manager_id

/* 2. Добавьте к предыдущему запросу условие, которое исключает из результата
дублирующие данные — строки с manager_id, равным 11, 12, 13 или 14 */
SELECT *
FROM skill_sales_september s_s_s
LEFT JOIN skill_product s_p
    ON s_s_s.product_id = s_p.product_id
LEFT JOIN skill_managers_dup s_m_d
    ON s_s_s.manager_id = s_m_d.manager_id
WHERE s_m_d.manager_id NOT IN (11, 12, 13, 14)

/* В базе данных есть два справочника сотрудников:
skill_managers — содержит эталонные данные
skill_managers_dup — содержит лишние строки
Практика к уроку
1. Напишите SQL запрос, объединяющий оба справочника с помощью FULL JOIN */
SELECT *
FROM skill_managers t1
FULL JOIN skill_managers_dup t2
    ON t1.manager_id = t2.manager_id

/* 2. Добавьте условие, которое оставляет в результатах запроса только лишние
строки — строки из таблицы skill_managers_dup, которые отсутствуют
в эталонных данных — skill_managers
*/
SELECT *
FROM skill_managers t1
FULL JOIN skill_managers_dup t2
    ON t1.manager_id = t2.manager_id
WHERE t1.manager_id IS NULL;