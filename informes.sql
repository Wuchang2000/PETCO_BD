--REPORTE GUARDERIA
--1. El tipo de mascota que más se deja en la guardería para su cuidado (tipo y
--cantidad).
CREATE OR ALTER VIEW general.masTipoMascota
as
SELECT top 1 especie, COUNT(*) as cantidad from general.MASCOTA group by especie order by COUNT(*) desc
GO

SELECT * from general.masTipoMascota

--2. En qué época del año se deja un mayor número de mascotas en la guardería

CREATE OR ALTER FUNCTION general.dimeEpoca (@fecha datetime)
returns varchar(20)
as
begin
	declare @epoca varchar(20)
    DECLARE @mes int

    SET @mes = MONTH(@fecha)

    IF @mes IN (12, 1, 2)
        SET @epoca = 'Invierno'
    ELSE IF @mes IN (3, 4, 5)
        SET @epoca = 'Primavera'
    ELSE IF @mes IN (6, 7, 8)
        SET @epoca = 'Verano'
    ELSE
        SET @epoca = 'Otoño'
    RETURN @epoca
end

CREATE OR ALTER VIEW general.masEpoca
as
select top 1 general.dimeEpoca(fecha_ini) as Epoca, count(general.dimeEpoca(fecha_ini)) as cantidad
from general.GUARDERIA group by general.dimeEpoca(fecha_ini) order by count(general.dimeEpoca(fecha_ini)) desc
go

begin tran
update general.GUARDERIA set fecha_ini = '2022-03-21' where id_guarderia = 20
SELECT * from general.GUARDERIA where id_guarderia = 20
select  * from general.masEpoca
rollback tran

--3. Listado de las mascotas y su dueño datos generales, número de días en la
--guardería, datos generales de ambos. EL reporte se obtiene en un periodo de
--fechas

CREATE OR ALTER VIEW general.datosMascotaUsuario
as
SELECT (u.nom+' '+u.pat+' '+u.mat) as nombre_usuario, u.telefono, u.domicilio, 
m.nombre as nombre_mascota, m.especie, m.sexo as sexo_mascota, m.raza, m.razgos,
m.edad as edad_mascota, datediff(day,g.fecha_ini,g.fecha_fin) as num_dias
from general.USUARIO_COMUN u
inner join general.MASCOTA m on u.id_usuario = m.id_usuario
inner join general.GUARDERIA g on g.id_guarderia = m.id_guarderia

SELECT * from general.datosMascotaUsuario

--4. Enfermedades más frecuentes (5), total de animales con dicha enfermedad
--ordenados de mayor a menor

CREATE OR ALTER VIEW general.enfermedadesMayor
as
SELECT diagnostico, count(diagnostico) as cantidad 
from general.CONSULTA group by diagnostico


SELECT * from general.enfermedadesMayor order by cantidad desc

--REPORTE VETERINARIA

--1. Gastos de cada mascota, datos de la mascota, fechas y días de estancia,
--descripción de gatos y costo.

CREATE OR ALTER VIEW general.INFO_GASTO_X_MASCOTA
as
SELECT m.nombre as nombre_mascota, m.especie, m.raza, m.edad, m.razgos,
sum(co.costo_total) as costo_veterinario, datediff(day,g.fecha_ini,fecha_fin) as dias_estancia,
g.costo as costo_estancia, (sum(co.costo_total)+g.costo) total_gastado
from general.MASCOTA m
left join general.CONSULTA co on m.id_mascota = co.id_mascota
left join general.GUARDERIA g on g.id_guarderia = m.id_guarderia
group by m.nombre, m.especie, m.raza, m.edad, m.razgos, g.costo, g.fecha_ini, fecha_fin

SELECT * from general.INFO_GASTO_X_MASCOTA

--2. Listado con datos generales de las consultas por periodos de tiempo,
--incluyendo veterinario que lo atendió, diagnóstico y medicamento.

CREATE OR ALTER VIEW general.datos_consulta
as
SELECT (e.nombre+' '+e.paterno+' '+e.materno) as nombre_veterinario, 
c.fecha, c.diagnostico, m.nombre_medicamento from general.CONSULTA c
inner join empleados.VETERINARIO v on c.id_empleado = v.id_empleado
inner join empleados.EMPLEADO e on v.id_empleado = e.id_empleado
inner join general.receta r on r.id_consulta = c.id_consulta
inner join catalogos.MEDICAMENTO m on r.id_medicamento = m.id_medicamento
group by e.nombre, e.paterno, e.materno, c.fecha, c.diagnostico, m.nombre_medicamento

SELECT * from general.datos_consulta order by fecha

--3. Inventario de medicamentos, con su costo por centro.

--4. Enfermedades más frecuentes, por centro, ordenadas de mayor a menor

CREATE OR ALTER VIEW general.enfermedad_x_centro
as
SELECT c.id_centro, co.diagnostico as enfermedad, count(co.diagnostico) as cantidad from catalogos.CENTRO c
inner join general.GUARDERIA g on c.id_centro = g.id_centro
inner join general.MASCOTA m on m.id_guarderia = g.id_guarderia
inner join general.CONSULTA co on co.id_mascota = m.id_mascota
group by c.id_centro, co.diagnostico

SELECT * from general.enfermedad_x_centro order by id_centro

--5. Reporte de ventas de medicamentos en un periodo de tiempo, incluyendo
--cantidad y monto total

CREATE OR alter VIEW general.reporte_venta_medicamento
as
SELECT co.fecha, m.nombre_medicamento, sum(r.cantidad) as cantidad, (r.cantidad*m.costo) as monto_total
from general.CONSULTA co
inner join general.receta r on r.id_consulta = co.id_consulta
inner join catalogos.MEDICAMENTO m on r.id_medicamento = m.id_medicamento
group by m.nombre_medicamento, r.cantidad, m.costo, co.fecha, m.nombre_medicamento

SELECT * from general.reporte_venta_medicamento order by fecha

--REPORTE VENTAS

--1. El centro con mayor número de ventas en un periodo de tiempo. (Separar las
--ventas en línea de las ventas físicas de cada estado).
CREATE OR ALTER VIEW general.REPORTE_VENTAS_FISICAS
as
SELECT top 1 es.nombre as estado, c.id_centro,
sum(c.id_centro) as ventas_fisicas
from general.VENTA_FISICA vf
inner join empleados.VENDEDOR ve on vf.id_empleado = ve.id_empleado
inner join empleados.EMPLEADO e on e.id_empleado = vf.id_empleado
inner join catalogos.CENTRO c on c.id_centro = e.id_centro
inner join catalogos.ESTADO es on es.id_estado = c.id_estado
group by es.nombre, c.id_centro
order by sum(vf.id_empleado) desc

SELECT * from general.REPORTE_VENTAS_FISICAS

--2. Los artículos más vendidos y los menos vendidos por categoría.
--Ventas fisicas
CREATE OR ALTER VIEW general.datos_ventasF
as
SELECT cp.descripcion as categoria, pt.detalles as producto,
sum(dc.cantidad) as cantidad_vendida from general.VENTA_FISICA vf
inner join general.DETALLE_CUENTA dc on dc.id_ventaF = vf.id_ventaF
inner join catalogos.PRODUCTO_TIENDA pt on pt.id_producto = pt.id_producto
inner join catalogos.CATEGORIA_PRODUCTO cp on cp.id_categoria = pt.id_categoria
group by cp.descripcion, pt.detalles, cp.id_categoria

CREATE OR ALTER FUNCTION general.REPORTE_MAS_VENDIDOF()
returns @result table (categoria varchar(40),
						producto varchar(40),
						cantidad numeric(4,0))
as
begin
	declare @max int = (SELECT count(id_categoria) from catalogos.CATEGORIA_PRODUCTO)
	declare @count int = 1
	WHILE @count <= @max
	begin
		insert into @result
		SELECT top 1 * from general.datos_ventasF 
		where categoria = (SELECT descripcion from catalogos.CATEGORIA_PRODUCTO 
							where id_categoria = @count)
		order by cantidad_vendida desc
		insert into @result
		SELECT top 1 * from general.datos_ventasF 
		where categoria = (SELECT descripcion from catalogos.CATEGORIA_PRODUCTO 
							where id_categoria = @count)
		order by cantidad_vendida asc
		set @count = @count+1
	end
	return
end

SELECT * from general.REPORTE_MAS_VENDIDOF()

--Ventas virtuales
CREATE OR ALTER VIEW general.datos_ventasV
as
SELECT cap.descripcion as categoria, pc.detalles as producto,
sum(cp.cantidad) as cantidad_vendida from general.COMPRA_CARRITO cc
inner join general.CAR_PROD cp on cp.id_carrito = cc.id_carrito
inner join catalogos.PRODUCTO_CENTRAL pc on pc.id_producto = cp.id_producto
inner join catalogos.CATEGORIA_PRODUCTO cap on cap.id_categoria = pc.id_categoria
group by cap.descripcion, pc.detalles, cap.id_categoria

CREATE OR ALTER FUNCTION general.REPORTE_MAS_VENDIDOV()
returns @result table (categoria varchar(40),
						producto varchar(40),
						cantidad numeric(4,0))
as
begin
	declare @max int = (SELECT count(id_categoria) from catalogos.CATEGORIA_PRODUCTO)
	declare @count int = 1
	WHILE @count <= @max
	begin
		insert into @result
		SELECT top 1 * from general.datos_ventasV 
		where categoria = (SELECT descripcion from catalogos.CATEGORIA_PRODUCTO 
							where id_categoria = @count)
		order by cantidad_vendida desc
		insert into @result
		SELECT top 1 * from general.datos_ventasV
		where categoria = (SELECT descripcion from catalogos.CATEGORIA_PRODUCTO 
							where id_categoria = @count)
		order by cantidad_vendida asc
		set @count = @count+1
	end
	return
end

SELECT * from general.REPORTE_MAS_VENDIDOV()

--3. Época en la que más se vende. Época del año y monto total

--4. Los 5 empleados con mayor comisión, este reporte se obtiene de manera
--mensual

--5. Inventario de las tiendas de cada tienda

