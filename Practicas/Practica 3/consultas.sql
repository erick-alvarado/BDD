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

