use [Equipo7_PETCO]
go

-- Crear usuario administrador
CREATE LOGIN usuarioAdministrador WITH PASSWORD = '1234zaq*', CHECK_POLICY = OFF;
CREATE USER usuarioAdministrador FOR LOGIN usuarioAdministrador;
ALTER ROLE db_owner ADD MEMBER usuarioAdministrador;

-- Crear usuario gestor
CREATE LOGIN usuarioGestor WITH PASSWORD = '1234zaq*', CHECK_POLICY = OFF;
CREATE USER usuarioGestor FOR LOGIN usuarioGestor;
--GRANT INSERT, UPDATE ON Equipo7_PETCO TO usuarioGestor;

-- Crear usuario de solo consulta
CREATE LOGIN usuarioConsulta WITH PASSWORD = '1234zaq*', CHECK_POLICY = OFF;
CREATE USER usuarioConsulta FOR LOGIN usuarioConsulta;
--GRANT SELECT ON Equipo7_PETCO TO usuarioConsulta;


----------------Usuario Comun (Registrado)
-- Crear usuario común
CREATE LOGIN usuarioComun WITH PASSWORD = 'Passw0rd*', CHECK_POLICY = OFF;
CREATE USER usuarioComun FOR LOGIN usuarioComun;

-- Asignar permisos
GRANT SELECT ON dbo.producto_central TO usuarioComun; -- Permisos de consulta en el catálogo de productos
GRANT SELECT ON dbo.centro TO usuarioComun; -- Permisos de consulta en la tabla de centros

----------------------------------------------------------------------------------------------
-----------------------Usuario Personal de ayuda (Cuidadores)
-- Crear usuarios para el personal de cuidado en cada centro de guardería
CREATE LOGIN liderCuidadores WITH PASSWORD = 'Secur3ty$', CHECK_POLICY = OFF;
CREATE USER liderCuidadores FOR LOGIN liderCuidadores;

CREATE LOGIN cuidador1 WITH PASSWORD = '1234Abc*', CHECK_POLICY = OFF;
CREATE USER cuidador1 FOR LOGIN cuidador1;

CREATE LOGIN cuidador2 WITH PASSWORD = 'Pa$$w0rd', CHECK_POLICY = OFF;
CREATE USER cuidador2 FOR LOGIN cuidador2;

-- Crear más usuarios de cuidadores según sea necesario

-- Asignar roles y permisos
ALTER ROLE db_datareader ADD MEMBER liderCuidadores;
ALTER ROLE db_datawriter ADD MEMBER liderCuidadores;

ALTER ROLE db_datareader ADD MEMBER cuidador1;
ALTER ROLE db_datawriter ADD MEMBER cuidador1;

ALTER ROLE db_datareader ADD MEMBER cuidador2;
ALTER ROLE db_datawriter ADD MEMBER cuidador2;

----------------------------------------------------------------
-----------------Veterinario
CREATE LOGIN Veterinario WITH PASSWORD = 'P&ssword1', CHECK_POLICY = OFF;
CREATE USER Veterinario FOR LOGIN Veterinario;

-- Consultas médicas para las mascotas -- Otorgar permisos de consultas
Grant Insert ON dbo.consulta TO Veterinario; -- No tengo claro lo de que tabla hace esto.

----------------------------------------------------------------
-----------------Encargado de tienda
CREATE LOGIN EncargadoTienda WITH PASSWORD = 'Str0ngPass*', CHECK_POLICY = OFF;
CREATE USER EncargadoTienda FOR LOGIN EncargadoTienda;

-- Otorgar permisos de ventas personales
GRANT INSERT ON producto_tienda TO EncargadoTienda;
GRANT INSERT ON producto_central TO EncargadoTienda;

-- Otorgar permisos para actualizar el inventario
GRANT UPDATE ON producto_tienda TO EncargadoTienda;
GRANT UPDATE ON producto_central TO EncargadoTienda;
---------------------------------------------------------
-----------------Personal Administrativo

CREATE LOGIN administrativo WITH PASSWORD = '1qaz2wsx*', CHECK_POLICY = OFF;
CREATE USER administrativo FOR LOGIN administrativo;
GRANT insert, update, delete, select ON dbo.Usuario_comun TO administrativo;
GRANT insert, update, delete, select ON dbo.veterinario TO administrativo;
GRANT insert, update, delete, select ON dbo.personal_ayuda TO administrativo;
GRANT insert, update, delete, select ON dbo.empleado TO administrativo;
GRANT insert, update, delete, select ON dbo.Oferta TO administrativo;
GRANT insert, update, delete, select ON dbo.Categoria_producto TO administrativo;
GRANT insert, update, delete, select ON dbo.Producto_tienda TO administrativo;
GRANT insert, update, delete, select ON dbo.Producto_central TO administrativo;

---------------------------------------------------------
-----------------Gerente

-- Crear el usuario Gerente
CREATE LOGIN Gerente WITH PASSWORD = 'Sup3rPass*', CHECK_POLICY = OFF;
CREATE USER Gerente FOR LOGIN Gerente;

-- Otorgar permisos al usuario Gerente
EXEC sp_addrolemember 'db_securityadmin', 'Gerente';
GRANT ALTER ANY USER TO Gerente;
