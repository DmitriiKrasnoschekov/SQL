Link: https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=35a840a4219939050a800dfa6204cefa&hide=1

/* Выбираем все данные в таблице */
SELECT *
FROM skill_continents;

/* Ограничиваем число строк (выбираем первые n строк) */
SELECT TOP 3 *
FROM skill_continents;

/* Ограничиваем число строк (выбираем последние n строк) */
SELECT *
FROM 
(
    SELECT TOP 3 *
    FROM 
    skill_continents
    ORDER BY 
    continent_id DESC
    ) SQ
ORDER BY
    continent_id ASC;

/* Ограничение числа строк в процентах (первые 50% строк) */
SELECT TOP 30 PERCENT *
FROM skill_continents;

/* Ограничение числа строк в процентах (последние n% строк) */
SELECT *
FROM
(
    SELECT TOP 30 PERCENT *
    FROM skill_continents
    ORDER BY continent_id DESC) SQ
ORDER BY
    continent_id ASC;

