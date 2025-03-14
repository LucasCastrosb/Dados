SELECT * 
FROM sales.products
ORDER BY price DESC
67 99623-8641
LIMIT 999;

SELECT finish_checkout_date
FROM sales.funnel
order by state

SELECT *
FROM sales.funnel
ORDER BY Price DESC
LIMIT 10



SELECT  visit_id, paid_date aS "Data final de venda"
FROM sales.funnel
WHERE paid_date IS NOT NULL 
ORDER BY paid_date DESC
LIMIT 10


SELECT * 
FROM sales.customers
WHERE birth_date > '20000101'
ORDER BY score DESC
LIMIT 10;



SELECT email, birth_date, 
    DATE_PART('year', AGE(CURRENT_DATE, birth_date)) AS numero
FROM sales.customers
ORDER BY numero
LIMIT 10

SELECT first_name || ' ' || last_name 
FROm sales.customers


SELECT customer_id, first_name, professional_status AS "Cliente CLT"
FROM Sales.customers 
WHERE professional_status = 'clt'


SELECT * 
FROM sales.products
WHERE price NOT BETWEEN 100000 AND 200000
ORDER BY Price DESC
 
SELECT *
FROM sales.products
WHERE BRAND in ('HONDA', 'TOYOTA', 'RENAULT')

SELECT first_name
FROM sales.customers
WHERE first_name LIKE '%ANA'

SELECT distinct first_name
FROM sales.customers
WHERE first_name ILIKE 'ANA%'


SELECT distinct state, city 
FROM sales.customers
WHERE population IS NOT NULL


SELECT *, income/1200 AS "Salário Minimo", income/1200 > 5 AS "Acima de 4 Salários"
FROM sales.customers
WHERE income/1200 between 4 AND 5
AND state = 'MT'
LIMIT 999

SELECT city
FROM temp_tables.regions
WHERE city ILIKE 'Z%'
LIMIT 999


SELECT *
FROM sales.products
WHERE price = (select max(price) FROm sales.products)


SELECT state, count(*) AS "Contagem"
FROM sales.customers
GROUP BY state
ORDER BY state

SELECT state, professional_status, Count(*) As "Contagem"
FROM sales.customers
GROUP BY state, professional_status
ORDER BY STATE 

SELECT STATE, COUNT(*)
FROM sales.customers
GROUP BY STATE
HAVING COUNT(*) > 100           

SELECT COUNT(*)
FROM sales.customers
WHERE DATE_PART('year', AGE(CURRENT_DATE, birth_date)) < 30

select count(*)
from sales.customers
where ((current_date - birth_date) / 365 ) < 30



SELECT max(DATE_PART('year', AGE(CURRENT_DATE, birth_date))), min(DATE_PART('year', AGE(CURRENT_DATE, birth_date)))
FROM sales.customers

select *
from sales.customers
where income = (select max(income) from sales.customers)


SELECT Distinct brand, count(*)
FROM sales.products
GROUP BY brand
ORDER BY brand

SELECt DISTInct brand, model_year, count(*)
FROM sales.products
GROUP BY Brand, model_year
ORDER BY BRAND, model_year

SELECT DISTINCT brand, count(*)
FROM sales.products
GROUP BY brand
having count(*) > 10


SELECT temp_tables.tabela_1.CPF, temp_tables.tabela_1.name,  temp_tables.tabela_2.state
FROM temp_tables.tabela_1 
LEFT JOIN temp_tables.tabela_2 
ON temp_tables.tabela_1.cpf = temp_tables.tabela_2.cpf


SELECT temp_tables.tabela_1.CPF, temp_tables.tabela_1.name,  temp_tables.tabela_2.state
FROM temp_tables.tabela_1 
RIGHT JOIN temp_tables.tabela_2 
ON temp_tables.tabela_1.cpf = temp_tables.tabela_2.cpf



SELECT temp_tables.tabela_1.CPF, temp_tables.tabela_1.name,  temp_tables.tabela_2.state
FROM temp_tables.tabela_1 
INNER JOIN temp_tables.tabela_2 
ON temp_tables.tabela_1.cpf = temp_tables.tabela_2.cpf



SELECT temp_tables.tabela_1.CPF, temp_tables.tabela_1.name,  temp_tables.tabela_2.state
FROM temp_tables.tabela_1 
FULL JOIN temp_tables.tabela_2 
ON temp_tables.tabela_1.cpf = temp_tables.tabela_2.cpf



SELECT sales.customers.professional_status, COUNT(sales.funnel.paid_date)
FROM sales.funnel
LEFT JOIN sales.customers 
ON sales.funnel.customer_id = sales.customers.customer_id
GROUP BY sales.customers.professional_status
ORDER BY COUNT(sales.funnel.paid_date) desc


SELECT temp_tables.ibge_genders.gender, count(sales.funnel.paid_date)
FROM sales.funnel 
LEFT JOIN sales.customers
 ON sales.funnel.customer_id = sales.customers.customer_id
 LEFT JOIN temp_tables.ibge_genders
 ON lower(sales.customers.first_name) = temp_tables.ibge_genders.first_name
 GROUP by temp_tables.ibge_genders.gender
 
SELECT temp_tables.regions.region, COUNT(sales.funnel.visit_page_date)
FROM sales.funnel 
LEFT JOIN sales.customers
 ON sales.funnel.customer_id = sales.customers.customer_id
 LEFT JOIn temp_tables.regions
 ON lower(sales.customers.city) = lower(temp_tables.regions.city)
 AND lower(sales.customers.state) = lower(temp_tables.regions.state) 
 GROUP BY temp_tables.regions.region
 ORDER BY COUNT(sales.funnel.visit_page_date) DESC
 
 
 
 SELECT sales.products.brand, count(sales.funnel.visit_page_date)
 FROM sales.funnel
 LEFT JOin sales.products
 ON sales.funnel.product_id = sales.products.product_id
 GROUP BY sales.products.brand
 ORDER BY sales.products.brand 
 
 
 SELECT sales.stores.store_name, count(sales.funnel.visit_page_date)
 FROM sales.funnel
 LEFT JOIN sales.stores
 ON sales.funnel.store_id = sales.stores.store_id
 GROUP BY sales.stores.store_name
 ORDER BY  count(sales.funnel.visit_page_date) desc
 
 SELECT temp_tables.regions.size, COUNT(*)
 from sales.customers
 LEFT JOIN temp_tables.regions
 ON lower(sales.customers.city) = lower(temp_tables.regions.city) 
 and  lower(sales.customers.state) = lower(temp_tables.regions.state) 
 GROUP BY temp_tables.regions.size
 ORDER BY COUNT(sales.customers.customer_id) DESC
 
 SELECT * FROM sales.products
 UNION all
 SELECT * from temp_tables.products_2
 
 
 SELECT *
 FROM sales.products
 WHERE price = (
   select min(price) 
   FROM sales.products)
 
 
 
 WITH alguma_tabela AS (
   select professional_status, (current_date - birth_date)/365 AS idade
 from sales.customers)
 
 SELECT professional_status, avg(idade)
 FROM alguma_tabela
 GROUP by professional_status
 
 select professional_status, (current_date - birth_date)/365
 from sales.customers
 
 
 
 
  WITH alguma_tabela AS (
   select professional_status, (current_date - birth_date)/365 AS idade
 from sales.customers)
 
 SELECT professional_status, avg(idade)
 FROM (
 select professional_status, (current_date - birth_date)/365 AS idade
 from sales.customers
 ) AS alguma_tabela
 GROUP by professional_status
 
 select professional_status, (current_date - birth_date)/365
 from sales.customers
 
 
 
 SELECT
     sales.funnel.visit_id,
     sales.funnel.visit_page_date,
     sales.stores.store_name,
     ( select count(*)
       FROM sales.funnel  AS fun2
      where fun2.visit_page_date <= sales.funnel.visit_page_date
      AND fun2.store_id = sales.funnel.store_id
       ) AS visitas_acumuladas
 from sales.funnel
 left join sales.stores
 ON sales.funnel.store_id = sales.stores.store_id
 ORDER BY sales.stores.store_name
 
 
 
 WITH primeira_visita as (
   select customer_id, min(visit_page_date) as visita_1
   FROM sales.funnel
   group BY customer_id
   )


 select 
   	fun.visit_page_date,
    (fun.visit_page_date <> primeira_visita.visita_1) AS lead_recorrente,
    count(*)
    from sales.funnel AS fun
    left join primeira_visita
    ON fun.customer_id = primeira_visita.customer_id
    Group by fun.visit_page_date, lead_recorrente
    order by fun.visit_page_date DESc
    
    
    
    
    
    
 WIth preco_medio as (
   select brand, avg(price) as preco_medio_da_marca
   from sales.products
   Group by brand
   )
   
   SELECT
   fun.visit_id,
   fun.visit_page_date,
   pro.brand,
   (pro.price * (1+fun.discount)) as preco_final,
   preco_medio.preco_medio_da_marca,
   ((pro.price * (1+fun.discount)) - preco_medio.preco_medio_da_marca) as preco_vs_media
   FROm sales.funnel as fun
   left join sales.products as pro
   on fun.product_id = pro.product_id
   left join preco_medio
   on pro.brand = preco_medio.brand
 limit 10
 
 
 select discount
 from sales.funnel
 
 
 
 
 WITH total_visitas AS (
   select customer_id, count(*) as numero_visita
   from sales.funnel
 group by sales.funnel.customer_id)
   
   SELECT sales.customers.*, total_visitas.numero_visita
   FROM sales.customers
   left join total_visitas
   ON sales.customers.customer_id = total_visitas.customer_id
   order by total_visitas DESC
 LIMIT 10
 
 
 select '2021-10-01'::date - '2021-02-01'::date
 
 select nome_coluna::date
 FROM nome_tabela
 
 
select CAST('2021-10-01' as date) - CAST('2021-02-01' as date)


WITH faixa_de_renda AS (
  SELECT income, 
  case 
  	when income < 5000 then '0 - 5000'
  	when income >= 5000 and income < 10000 then '5000 - 10000'
	when income >= 10000 and income < 15000 then '10000 - 15000'
    else '15000+'
    END AS faixa_renda
  FROM sales.customers
  )
  
  SELECT faixa_renda, count(*)
  FROM faixa_de_renda
  GROUP by faixa_renda
  
  
  SELECT *,
   CASE 
   	WHEN population is not null then population
    ELSE (select avg(population) from temp_tables.regions)
    END AS populacao_ajustada
  FRom temp_tables.regions
  WHERE population is null 
  
  
 
  SELECT *,
  	coalesce(population, (select avg(population) 
    from temp_tables.regions))  as populacao_ajustada
  FRom temp_tables.regions
  WHERE population is null 
  
  
  
  SELECT upper('SÃO paulo') = 'SÃO PAULO'
  
  
  SELECT CURRENT_DATE + 10
  SELECT CURRENT_DATE + interval '10 years'
  
  
  SELECT 
    date_trunc('month', visit_page_date)::date AS visit_page_month,
    count(*)
 FROM sales.funnel
 GROUP BY visit_page_month
 ORDER BY visit_page_month desc
  
  
  Select
 '2022-01-30'::date,
 EXTRACT('DOW' FROM  '2022-01-30'::date)


  SELECT
    EXTRACT('dow' from visit_page_date) AS dia_da_semana,
  	count(*)
  from sales.funnel
  GROUP by dia_da_semana
  ORDER BY dia_da_semana
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
