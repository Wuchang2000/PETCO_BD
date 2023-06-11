--Realice un procedimiento almacenado para registrar una mascota y su brazalete
Create or alter procedure dbo.registro_mascota_brazalete
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
	INSERT INTO dbo.MASCOTA (id_empleado, id_usuario, id_guarderia,
	nombre, especie, sexo, raza, razgos, edad)
	VALUES (@p_id_empleado, @p_id_usuario, @p_id_guarderia, @p_nombre,
	@p_especie, @p_sexo, @p_raza, @p_razgos, @p_edad);
	INSERT INTO REGISTRO_BRAZALETE (id_mascota, ritmoC, temp, nivelOx, tipo_Comida, comida_Comio, [fecha/hora])
	VALUES ((select max(id_mascota) from dbo.MASCOTA), @p_ritmo, @p_temp, @p_nivelOx, 
	@p_tipo_comida, @p_comida_comio, GETDATE());
	SELECT 'Mascota y brazalete registrados correctamente' AS Mensaje;
end

begin tran
SELECT * from dbo.MASCOTA
SELECT * from dbo.REGISTRO_BRAZALETE
execute dbo.registro_mascota_brazalete 14, 16, 5, 'LUCY', 'gato', 
'hembra', 'atigrado', 'doméstico', 2, '60-100', '36', '80', 'croquetas', 'No'
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from dbo.MASCOTA
SELECT * from dbo.REGISTRO_BRAZALETE
rollback tran

--Si se prueba es necesario quitar la insercion del indexado
DBCC CHECKIDENT ('[mascota]', RESEED, 5);
DBCC CHECKIDENT ('[registro_brazalete]', RESEED, 5);
DBCC CHECKIDENT ('[mascota]', NORESEED);
DBCC CHECKIDENT ('[registro_brazalete]', NORESEED);

------------------------------------------------------------------------------------

--Realice un procedimiento almacenado para el actualizar de las lecturas en los
--brazaletes

Create or alter procedure dbo.nuevo_registro_brazalete
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
	if exists (Select * from dbo.REGISTRO_BRAZALETE 
				where id_registro = @p_id_registro and id_mascota = @p_id_mascota)
	begin
		update dbo.REGISTRO_BRAZALETE set
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
SELECT * from dbo.REGISTRO_BRAZALETE
execute dbo.nuevo_registro_brazalete 5, 5, '60-100', '2024-06-28 17:39:00', '36', '80', 'croquetas', 'No'
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from dbo.REGISTRO_BRAZALETE
rollback tran

----------------------------------------------------------------------------------------------------------

--Realice un procediendo almacenado para registrar una consulta

CREATE or alter PROCEDURE dbo.RegistrarConsulta
    @id_empleado numeric(10, 0),
    @fecha date,
    @hora time(7),
    @diagnostico varchar(40),
    @detalles varchar(40),
    @costo_total money,
    @id_mascota numeric(10, 0)
AS
BEGIN
    INSERT INTO CONSULTA (id_empleado, fecha, hora, diagnostico, detalles, costo_total, id_mascota)
    VALUES (@id_empleado, @fecha, @hora, @diagnostico, @detalles, @costo_total, @id_mascota);

    SELECT 'Consulta registrada correctamente' AS Mensaje;
END

--Prueba de funcionamiento
begin tran
SELECT * from dbo.CONSULTA
execute dbo.RegistrarConsulta 16, '2023-06-28', '17:39:00', 'mordedura', 'reposo', 0.00, 5
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from dbo.CONSULTA
rollback tran

--Si se prueba es necesario quitar la insercion del indexado
DBCC CHECKIDENT ('[consulta]', RESEED, 5);

---------------------------------------------------------------------------------------------------

--Realice un procedimiento almacenado para el registro y venta de medicamentos
CREATE or alter PROCEDURE dbo.RegistrarMedicamento
    @id_medicamento numeric(10, 0),
    @id_consulta numeric(10, 0),
    @nombre_medicamento varchar(10),
    @costo money,
    @cantidad numeric(4, 0)
AS
BEGIN
	if exists (Select * from dbo.MEDICAMENTO
				where id_medicamento = @id_medicamento and id_consulta = @id_consulta 
				and nombre_medicamento =@nombre_medicamento and costo = @costo)
	begin
		update dbo.MEDICAMENTO set cantidad = @cantidad
		where id_medicamento = @id_medicamento and id_consulta = @id_consulta and
		nombre_medicamento = @nombre_medicamento and costo = @costo

		SELECT 'Se cambio correctamente la cantidad de medicamento' AS Mensaje;
	end
	else
	begin
		if exists (select * from dbo.CONSULTA where id_consulta =@id_consulta)
			begin
				INSERT INTO dbo.MEDICAMENTO(id_consulta,nombre_medicamento,costo,cantidad)
				VALUES ( @id_consulta, @nombre_medicamento, @costo, @cantidad);

				SELECT 'Consulta registrada correctamente' AS Mensaje;
			end
		else 
		begin
			SELECT 'La consulta a la que quiere agregar el medicamento no existe ' AS Mensaje;
		end
	end
    
END
------
--incluyendo la actualización del stock

--cambio de cantidad medicamento
begin tran
SELECT * from dbo.MEDICAMENTO
execute dbo.RegistrarMedicamento 1,1,'Ibuprofeno',700,2
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from dbo.MEDICAMENTO
rollback tran
--insertar medicamento
begin tran
SELECT * from dbo.MEDICAMENTO
execute dbo.RegistrarMedicamento null,1,'Vendas',150,500
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from dbo.MEDICAMENTO
rollback tran

--Si se prueba es necesario quitar la insercion del indexado
DBCC CHECKIDENT ('[MEDICAMENTO]', RESEED, 6);

Select * from dbo.MEDICAMENTO

----------------------------------------------------------------------------------------------

--Realice un procedimiento para dar de alta una venta
--, y otro para cancelar una venta en línea
--así como cancelar una venta física.

CREATE or alter PROCEDURE dbo.AltaProducto -- 
  @id_categoria numeric(2, 0),
	@descripcion varchar(40),
	@id_producto numeric(10, 0),
	@id_oferta numeric(10, 0),
	@detalles varchar(40),
	@precio money
AS
BEGIN
	if exists (select id_categoria from dbo.CATEGORIA_PRODUCTO where id_categoria = @id_categoria)
	begin
		INSERT INTO dbo.PRODUCTO_CENTRAL(id_producto,id_categoria,id_oferta,detalles,precio)
		VALUES (@id_producto,@id_categoria,@id_oferta,@detalles,@precio);
		INSERT INTO dbo.PRODUCTO_TIENDA(id_producto,id_categoria,id_oferta,detalles,precio)
		VALUES (@id_producto,@id_categoria,@id_oferta,@detalles,@precio);
		SELECT 'Se inseto la venta en centra y tienda' AS Mensaje;
	end
	else
	begin
			INSERT INTO dbo.CATEGORIA_PRODUCTO(descripcion)
			VALUES (@descripcion);
			INSERT INTO dbo.PRODUCTO_CENTRAL(id_producto,id_categoria,id_oferta,detalles,precio)
			VALUES (@id_producto,(select max(id_categoria) from dbo.CATEGORIA_PRODUCTO),@id_oferta,@detalles,@precio);
			INSERT INTO dbo.PRODUCTO_TIENDA(id_producto,id_categoria,id_oferta,detalles,precio)
			VALUES (@id_producto,(select max(id_categoria) from dbo.CATEGORIA_PRODUCTO),@id_oferta,@detalles,@precio);
			SELECT 'Se creo una nueva categoria y se inseto la venta en centra y tienda' AS Mensaje;
	end
END

----Producto con categoria existente
begin tran
SELECT * from dbo.PRODUCTO_TIENDA
execute dbo.AltaProducto 1,null, 12,1,'chicharrones fritos',15.00 
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from dbo.PRODUCTO_TIENDA
rollback tran
----Producto sin categoria
begin tran
SELECT * from dbo.PRODUCTO_TIENDA
execute dbo.AltaProducto null,'comida', 16,null,'chicharrones fritos',15.00 
SELECT 'DESPUES DEL PROCEDIMIENTO'
select * from dbo.CATEGORIA_PRODUCTO
SELECT * from dbo.PRODUCTO_TIENDA
rollback tran

--, y otro para cancelar una venta en línea

CREATE or alter PROCEDURE dbo.CancelarVentaLinea
    @id_carrito decimal(10,0)
as
begin
	if exists(select id_carrito from dbo.CARRITO where id_carrito = @id_carrito)
	begin
		delete from dbo.COMPRA_CARRITO where id_carrito = @id_carrito
		delete from dbo.CAR_PROD where id_carrito = @id_carrito
		delete from dbo.CARRITO where id_carrito = @id_carrito
		SELECT 'Se elimino correctamente el pedido '+cast(@id_carrito as varchar) as mensaje
	end
	else
	begin
		SELECT 'No se encontro la venta en linea' AS Mensaje;
	end
end

select * from dbo.CARRITO
---Pedido existente
begin tran
select * from dbo.CARRITO
execute dbo.CancelarVentaLinea 123456
select * from dbo.CARRITO
rollback
--Pedido inexistente
begin tran
select * from dbo.CARRITO
execute dbo.CancelarVentaLinea 122256
select * from dbo.CARRITO
rollback

--así como cancelar una venta física.
CREATE or alter PROCEDURE dbo.CancelarVentaFisica
    @id_ventaF decimal(10,0)
as
begin
	if exists(select id_ventaF from dbo.VENTA_FISICA where id_ventaF = @id_ventaF)
	begin
		delete from dbo.DETALLE_CUENTA where id_ventaF = @id_ventaF
		delete from dbo.VENTA_FISICA where id_ventaF = @id_ventaF
		SELECT 'Se elimino correctamente el pedido '+cast(@id_ventaF as varchar) as mensaje
	end
	else
	begin
		SELECT 'No se encontro la venta fisica' AS Mensaje;
	end
end

select * from dbo.VENTA_FISICA
---Pedido existente
begin tran
select * from dbo.VENTA_FISICA
execute dbo.CancelarVentaFisica 10
select * from dbo.VENTA_FISICA
rollback
---Pedido inexistente
begin tran
select * from dbo.VENTA_FISICA
execute dbo.CancelarVentaFisica 15
select * from dbo.VENTA_FISICA
rollback
----------------------------------------------------------------------------------------------

--Realice un procedimiento almacenado para borrar un usuario, recibe como
--parámetros el nombre de usuario.
CREATE or alter PROCEDURE dbo.EliminaUsuario
    @nombre_usu varchar(20)
AS
BEGIN
	if exists (select um.id_usuario from dbo.USUARIO_COMUN um 
		left join dbo.COMPRA_CARRITO cc on cc.id_usuario = um.id_usuario
		left join dbo.MASCOTA m on m.id_usuario = um.id_usuario
		left join dbo.REGISTRO_BRAZALETE rb on rb.id_mascota = m.id_mascota
		left join dbo.CONSULTA c on c.id_mascota = m.id_mascota
		left join dbo.MEDICAMENTO med on med.id_consulta = c.id_consulta
		where  um.nom = @nombre_usu  and cc.id_ventaC  is null and id_carrito is null and
		m.id_mascota is null and rb.id_registro is null and c.id_consulta is null and 
		med.id_medicamento is null)
	begin
		delete from dbo.USUARIO_COMUN where nom = @nombre_usu
		SELECT 'usuario eliminado' AS Mensaje;
	end
	else
	begin
		SELECT 'No se encontro el usuario' AS Mensaje;
	end
    
END
--------Elimina usuario comun
begin tran
SELECT * from dbo.USUARIO_COMUN
execute dbo.EliminaUsuario 'hugo'
SELECT 'DESPUES DEL PROCEDIMIENTO'
SELECT * from dbo.USUARIO_COMUN
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