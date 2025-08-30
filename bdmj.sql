-----cuantas categorias tengo en la bd?

select count(1) from categories;
select count (1) from employees;
select count (1) from products; 
select * from products limit 10;
select product_name from products;
------- que categoria tiene el tofu?
select p.product_name, c.category_name
from products p
inner join categories c on p.category_id = c.category_id 
where UPPER (p.product_name) = 'TOFU'
select min(unit_price) as valor_minimo, max(unit_price) as valor_maximo, avg (unit_price) 
valor_promedio,round(avg(unit_price):: numeric,4) valor_promedio_round 
from products;
-----cuales son los productos que la empresa tiene en bodega con las siguientes cantidades: 120, 22, 24,35,42,9

SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock IN (120, 22, 24, 35, 42, 9);
----cuantos prductos tengo en bodega
SELECT SUM(units_in_stock) AS total_en_bodega
FROM products;
----cuales productos inician con la letra s
SELECT product_name, units_in_stock
FROM products
WHERE product_name LIKE 'S%';

SELECT COUNT(*) AS productos_terminan_en_s
FROM products
WHERE product_name LIKE '%n';

SELECT product_name, units_in_stock
FROM products
WHERE product_name LIKE '%cho%';

----cuales son los codigos de las ordenes (order_id) y el valor del flete(freight) que fueron registradas por el 
-------cliente(custmer_id) VICTE entre el 1 de enero de 1996 y el 31 de diciembre de 1997
SELECT order_id, freight
FROM orders
WHERE customer_id = 'VICTE'
  AND order_date BETWEEN '1996-01-01' AND '1997-12-31';


  -------- cuales son los productos que tienen un costo unitario entre 20 y 40 dolares 

 SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price BETWEEN 20 AND 40;

------cuales son los productos de categoria seafood 
SELECT p.product_id, p.product_name, p.unit_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE c.category_name = 'seafood'; 

-------- cuales son los codigos de las ordenes y la fecha de la orden que realizo la empleada Nancy Davolio entre los años 2006 y 2007
SELECT o.order_id, o.order_date, e.last_name || ' ' || e.first_name AS nombre
FROM employees e
INNER JOIN orders o ON o.employee_id = e.employee_id
WHERE e.last_name = 'Davolio'
  AND o.order_date BETWEEN '1996-02-01' AND '1996-09-30';

SELECT c.company_name, o.order_date 
FROM customers AS c 
LEFT JOIN orders AS o ON c.customer_id = o.customer_id 

SELECT e.first_name, e.last_name, o.order_id 
FROM employees AS e 
RIGHT JOIN orders AS o ON e.employee_id = o.employee_id;


  ------cuales son los codigos de las ordenes  y las fechas con las que se ha comprado tofu
SELECT o.order_id, o.order_date, p.product_name
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = 'Tofu';

-- Seleccionar por categoría usando el GROUP BY
SELECT 
    category_name, 
    COUNT(*) AS total_productos
FROM 
    products p 
INNER JOIN 
    categories c ON c.category_id = p.category_id
GROUP BY 
    category_name
HAVING 
    COUNT(*) > 9
ORDER BY 
    total_productos ASC;

-- Categorías con al menos 5 productos cuyo precio es mayor a 10
SELECT 
    category_id, 
    COUNT(*) AS products_caros_contados
FROM 
    products
WHERE 
    unit_price > 10
GROUP BY 
    category_id
HAVING 
    COUNT(*) >= 5;

-- Total de empleados por cargo
SELECT 
    title AS cargo, 
    COUNT(employee_id) AS "total empleados"
FROM 
    employees
GROUP BY 
    title;

-- Total de empleados por cargo, solo en Seattle
SELECT 
    title AS cargo, 
    COUNT(employee_id) AS "total empleados"
FROM 
    employees
WHERE 
    city = 'Seattle'
GROUP BY 
    title;

-- Promedio y suma de precios unitarios por categoría
SELECT 
    category_id, 
    ROUND(AVG(unit_price)::NUMERIC, 2) AS avg_unit_price,
    ROUND(SUM(unit_price)) AS sum_unit_price
FROM 
    products 
GROUP BY 
    category_id;

-- Proveedores que suministran más de 3 productos
SELECT 
    s.company_name,
    COUNT(p.product_id) AS num_products_supplied
FROM 
    products AS p
INNER JOIN 
    suppliers AS s ON p.supplier_id = s.supplier_id
GROUP BY 
    s.company_name
HAVING 
    COUNT(p.product_id) > 3
ORDER BY 
    num_products_supplied DESC;

-- Empleados (no viven en Seattle) que han realizado más de 100 órdenes
SELECT 
    e.employee_id || ' - ' || e.first_name || ' ' || e.last_name AS empleado,
    COUNT(o.order_id) AS total_ordenes
FROM 
    employees e
INNER JOIN 
    orders o ON e.employee_id = o.employee_id
WHERE 
    e.city <> 'Seattle'
GROUP BY 
    e.employee_id, e.first_name, e.last_name
HAVING 
    COUNT(o.order_id) > 100
ORDER BY 
    total_ordenes DESC;











-------taller 1, pregunta 1. 

SELECT COUNT(1) FROM products;

-------- pregunta 2. 

SELECT MAX(unit_price) AS precio_maximo FROM products;

------- pregunta 3. 

SELECT MIN(unit_price) AS precio_minimo FROM products;


----- pregunta 4. 

SELECT ROUND(AVG(unit_price)::numeric, 2) AS precio_promedio FROM products;

------ pregunta 5. 

SELECT UPPER(first_name) AS nombre, UPPER(last_name) AS apellido FROM employees;

------ pregunta 6. 

SELECT LOWER(company_name) AS nombre_compania FROM customers;

------- pregunta 7.

SELECT product_name FROM products WHERE product_name ILIKE '%cheese%';

------- pregunta 8. 

SELECT first_name, last_name, country FROM employees
WHERE country IN ('USA', 'UK', 'France');


------- pregunta 9. 

SELECT product_name, unit_price FROM products
WHERE unit_price BETWEEN 10 AND 50;


------- pregunta 10. 

SELECT SUM(quantity) AS total_cantidades FROM order_details;


------ pregunta 11. 

SELECT REPLACE(company_name, 'Ltd', 'Limited') AS nombre_modificado
FROM customers;


----- pregunta 12. 

SELECT last_name, POSITION('a' IN last_name) AS posicion_a FROM employees;


----- pregunta 13. 

SELECT SUBSTRING(company_name FROM 1 FOR 3) AS primeros_3 FROM customers;


---- pregunta 14. 

SELECT product_name, CEIL(unit_price) AS precio_techo FROM products;


---- pregunta 15. 

SELECT product_name, FLOOR(unit_price) AS precio_piso FROM products;


---- pregunta 16. 

SELECT COUNT(*) AS empleados_con_a
FROM employees
WHERE first_name LIKE 'A%';


---- pregunta 17. 

SELECT product_name, ROUND(unit_price::numeric, 1) AS precio_redondeado
FROM products
WHERE unit_price > 20;


---- pregunta 18 

SELECT UPPER(company_name) AS nombre_mayuscula
FROM customers
WHERE company_name ILIKE '%restaurant%' OR company_name ILIKE '%café%';


---- pregunta 19 

SELECT ROUND(AVG(freight)::numeric, 2) AS promedio_flete
FROM orders
WHERE freight BETWEEN 1 AND 100;

---- pregunta 20 

SELECT LOWER(first_name || ' ' || last_name) AS nombre_completo
FROM employees;



  