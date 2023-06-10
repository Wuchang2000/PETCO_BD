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
--incluyendo la actualización del stock

Select * from dbo.MEDICAMENTO