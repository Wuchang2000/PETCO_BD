/*
 * EQUIPO 7 GUARDERIA DE MASCOTAS
 * CORIA MARTINEZ GUSTAVO
 * ORONZOR MONTES MANASES LEONEL
 * PANG ARAIZAGA IAN
*/

-- trigger que calcula el costo total de la consulta
select * from general.CONSULTA
select * from general.RECETA where id_consulta = 2
select * from catalogos.MEDICAMENTO
insert into general.receta values
(2,3,2)

--trigger que limita que un cuidador tenga maximo 5 mascotas que atender
SELECT * from general.MASCOTA
begin tran
declare @cont int = 5
declare @i int = 1
while @i <= @cont
begin
INSERT INTO general.MASCOTA(id_empleado,id_guarderia,id_usuario,nombre,especie,sexo,raza,razgos,edad) values
(11,1,3,'LUKE', 'perro', 'macho', 'pastor', 'negro con café', 1)
set  @i = @i+1
end
rollback tran
-- triger que hace la cantidad maxima de veterinarios por centro es de 3

BEGIN TRANSACTION;
update empleados.EMPLEADO set id_centro = 1
where id_empleado in (8, 12, 16)
SELECT * from empleados.VETERINARIO v inner join empleados.EMPLEADO e on v.id_empleado = e.id_empleado
rollback TRANSACTION;

---trigger actualiza el costo del monto parcial de car prod

begin tran
INSERT INTO general.CAR_PROD (id_carrito, id_producto, montoParcial, cantidad)
VALUES (179012, 1234567890, 100, 3);
SELECT * from general.CAR_PROD where id_carrito = 179012
rollback tran

--- trigger que actualiza el monto parcial de compra carrito
begin tran
INSERT INTO general.car_prod (id_carrito, id_producto, montoparcial, cantidad)
VALUES
(135678, 4567890123, 4, 3)
select * from catalogos.PRODUCTO_CENTRAL
select * from general.CAR_PROD
select * from general.COMPRA_CARRITO
rollback tran

--- trigger que aplica descuento y sumatoria de la venta fisica
begin tran
INSERT INTO general.venta_fisica (id_empleado, total)
VALUES
(2, 25.99)
INSERT INTO general.detalle_cuenta (id_ventaF, id_producto, montoparcial, cantidad)
VALUES
  (11, 7891123456, 25.99, 3)
select * from catalogos.OFERTA
select * from catalogos.PRODUCTO_TIENDA
select * from general.DETALLE_CUENTA
select * from general.VENTA_FISICA
rollback tran

DBCC CHECKIDENT ('general.venta_fisica', RESEED, 10);

--trigger que pone la comision al vendedor
begin tran
INSERT INTO general.venta_fisica (id_empleado, total)
VALUES
(2, 25.99)
INSERT INTO general.detalle_cuenta (id_ventaF, id_producto, montoparcial, cantidad)
VALUES
  (10, 4567890123, 25.99, 3)
  select * from general.VENTA_FISICA
select * from general.DETALLE_CUENTA
select * from empleados.VENDEDOR
rollback tran

--trigger que valida la existencia del estado antes de insertarse un administrativo
begin tran
insert into empleados.ADMINISTRATIVO values (18, 33)
rollback tran