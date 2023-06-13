/*
 * EQUIPO 7 GUARDERIA DE MASCOTAS
 * CORIA MARTINEZ GUSTAVO
 * ORONZOR MONTES MANASES LEONEL
 * PANG ARAIZAGA IAN
*/

-------------------------------------PROCEDIMIENTOS ALMACENADOS-------------------------------------------

--Realice un procedimiento almacenado para registrar una mascota y su brazalete
Create or alter procedure general.registro_mascota_brazalete
@p_id_empleado numeric(10, 0),
@p_id_usuario numeric(10, 0),
@p_id_guarderia numeric(10, 0),
@p_nombre varchar(10),
@p_especie varchar(10),
@p_sexo varchar(10),
@p_raza varchar(10),
@p_razgos varchar(40),
@p_edad numeric(2, 0),
@p_ritmo char(10),
@p_temp varchar(10),
@p_nivelOx varchar(10),
@p_tipo_comida varchar(10),
@p_comida_comio varchar(10)

as
begin
	INSERT INTO general.MASCOTA (id_empleado, id_usuario, id_guarderia,
	nombre, especie, sexo, raza, razgos, edad)
	VALUES (@p_id_empleado, @p_id_usuario, @p_id_guarderia, @p_nombre,
	@p_especie, @p_sexo, @p_raza, @p_razgos, @p_edad);
	INSERT INTO general.REGISTRO_BRAZALETE (id_mascota, ritmoC, temp, nivelOx, tipo_Comida, comida_Comio, [fecha/hora])
	VALUES ((select max(id_mascota) from general.MASCOTA), @p_ritmo, @p_temp, @p_nivelOx, 
	@p_tipo_comida, @p_comida_comio, GETDATE());
	SELECT 'Mascota y brazalete registrados correctamente' AS Mensaje;
end

begin tran
SELECT * from general.MASCOTA
SELECT * from general.REGISTRO_BRAZALETE
execute general.registro_mascota_brazalete 14, 16, 5, 'LUCY', 'gato', 
'hembra', 'atigrado', 'doméstico', 2, '60-100', '36', '80', 'croquetas', 'No'
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from general.MASCOTA
SELECT * from general.REGISTRO_BRAZALETE
rollback tran

--Si se prueba es necesario quitar la insercion del indexado
DBCC CHECKIDENT ('general.mascota', RESEED, 5);
DBCC CHECKIDENT ('general.registro_brazalete', RESEED, 5);
DBCC CHECKIDENT ('general.mascota', NORESEED);
DBCC CHECKIDENT ('general.registro_brazalete', NORESEED);

------------------------------------------------------------------------------------

--Realice un procedimiento almacenado para el actualizar de las lecturas en los
--brazaletes

Create or alter procedure general.nuevo_registro_brazalete
@p_id_registro numeric(10, 0),
@p_id_mascota numeric(10, 0),
@p_ritmo char(10),
@p_fecha_hora datetime,
@p_temp varchar(10),
@p_nivelOx varchar(10),
@p_tipo_comida varchar(10),
@p_comida_comio varchar(10)

as
begin
	if exists (Select * from general.REGISTRO_BRAZALETE 
				where id_registro = @p_id_registro and id_mascota = @p_id_mascota)
	begin
		update general.REGISTRO_BRAZALETE set
		id_mascota = @p_id_mascota,
		ritmoC = @p_ritmo,
		temp = @p_temp,
		nivelOx = @p_nivelOx,
		tipo_comida = @p_tipo_comida,
		comida_comio = @p_comida_comio,
		[fecha/hora] = @p_fecha_hora
		where id_registro = @p_id_registro and id_mascota = @p_id_mascota
		SELECT 'Actualizacion realizada correctamente' AS Mensaje;
	end
	else
	begin
		SELECT 'Algo fallo, revisa los valores' AS Mensaje;
	end
end

--Prueba de funcionamiento
begin tran
SELECT * from general.REGISTRO_BRAZALETE
execute general.nuevo_registro_brazalete 5, 5, '60-100', '2024-06-28 17:39:00', '36', '80', 'croquetas', 'No'
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from general.REGISTRO_BRAZALETE
rollback tran

----------------------------------------------------------------------------------------------------------

--Realice un procediendo almacenado para registrar una consulta

CREATE or alter PROCEDURE general.RegistrarConsulta
    @id_empleado numeric(10, 0),
    @fecha date,
    @hora time(7),
    @diagnostico varchar(40),
    @detalles varchar(40),
    @costo_total money,
    @id_mascota numeric(10, 0)
AS
BEGIN
    INSERT INTO general.CONSULTA (id_empleado, fecha, hora, diagnostico, detalles, costo_total, id_mascota)
    VALUES (@id_empleado, @fecha, @hora, @diagnostico, @detalles, @costo_total, @id_mascota);

    SELECT 'Consulta registrada correctamente' AS Mensaje;
END

--Prueba de funcionamiento
begin tran
SELECT * from general.CONSULTA
execute general.RegistrarConsulta 16, '2023-06-28', '17:39:00', 'mordedura', 'reposo', 0.00, 5
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from general.CONSULTA
rollback tran

--Si se prueba es necesario quitar la insercion del indexado
DBCC CHECKIDENT ('general.consulta', RESEED, 15);

---------------------------------------------------------------------------------------------------

--Realice un procedimiento almacenado para el registro y venta de medicamentos
CREATE or alter PROCEDURE catalogos.RegistrarMedicamento
    @id_medicamento numeric(10, 0),
    @id_consulta numeric(10, 0),
    @nombre_medicamento varchar(10),
    @costo money,
    @cantidad numeric(4, 0)
AS
BEGIN
	if exists (Select * from catalogos.MEDICAMENTO
				where id_medicamento = @id_medicamento
				and nombre_medicamento =@nombre_medicamento and costo = @costo)
	begin
		update catalogos.MEDICAMENTO set cantidad = @cantidad
		where id_medicamento = @id_medicamento and
		nombre_medicamento = @nombre_medicamento and costo = @costo

		SELECT 'Se cambio correctamente la cantidad de medicamento' AS Mensaje;
	end
	else
	begin
		INSERT INTO catalogos.MEDICAMENTO(nombre_medicamento, costo,cantidad)
				VALUES (@nombre_medicamento, @costo, @cantidad);
	end
    
END
------
--incluyendo la actualización del stock

--cambio de cantidad medicamento
begin tran
SELECT * from catalogos.MEDICAMENTO
execute catalogos.RegistrarMedicamento 1,1,'Ibuprofeno',700,2
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from catalogos.MEDICAMENTO
rollback tran
--insertar medicamento
begin tran
SELECT * from catalogos.MEDICAMENTO
execute catalogos.RegistrarMedicamento null,1,'Vendas',150,500
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from catalogos.MEDICAMENTO
rollback tran

--Si se prueba es necesario quitar la insercion del indexado
DBCC CHECKIDENT ('catalogos.MEDICAMENTO', RESEED, 6);

Select * from catalogos.MEDICAMENTO

----------------------------------------------------------------------------------------------

--Realice un procedimiento para dar de alta una venta
--, y otro para cancelar una venta en línea
--así como cancelar una venta física.

CREATE or alter PROCEDURE catalogos.AltaProducto -- 
  @id_categoria numeric(2, 0),
	@descripcion varchar(40),
	@id_producto numeric(10, 0),
	@id_oferta numeric(10, 0),
	@detalles varchar(40),
	@precio money
AS
BEGIN
	if exists (select id_categoria from catalogos.CATEGORIA_PRODUCTO where id_categoria = @id_categoria)
	begin
		INSERT INTO catalogos.PRODUCTO_CENTRAL(id_producto,id_categoria,id_oferta,detalles,precio)
		VALUES (@id_producto,@id_categoria,@id_oferta,@detalles,@precio);
		INSERT INTO catalogos.PRODUCTO_TIENDA(id_producto,id_categoria,id_oferta,detalles,precio)
		VALUES (@id_producto,@id_categoria,@id_oferta,@detalles,@precio);
		SELECT 'Se inseto la venta en centra y tienda' AS Mensaje;
	end
	else
	begin
			INSERT INTO catalogos.CATEGORIA_PRODUCTO(descripcion)
			VALUES (@descripcion);
			INSERT INTO catalogos.PRODUCTO_CENTRAL(id_producto,id_categoria,id_oferta,detalles,precio)
			VALUES (@id_producto,(select max(id_categoria) from catalogos.CATEGORIA_PRODUCTO),@id_oferta,@detalles,@precio);
			INSERT INTO catalogos.PRODUCTO_TIENDA(id_producto,id_categoria,id_oferta,detalles,precio)
			VALUES (@id_producto,(select max(id_categoria) from catalogos.CATEGORIA_PRODUCTO),@id_oferta,@detalles,@precio);
			SELECT 'Se creo una nueva categoria y se inseto la venta en centra y tienda' AS Mensaje;
	end
END

----Producto con categoria existente
begin tran
SELECT * from catalogos.PRODUCTO_TIENDA
execute catalogos.AltaProducto 1,null, 12,1,'chicharrones fritos',15.00 
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from catalogos.PRODUCTO_TIENDA
rollback tran
----Producto sin categoria
begin tran
SELECT * from catalogos.PRODUCTO_TIENDA
execute catalogos.AltaProducto null,'comida', 16,null,'chicharrones fritos',15.00 
SELECT 'DESPUES DEL PROCEDIMIENTO'
select * from catalogos.CATEGORIA_PRODUCTO
SELECT * from catalogos.PRODUCTO_TIENDA
rollback tran

--, y otro para cancelar una venta en línea

CREATE or alter PROCEDURE general.CancelarVentaLinea
    @id_carrito decimal(10,0)
as
begin
	if exists(select id_carrito from general.CARRITO where id_carrito = @id_carrito)
	begin
		update general.COMPRA_CARRITO
		set montoParcial = montoParcial*0.2
		where id_carrito = @id_carrito
		SELECT 'Se cancelo correctamente el pedido '+cast(@id_carrito as varchar) as mensaje
	end
	else
	begin
		SELECT 'No se encontro la venta en linea' AS Mensaje;
	end
end

select * from general.CARRITO
---Pedido existente
begin tran
select * from general.COMPRA_CARRITO
execute general.CancelarVentaLinea 123456
select * from general.COMPRA_CARRITO
rollback
--Pedido inexistente
begin tran
select * from general.COMPRA_CARRITO
execute general.CancelarVentaLinea 122256
select * from general.COMPRA_CARRITO
rollback

--así como cancelar una venta física.
CREATE or alter PROCEDURE dbo.CancelarVentaFisica
    @id_ventaF decimal(10,0)
as
begin
	if exists(select id_ventaF from general.VENTA_FISICA where id_ventaF = @id_ventaF)
	begin
		delete from general.DETALLE_CUENTA where id_ventaF = @id_ventaF
		delete from general.VENTA_FISICA where id_ventaF = @id_ventaF
		SELECT 'Se elimino correctamente el pedido '+cast(@id_ventaF as varchar) as mensaje
	end
	else
	begin
		SELECT 'No se encontro la venta fisica' AS Mensaje;
	end
end

select * from general.VENTA_FISICA
---Pedido existente
begin tran
select * from general.VENTA_FISICA
execute dbo.CancelarVentaFisica 10
select * from general.VENTA_FISICA
rollback
---Pedido inexistente
begin tran
select * from general.VENTA_FISICA
execute dbo.CancelarVentaFisica 15
select * from general.VENTA_FISICA
rollback
----------------------------------------------------------------------------------------------

--Realice un procedimiento almacenado para borrar un usuario, recibe como
--parámetros el nombre de usuario.
CREATE or alter PROCEDURE dbo.EliminaUsuario
    @nombre_usu varchar(20)
AS
BEGIN
	if exists (select um.id_usuario from general.USUARIO_COMUN um 
		left join general.COMPRA_CARRITO cc on cc.id_usuario = um.id_usuario
		left join general.MASCOTA m on m.id_usuario = um.id_usuario
		left join general.REGISTRO_BRAZALETE rb on rb.id_mascota = m.id_mascota
		left join general.CONSULTA c on c.id_mascota = m.id_mascota
		left join general.receta rec on rec.id_consulta = c.id_consulta
		where  um.nom = @nombre_usu  and cc.id_ventaC  is null and id_carrito is null and
		m.id_mascota is null and rb.id_registro is null and c.id_consulta is null and 
		rec.id_medicamento is null)
	begin
		delete from general.USUARIO_COMUN where nom = @nombre_usu
		SELECT 'usuario eliminado' AS Mensaje;
	end
	else
	begin
		SELECT 'No se encontro el usuario' AS Mensaje;
	end
    
END
--------Elimina usuario comun
begin tran
SELECT * from general.USUARIO_COMUN
execute dbo.EliminaUsuario 'hugo'
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from general.USUARIO_COMUN
rollback tran

---------------------------------------------------------------------------------
-- Crear procedimientos almacenados para las tareas del Gerente
CREATE or alter PROCEDURE ContratarPersonal
    @NombreUsuario VARCHAR(50),
    @TipoUsuario VARCHAR(20),
    @CentroCuidado VARCHAR(50),
    @Estado VARCHAR(50)
AS
BEGIN
    -- Crear el usuario
    EXEC sp_adduser @NombreUsuario, @NombreUsuario, @TipoUsuario;

    -- Asignar al centro de cuidado
    EXEC sp_addrolemember @TipoUsuario, @CentroCuidado;

    -- Asignar al estado
    EXEC sp_addrolemember @Estado, @NombreUsuario;
END;

--------------------------------------------------------------------------
-- Crear procedimientos almacenados para las tareas del Gerente
CREATE or alter PROCEDURE ContratarPersonal
    @NombreUsuario VARCHAR(50),
    @TipoUsuario VARCHAR(20),
    @CentroCuidado VARCHAR(50),
    @Estado VARCHAR(50)
AS
BEGIN
    -- Crear el usuario
    EXEC sp_adduser @NombreUsuario, @NombreUsuario, @TipoUsuario;

    -- Asignar al centro de cuidado
    EXEC sp_addrolemember @TipoUsuario, @CentroCuidado;

    -- Asignar al estado
    EXEC sp_addrolemember @Estado, @NombreUsuario;
END;

---------------------------------------------------------------------------------

----ReasignarPersonal
CREATE PROCEDURE ReasignarPersonal
    @NombreUsuario VARCHAR(50),
    @NuevoCentroCuidado VARCHAR(50)
AS
BEGIN
    -- Reasignar al nuevo centro de cuidado
    EXEC sp_droprolemember @NombreUsuario, @NombreUsuario;
    EXEC sp_addrolemember @NombreUsuario, @NuevoCentroCuidado;
END;

---------------------------------------------------------------------

---DespedirPersonal
CREATE PROCEDURE DespedirPersonal
    @NombreUsuario VARCHAR(50)
AS
BEGIN
    -- Eliminar el usuario
    EXEC sp_dropuser @NombreUsuario;
END;

--------------------------------TRIGGER-----------------------------

-- trigger que calcula el costo total de la consulta

CREATE or alter TRIGGER general.CalcularCostoTotal
ON general.RECETA
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE consulta
    SET costo_total = (
        SELECT ISNULL(SUM(m.costo * r.cantidad), 0) + 150 
        FROM general.RECETA r
        INNER JOIN catalogos.MEDICAMENTO m ON r.id_medicamento = m.id_medicamento
        WHERE r.id_consulta = consulta.id_consulta
    )
    FROM general.CONSULTA consulta
    WHERE consulta.id_consulta IN (
        SELECT DISTINCT id_consulta FROM inserted
        UNION
        SELECT DISTINCT id_consulta FROM deleted
    )
end

--trigger que limita que un cuidador tenga maximo 5 mascotas que atender

CREATE or alter TRIGGER general.LimitarCantidadMascotas
ON general.mascota
AFTER INSERT, UPDATE
AS
begin
    DECLARE @TotalMascotas INTeger
    set @TotalMascotas = (select COUNT(*) FROM general.MASCOTA where id_empleado = (select id_empleado from inserted))
    IF @TotalMascotas > 5
    BEGIN
        print 'No se pueden agregar más de 5 mascotas.'
        ROLLBACK TRANSACTION
        RETURN
    END
end	


-- triger que hace la cantidad maxima de veterinarios por centro es de 3

CREATE or alter TRIGGER empleados.LimitarCantidadVeterinariosPorCentro
ON empleados.empleado
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @CentroID INTEGER, @TotalVeterinarios INTEGER

    SELECT @CentroID = e.id_centro
    FROM empleados.EMPLEADO e
    INNER JOIN inserted i ON e.id_empleado = i.id_empleado

    SELECT @TotalVeterinarios = COUNT(*)
    FROM empleados.VETERINARIO v
    INNER JOIN empleados.EMPLEADO e ON v.id_empleado = e.id_empleado
    WHERE e.id_centro = @CentroID

    IF @TotalVeterinarios > 3
    BEGIN
		print 'No se pueden agregar más de 3 veterinarios para el centro '
        ROLLBACK TRANSACTION
        RETURN
		
    END
END

---trigger actualiza el costo del monto parcial de car prod

CREATE TRIGGER general.ActualizarMontoParcialCarProd
ON general.CAR_PROD
AFTER INSERT
AS
BEGIN
    -- Actualizar el monto parcial en la tabla CAR_PROD
    UPDATE cp
    SET montoParcial = p.precio
    FROM general.CAR_PROD cp
    INNER JOIN inserted i ON cp.id_producto = i.id_producto
    INNER JOIN catalogos.PRODUCTO_CENTRAL p ON cp.id_producto = p.id_producto
    WHERE cp.id_carrito = i.id_carrito
END

--- trigger que actualiza el monto parcial de compra carrito

CREATE TRIGGER general.ActualizarMontoParcial
ON general.CAR_PROD
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Actualizar las compras de carrito afectadas
    UPDATE compra
    SET montoParcial = ISNULL((SELECT SUM(p.precio * c.cantidad)
        FROM general.CAR_PROD c
        INNER JOIN catalogos.PRODUCTO_CENTRAL p ON c.id_producto = p.id_producto
        WHERE c.id_carrito = compra.id_carrito ), 0)
    FROM general.COMPRA_CARRITO compra
    WHERE compra.id_carrito IN (
        SELECT DISTINCT id_carrito FROM inserted
        UNION
        SELECT DISTINCT id_carrito FROM deleted
    )
END

--- trigger que aplica descuento y sumatoria de la venta fisica


CREATE or alter TRIGGER general.AplicarDescuentoSumarMontoDetalleCuenta
ON general.DETALLE_CUENTA
AFTER INSERT
AS
BEGIN
    -- Actualizar montoParcial con descuento por oferta
    UPDATE dc
    SET montoParcial = CASE
                            WHEN o.tipo = 'N' THEN p.precio * (1 - (o.porcentaje / 100))
                            WHEN o.tipo = 'L' THEN p.precio * (1 - (o.porcentaje / 100))
                            ELSE p.precio
                       END 
    FROM general.DETALLE_CUENTA dc
    INNER JOIN inserted i ON dc.id_ventaF = i.id_ventaF AND dc.id_producto = i.id_producto
    INNER JOIN catalogos.PRODUCTO_TIENDA p ON dc.id_producto = p.id_producto
    INNER JOIN catalogos.OFERTA o ON p.id_oferta = o.id_oferta

    -- Actualizar total en VENTA_FISICA
    UPDATE vf
    SET total = ISNULL((
        SELECT SUM(d.montoParcial * d.cantidad)
        FROM general.DETALLE_CUENTA d
        WHERE d.id_ventaF = vf.id_ventaF
    ), 0)
    FROM general.VENTA_FISICA vf
    INNER JOIN inserted i ON vf.id_ventaF = i.id_ventaF
END

--trigger que pone la comision al vendedor

CREATE TRIGGER general.CalcularComisionSumarSueldoTotal
ON general.VENTA_FISICA
AFTER INSERT
AS
BEGIN
    -- Actualizar comision y sumar al sueldo total del vendedor
    UPDATE v
    SET comision = (i.total * 0.15),
        sueldo_total = sueldo_total + (i.total * 0.15)
    FROM empleados.VENDEDOR v
    INNER JOIN inserted i ON v.id_empleado = i.id_empleado
END


--trigger que valida la existencia del estado antes de insertarse
CREATE or alter TRIGGER empleados.tr_verificar_estado_administrativo
ON empleados.ADMINISTRATIVO
instead of INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE id_estado NOT IN (SELECT id_estado FROM catalogos.ESTADO))
    BEGIN
        RAISERROR('El estado especificado no existe en la tabla ESTADO.', 16, 1)
        ROLLBACK TRANSACTION
    END
END