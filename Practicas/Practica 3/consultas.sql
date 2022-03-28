--Consulta 1 
--Mostrar el cliente que mas a comprado. Se debe de mostrar el id del cliente,
--nombre, apellido, país y monto total.
select c.Nombre, c.Apellido , sum(o.cantidad*p.precio) as monto_total from Orden o 
inner join Producto p on p.id_producto = o.id_producto
inner join Cliente c on c.id_cliente = o.id_cliente
group by c.Nombre,c.Apellido
order by monto_total desc
OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY;

--Consulta 2
--Mostrar el producto mas y menos comprado. Se debe mostrar el id del
--producto, nombre del producto, categoría, cantidad de unidades y monto
--vendido
 
with vendidos as (
	select o.id_producto,p.Nombre,c.nombre as categoria, 
	sum(o.cantidad) as cantidad_unidades,
	sum(o.cantidad* p.Precio) as monto_vendido
	from Orden o 
	inner join Producto p on p.id_producto = o.id_producto
	inner join Categoria c on c.id_categoria = p.id_Categoria
	group by o.id_producto,p.Nombre,c.nombre
), top_vendido as (
	select TOP 1 * from vendidos
	order by cantidad_unidades desc
), min_vendido as (
	select TOP 1 * from vendidos
	order by cantidad_unidades asc
)
select * from top_vendido 
union 
select * from min_vendido

--Consulta 3 
--Mostrar a la persona que mas ha vendido. Se debe mostrar el id del
--vendedor, nombre del vendedor, monto total vendido.

select TOP 1 o.id_vendor,v.nombre, sum(o.cantidad*p.Precio) as monto_total from Orden o 
inner join Vendedor v on v.id_vendedor = o.id_vendor
inner join Producto p on p.id_producto = o.id_producto
group by o.id_vendor, v.nombre
order by monto_total desc

--Consulta 4 
--Mostrar el país que mas y menos ha vendido. Debe mostrar el nombre del
--país y el monto. (Una sola consulta)

with vendedor_pais as (
	select o.id_vendor,p.nombre, sum(o.cantidad*prod.Precio) as monto from Orden o 
	inner join Vendedor v on v.id_vendedor = o.id_vendor
	inner join Pais p on p.id_pais = v.id_pais
	inner join Producto prod on prod.id_producto = o.id_producto
	group by o.id_vendor, p.nombre
), ventas_pais as (
	select nombre, sum(monto) as monto_total from vendedor_pais
	group by nombre
)
SELECT * FROM ventas_pais where monto_total = (select max(monto_total) from ventas_pais)
UNION 
SELECT * FROM ventas_pais where monto_total = (select min(monto_total) from ventas_pais)

--Consulta 5 
--Top 5 de países que mas han comprado en orden ascendente. Se le solicita
--mostrar el id del país, nombre y monto total
with cliente_pais as (
	select c.id_cliente,p.nombre, sum(o.cantidad*prod.Precio) as monto from Orden o 
	inner join Cliente c on c.id_cliente= o.id_cliente
	inner join Pais p on p.id_pais = c.id_pais
	inner join Producto prod on prod.id_producto = o.id_producto
	group by c.id_cliente, p.nombre
), ventas_pais as (
	select nombre, sum(monto) as monto_total from cliente_pais
	group by nombre
), top_5 as (
	SELECT TOP 5 * from ventas_pais order by monto_total DESC
)
select * from top_5 order by monto_total ASC


--Consulta 6
--Mostrar la categoría que mas y menos se ha comprado. Debe de mostrar el
--nombre de la categoría y el monto. (Una sola consulta).
with cliente_categoria as (
	select c.id_cliente,cat.nombre, o.cantidad from Orden o 
	inner join Cliente c on c.id_cliente= o.id_cliente
	inner join Producto prod on prod.id_producto = o.id_producto
	inner join Categoria cat on cat.id_categoria = prod.id_Categoria
), ventas_cat as (
	select nombre, sum(cantidad) as cantidad_total from cliente_categoria
	group by nombre
)
SELECT * FROM ventas_cat where cantidad_total = (select max(cantidad_total) from ventas_cat)
UNION 
SELECT * FROM ventas_cat where cantidad_total = (select min(cantidad_total) from ventas_cat)
ORDER BY cantidad_total DESC

-- Consulta 7 
-- Mostrar la categoría mas comprada por cada país. Se debe de mostrar el
--nombre del país, nombre de la categoría y el monto
with pais_categoria as (
	select p.nombre as pais ,cat.nombre, o.cantidad from Orden o 
	inner join Cliente c on c.id_cliente= o.id_cliente
	inner join Producto prod on prod.id_producto = o.id_producto
	inner join Categoria cat on cat.id_categoria = prod.id_Categoria
	inner join Pais p on p.id_pais = c.id_pais
), ventas_cat as (
	select pais, nombre, sum(cantidad) as cantidad from pais_categoria
	group by pais, nombre
), ventas_cat_max as (
	select pais, max(cantidad) as cantidad from ventas_cat
	group by pais
)
select vc.pais,vc.nombre as categoria,vc.cantidad from ventas_cat vc
inner join ventas_cat_max vcm 
on vc.pais = vcm.pais AND vc.cantidad = vcm.cantidad

--Consulta 8
--Mostrar las ventas por mes de Inglaterra. Debe de mostrar el numero del mes y el monto.
select MONTH(o.fecha_orden) as mes,SUM(o.cantidad*prod.Precio) as monto from Orden o 
inner join Vendedor v on v.id_vendedor = o.id_vendor
inner join Pais p on p.id_pais = v.id_pais
inner join Producto prod on prod.id_producto = o.id_producto
where p.id_pais = 10
group by MONTH(o.fecha_orden)
order by mes

--Consulta 9 
--Mostrar el mes con mas y menos ventas. Se debe de mostrar el numero de
--mes y monto. (Una sola consulta).
WITH mes_monto as (
	select MONTH(o.fecha_orden) as mes,SUM(o.cantidad*prod.Precio) as monto from Orden o 
	inner join Vendedor v on v.id_vendedor = o.id_vendor
	inner join Pais p on p.id_pais = v.id_pais
	inner join Producto prod on prod.id_producto = o.id_producto
	group by MONTH(o.fecha_orden)
)
SELECT * FROM mes_monto where monto = (select max(monto) from mes_monto)
UNION 
SELECT * FROM mes_monto where monto = (select min(monto) from mes_monto)

--Consulta 10
--Mostrar las ventas de cada producto de la categoría deportes. Se debe de
--mostrar el id del producto, nombre y monto
select o.id_producto, p.Nombre,sum(o.cantidad*p.Precio) as total from Orden o 
inner join Vendedor v on v.id_vendedor = o.id_vendor
inner join Producto p on p.id_producto = o.id_producto
inner join Categoria c on c.id_categoria = p.id_Categoria
where c.id_categoria = 15
group by o.id_producto, p.Nombre
