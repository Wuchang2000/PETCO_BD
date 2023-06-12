SELECT * from empleados.EMPLEADO

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
