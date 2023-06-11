/*
 * EQUIPO 7 GUARDERIA DE MASCOTAS
 * CORIA MARTINEZ GUSTAVO
 * ORONZOR MONTES MANASES LEONEL
 * PANG ARAIZAGA IAN
*/

-----------------------------------------------------------------------------------------
--Elaborar el script para la carga de información, el cual debe
--llamarse cargaInicial.sql. este contendrá los inserts necesarios
--para cargar al menos 20 ventas para usuarios registrados y 10
--ventas en establecimiento, 10 usuarios registrados, 10 gestores, 5
--vendedores, 4 categorías con 5 productos cada uno, 5 ofertas y
--5 cestas pendientes de compra.

--Estados--1

use Equipo7_PETCO

INSERT INTO catalogos.ESTADO (nombre)
values ('Aguascalientes'),
        ('Baja California'),
        ('Baja California Sur'),
        ('Campeche'),
        ('Coahuila'),
        ('Colima'),
        ('Chiapas'),
        ('Chihuahua'),
        ('Ciudad de Mexico'),
        ('Durango'),
        ('Estado de Mexico'),
        ('Guanajuato'),
        ('Guerrero'),
        ('Hidalgo'),
        ('Jalisco'),
        ('Michoacan'),
        ('Morelos'),
        ('Nayarit'),
        ('Nuevo Leon'),
        ('Oaxaca'),
        ('Puebla'),
        ('Queretaro'),
        ('Quintana Roo'),
        ('San Luis Potosi'),
        ('Sinaloa'),
        ('Sonora'),
        ('Tabasco'),
        ('Tamaulipas'),
        ('Tlaxcala'),
        ('Veracruz'),
        ('Yucatan'),
        ('Zacatecas');

--Usuarios comun---2

INSERT INTO general.USUARIO_COMUN(nom, pat, mat, domicilio, curp, genero, telefono, numTargeta, vigencia , correo, contraseña)
VALUES
   ('SONIA', 'ESTRELLA', 'RICOS', 'Yobain 09', 'SOER920113MDFSTR01', 'M', 5562719823, '223516283947362739', '2023-08-27', 'soñaer@yahoo.com', 'agts1763dh26'),
   ('JUAN', 'PÉREZ', 'GARCÍA', 'Calle del Sol 123', 'PERJ900625HDFPNC02', 'H', 5551234567, '987654321098765432', '2023-09-10', 'juan.perez@gmail.com', 'abc123xyz'),
   ('MARÍA', 'GUTIÉRREZ', 'SÁNCHEZ', 'Avenida Principal 456', 'GUTM981207MDFSNH03', 'M', 5549873210, '135792468024681357', '2023-07-15', 'maria.gutierrez@gmail.com', 'ingeniero123'),
   ('CARLOS', 'MARTÍNEZ', 'RODRÍGUEZ', 'Av. Reforma 789', 'MARC890521MDFRDC04', 'H', 5587654321, '246813578024681379', '2023-11-05', 'carlos.martinez@gmail.com', 'clave123'),
   ('ANA', 'SÁNCHEZ', 'MARTÍNEZ', 'Calle 10 de Mayo 456', 'SAMA930705MDFSNH08', 'M', 5567092837, '192837465098273645', '2023-10-15', 'ana.sanchez@gmail.com', 'abcxyz123'),
   ('PEDRO', 'GÓMEZ', 'HERNÁNDEZ', 'Av. Juárez 234', 'GOHP870423HDFRND02', 'H', 5572983476, '203948576027384659', '2023-09-01', 'pedro.gomez@gmail.com', 'password123'),
   ('LAURA', 'FLORES', 'CRUZ', 'Calle del Bosque 56', 'FOCL880210MDFLRA05', 'M', 5547819203, '293847560928374651', '2023-07-30', 'laura.flores@gmail.com', 'secreto456'),
   ('RICARDO', 'RAMÍREZ', 'LÓPEZ', 'Paseo de la Reforma 789', 'RALR950713HDFRCD03', 'H', 5550982736, '384756092837465109', '2023-11-20', 'ricardo.ramirez@gmail.com', 'qwerty789'),
   ('PAULA', 'RODRÍGUEZ', 'GÓMEZ', 'Av. Insurgentes 456', 'ROGP900601HDFDLA09', 'M', 5562738492, '273645098273645091', '2023-09-05', 'paula.rodriguez@gmail.com', 'asdfg123'),
   ('MIGUEL', 'SANTOS', 'MARTÍNEZ', 'Calle del Carmen 234', 'SAMM920317HDFNTG07', 'H', 5549837261, '495836274059283746', '2023-07-20', 'miguel.santos@gmail.com', 'zxcvb789'),
   ('ISABEL', 'GARCÍA', 'HERNÁNDEZ', 'Calle de la Luna 78', 'GAHI910215HDFBLS06', 'M', 5572968473, '495836273645092836', '2023-10-10', 'isabel.garcia@gmail.com', 'qazwsx456'),
   ('LUIS', 'MARTÍNEZ', 'RODRÍGUEZ', 'Av. Hidalgo 123', 'MARR850726HDFDLU05', 'H', 5558273645, '203948572736459283', '2023-09-15', 'luis.martinez@gmail.com', 'poiuyt123'),
   ('FERNANDA', 'HERNÁNDEZ', 'SÁNCHEZ', 'Calle de los Pinos 67', 'HESF880415MDFNRN08', 'M', 5547982635, '293847560928364507', '2023-07-25', 'fernanda.hernandez@gmail.com', 'lkjhgf456'),
   ('JOSÉ', 'GÓMEZ', 'CRUZ', 'Av. Zaragoza 456', 'GOJC910505HDFZSJ04', 'H', 5582736459, '384759283746502938', '2023-11-25', 'jose.gomez@gmail.com', 'mnbvcxz789'),
   ('ANDREA', 'RODRÍGUEZ', 'GÓMEZ', 'Calle del Roble 89', 'ROGA950213HDFDNR01', 'M', 5569873425, '273645092836459283', '2023-09-20', 'andrea.rodriguez@gmail.com', '0987654321'),
   ('ANTONIO', 'SÁNCHEZ', 'MARTÍNEZ', 'Calle del Sol 345', 'SAMA890713HDFNTN09', 'H', 5554321769, '495836274650293847', '2023-08-05', 'antonio.sanchez@gmail.com', '13579abc'),
   ('SOFÍA', 'MARTÍNEZ', 'HERNÁNDEZ', 'Av. Cuauhtémoc 567', 'MAHS910720HDFRTF00', 'M', 5547892637, '203947562739485629', '2023-07-05', 'sofia.martinez@gmail.com', '24680xyz'),
   ('RAÚL', 'GÓMEZ', 'RODRÍGUEZ', 'Calle del Carmen 456', 'GORR920523HDFLNL06', 'H', 5572983647, '384756092936475628', '2023-10-25', 'raul.gomez@gmail.com', '13579qwe'),
   ('ANAHI', 'RODRÍGUEZ', 'GÓMEZ', 'Av. Reforma 234', 'ROGA940205HDFNHN05', 'M', 5569873426, '273645092836475629', '2023-09-30', 'anahi.rodriguez@gmail.com', '09876poi'),
   ('GERARDO', 'SÁNCHEZ', 'MARTÍNEZ', 'Calle del Bosque 78', 'SAGG880726HDFRCD02', 'H', 5554321768, '495836274650293647', '2023-08-10', 'gerardo.sanchez@gmail.com', '13579mnb'),
   ('DANIELA', 'MARTÍNEZ', 'HERNÁNDEZ', 'Av. Hidalgo 567', 'MAHD890315HDFNLR09', 'M', 5547892636, '203947562784485629', '2023-07-10', 'daniela.martinez@gmail.com', '24680lkj'),
   ('HUGO', 'GÓMEZ', 'RODRÍGUEZ', 'Calle del Roble 12', 'GORH930505HDFRCD07', 'H', 5572983648, '384756092936475829', '2023-11-01', 'hugo.gomez@gmail.com', '13579zxc');


--centros--3

INSERT INTO catalogos.centro (id_estado, oficina_regional)
VALUES
  (1, 1),
  (2, 0),
  (3, 0),
  (4, 0),
  (5, 0),
  (6, 0),
  (7, 1),
  (8, 1),
  (9, 0),
  (10, 1),
  (11, 0),
  (12, 0),
  (13, 0),
  (14, 0),
  (15, 0),
  (16, 0),
  (17, 0),
  (18, 0),
  (19, 0),
  (20, 0),
  (21, 0),
  (22, 0),
  (23, 0),
  (24, 1),
  (25, 0),
  (26, 0),
  (27, 0),
  (28, 0),
  (29, 0),
  (30, 0),
  (31, 0),
  (32, 0);


--Empleados--4

INSERT INTO empleados.Empleado (id_centro, nombre, paterno, materno, curp, domicilio) VALUES
(1, 'Juan', 'Pérez', 'López', 'PELJ900101HDFXNN02', 'Calle 123, Ciudad de México'),
(1, 'María', 'Rodríguez', 'García', 'ROGM980202MTZXXX03', 'Avenida Principal 456, Monterrey'),
(1, 'Alejandro', 'Gómez', 'Hernández', 'GOHA880520GTOXXX04', 'Calle Central 789, Guanajuato'),
(1, 'Luis', 'González', 'Martínez', 'GOML921205HDFXYZ05', 'Avenida 456, Puebla'),
(7, 'Ana', 'López', 'Sánchez', 'LOSA880410MTZXXX06', 'Calle 789, Guadalajara'),
(7, 'Pedro', 'Martínez', 'Romero', 'MARP900608GTOXYZ07', 'Calle 456, León'),
(7, 'Mónica', 'Hernández', 'García', 'HEGM890201HDFXYZ08', 'Avenida Principal 123, Querétaro'),
(7, 'Carlos', 'Torres', 'Pérez', 'TOPC910405HDFXYZ09', 'Calle 789, Toluca'),
(8, 'Sofía', 'Vargas', 'Jiménez', 'VAJS950101HDFXYZ10', 'Avenida 123, Cancún'),
(8, 'Fernando', 'Ortega', 'Rojas', 'ORRF930701HDFXYZ11', 'Calle Principal 456, Mérida'),
(8, 'Laura', 'Díaz', 'Morales', 'DIAM850202HDFXYZ12', 'Avenida Central 789, Monterrey'),
(8, 'Roberto', 'Silva', 'Gómez', 'SIGR910405MTZXYZ13', 'Calle 123, Guadalajara'),
(10, 'Elena', 'Mendoza', 'Navarro', 'MENE960101MTZXYZ14', 'Avenida Principal 456, Puebla'),
(10, 'Javier', 'Rojas', 'Vargas', 'ROVJ900202GTOXYZ15', 'Calle Central 789, Ciudad de México'),
(10, 'Isabel', 'Gutiérrez', 'Flores', 'GUFI890301GTOXYZ16', 'Avenida 123, Guanajuato'),
(10, 'Miguel', 'Morales', 'López', 'MOLM920101MTZXYZ17', 'Calle 456, Monterrey'),
(24, 'Patricia', 'Romero', 'Sánchez', 'ROSP930202HDFXYZ18', 'Avenida Principal 789, León'),
(24, 'Ricardo', 'Flores', 'Gómez', 'FLOG880303MTZXYZ19', 'Calle Central 123, Tijuana'),
(24, 'Daniela', 'Navarro', 'Ortega', 'NADO910404HDFXYZ20', 'Avenida 456, Mérida'),
(24, 'Héctor', 'Jiménez', 'Silva', 'JISH890505HDFXYZ21', 'Calle 789, Monterrey');

--Gestores--5

INSERT INTO empleados.administrativo (id_empleado, id_estado)
VALUES
    (1, 1),
    (5, 7),
    (9, 8),
    (13,10),
    (17, 24);

-- Ofertas-- 6

INSERT INTO catalogos.oferta (tipo, porcentaje, fecha_ini, fecha_fin)
VALUES
  ('N', 0.75, '2023-06-07', '2023-06-18'),
  ('L', 0.85, '2023-07-05', '2023-07-12'),
  ('N', 0.60, '2023-06-15', '2023-06-25'),
  ('L', 0.95, '2023-07-01', '2023-07-07'),
  ('N', 0.50, '2023-06-10', '2023-06-15');


--categoria_producto--7

INSERT INTO catalogos.CATEGORIA_PRODUCTO (descripcion)
VALUES 
('Juguetes'),
('Premios'),
('Alimentos'),
('Utensilios varios');


-- producto_central y producto_tienda --8

INSERT INTO catalogos.producto_central  (id_producto, id_categoria, id_oferta, detalles, precio)
VALUES
  -- Juguetes
  (1234567890, 1, 3, 'Peluche chirriante "SqueakyBuddy"', 25.99),
	(2345678901, 1, 2, 'Juguete interactivo "PawPuzzle"', 12.99),
	(3456789012, 1, NULL, 'Maquillaje base de larga duración', 18.99),
	(4567890123, 1, 1, 'Pelota masticable "DuraBite"', 29.99),
	(5678901234, 1, 4, 'Juguete de cuerda "Tug-o-Fun"', 39.99),

  -- Premios
    (6789912345, 2, NULL,'Galletas de pollo "Crunchy Bites"', 19.99),
	(7891123456, 2, 5, 'Snacks de salmón "Fishy Delights"', 14.99),
	(8901734567, 2, 1, 'Premios de cordero "Tasty Rewards"', 9.99),
	(9412345678, 2, 3, 'Chucherías de manzana "Fruity Treats"', 22.99),
	(1234765890, 2, 2, 'Barritas de buey ahumado "Savory Sticks"', 49.99),

  -- Alimentos
	(2345678900, 3, 4, 'Croquetas premium "NutriPrime"', 59.99),
	(3556789012, 3, NULL, 'Comida húmeda "Delicious Purrfection"', 39.99),
	(4567890124, 3, 1, 'Snacks naturales "Tasty Tidbits"', 14.99),
	(5677901234, 3, 2, 'Alimento seco "Tiny Bites"', 299.99),
	(6789012345, 3, 5, 'Comida especializada "SlimKitty"', 199.99),

  -- Utensilios varios
	(7890123456, 4, 3, 'Cepillo de pelo "GentleGroom"', 79.99),
	(8901234567, 4, NULL, 'Dispensador de bolsas "CleanPaws"', 899.99),
	(9012345678, 4, 4, 'Bebedero automático "HydroFlow"', 149.99),
	(1234567880, 4, 1, 'Correa extensible "FlexiLeash"', 29.99),
	(3345678901, 4, 2, 'Transportador "EasyTravel"', 69.99);


INSERT INTO catalogos.producto_tienda  (id_producto, id_categoria, id_oferta, detalles, precio)
VALUES
  -- Juguetes
    (1234567890, 1, 3, 'Peluche chirriante "SqueakyBuddy"', 25.99),
	(2345678901, 1, 2, 'Juguete interactivo "PawPuzzle"', 12.99),
	(3456789012, 1, NULL, 'Maquillaje base de larga duración', 18.99),
	(4567890123, 1, 1, 'Pelota masticable "DuraBite"', 29.99),
	(5678901234, 1, 4, 'Juguete de cuerda "Tug-o-Fun"', 39.99),

  -- Premios
    (6789912345, 2, NULL,'Galletas de pollo "Crunchy Bites"', 19.99),
	(7891123456, 2, 5, 'Snacks de salmón "Fishy Delights"', 14.99),
	(8901734567, 2, 1, 'Premios de cordero "Tasty Rewards"', 9.99),
	(9412345678, 2, 3, 'Chucherías de manzana "Fruity Treats"', 22.99),
	(1234765890, 2, 2, 'Barritas de buey ahumado "Savory Sticks"', 49.99),

  -- Alimentos
	(2345678900, 3, 4, 'Croquetas premium "NutriPrime"', 59.99),
	(3556789012, 3, NULL, 'Comida húmeda "Delicious Purrfection"', 39.99),
	(4567890124, 3, 1, 'Snacks naturales "Tasty Tidbits"', 14.99),
	(5677901234, 3, 2, 'Alimento seco "Tiny Bites"', 299.99),
	(6789012345, 3, 5, 'Comida especializada "SlimKitty"', 199.99),

  -- Utensilios varios
	(7890123456, 4, 3, 'Cepillo de pelo "GentleGroom"', 79.99),
	(8901234567, 4, NULL, 'Dispensador de bolsas "CleanPaws"', 899.99),
	(9012345678, 4, 4, 'Bebedero automático "HydroFlow"', 149.99),
	(1234567880, 4, 1, 'Correa extensible "FlexiLeash"', 29.99),
	(3345678901, 4, 2, 'Transportador "EasyTravel"', 69.99);

-- Vendedor --9

INSERT INTO empleados.vendedor (id_empleado, sueldo, sueldo_total, comision)
VALUES
   (2, 5000, 5000, 0),
   (6, 5000, 5000, 0),
   (10, 5000, 5000, 0),
   (13, 5000, 5000, 0),
   (18, 5000, 5000, 0);


--Personal Ayuda--10

INSERT INTO empleados.PERSONAL_AYUDA(id_empleado,usuario,contraseña,edad,mascota)
values (3,'blue','gastde1234',20,'P'),
      (7,'red','xdcdece68',25,'G'),
      (11,'black','hbcedh5',24,'P'),
      (14,'lock','jxsbt4',27,'G'),
      (19,'rino','kcxseb2',30,'P');


--Telefonos personal ayuda-- 11

insert into catalogos.Telefono_Personal(id_telefono,id_empleado,telefono)
values (1, 3, 5561889234),
      (2, 7, 6789054321),
      (3, 11, 1234567890),
      (4, 14, 9876543210),
      (5, 19, 5432167890);


-- Veterinario-- 12

INSERT INTO empleados.VETERINARIO(id_empleado,CEDULA,especialidad)
values	(4,6534782349,'Cardiologia'),
		(8,8126453789,'Neurologia'),
		(12,1083645382,'Radiologia'),
		(16,5271865235,'Dermatologia'),
		(20,1452783940,'Traumatologia');


--Guarderia--13

INSERT INTO general.GUARDERIA (id_centro,fecha_ini,fecha_fin)
values
(1,'2023-06-10', '2023-06-15'),
(1,'2023-06-11', '2023-06-16'),
(1,'2023-06-12', '2023-06-17'),
(1,'2023-06-13', '2023-06-18'),
(7,'2023-06-14', '2023-06-19'),
(7,'2023-06-15', '2023-06-20'),
(7,'2023-06-16', '2023-06-21'),
(7,'2023-06-17', '2023-06-22'),
(8,'2023-06-18', '2023-06-23'),
(8,'2023-06-19', '2023-06-24'),
(8,'2023-06-20', '2023-06-25'),
(8,'2023-06-21', '2023-06-26'),
(10,'2023-06-22', '2023-06-27'),
(10,'2023-06-23', '2023-06-28'),
(10,'2023-06-24', '2023-06-29'),
(10,'2023-06-25', '2023-06-30'),
(24,'2023-06-26', '2023-07-01'),
(24,'2023-06-27', '2023-07-02'),
(24,'2023-06-28', '2023-07-03'),
(24,'2023-06-29', '2023-07-04');

-- Mascota-- 14

INSERT INTO general.MASCOTA(id_empleado,id_guarderia,id_usuario,nombre,especie,sexo,raza,razgos,edad) values
(3,1,3,'LUKE', 'perro', 'macho', 'pastor', 'negro con café', 1),
(11,2,8,'MAX', 'perro', 'macho', 'labrador', 'dorado', 2),
(19,3,14,'BELLA', 'perro', 'hembra', 'bulldog ', 'blanco y negro', 3),
(7,4,9,'MININA', 'gato', 'hembra', 'siamés', 'negro', 2),
(14,5,16,'LUCY', 'gato', 'hembra', 'atigrado', 'doméstico', 2);

--CONSULTA --15

INSERT INTO general.CONSULTA(id_empleado,id_mascota,fecha, hora,diagnostico,detalles,costo_total) values
(4,1,'2023-06-09','18:10:00','fractura','reposo',0),
(12,2,'2023-06-16','14:30:00','muy bien','revision',0),
(20,3,'2023-06-20','15:36:00','vacuna','reposo',0),
(8,4,'2023-06-24','16:30:00','desparasitacion','asilado',0),
(16,5,'2023-06-28','17:39:00','mordedura','reposo',0);

-- REGISTRO_BRAZALETE -- 16

INSERT INTO general.REGISTRO_BRAZALETE(id_mascota,ritmoC,[fecha/hora],temp,nivelOx,tipo_Comida,comida_Comio) values
(1,'60-100','2023-06-28 17:39:00','37', '80','croquetas', 'No'),
(2,'60-100','2023-06-29 12:39:00','37', '70','croquetas', 'No'),
(3,'60-100','2023-06-27 13:39:00','36', '80','croquetas', 'No'),
(4,'60-100','2023-06-26 12:39:00','37', '90','croquetas', 'No'),
(5,'60-100','2023-06-25 13:39:00','36', '80','croquetas', 'No');


-- MEDICAMENTO -- 17

INSERT INTO catalogos.MEDICAMENTO(id_consulta,nombre_medicamento,costo, cantidad) values
(1,'Ibuprofeno',700, 500),
(1,'Aspirina',100, 500),
(3,'Atrabica', 150, 500),
(4,'Loxcell', 180, 500),
(5,'Ibuprofeno',700, 500),
(5,'Anestesia',500, 500);


--Venta fisica--

INSERT INTO general.venta_fisica (id_empleado, total)
VALUES
(2, 25.99),
(6, 12.99),
(10, 18.99),
(13, 29.99),
(18, 39.99),
(2, 19.99),
(10, 14.99),
(6, 9.99),
(13, 22.99),
(18, 49.99);


-- Detalle cuenta -- 

INSERT INTO general.detalle_cuenta (id_ventaF, id_producto, montoparcial, cantidad)
VALUES
  (1, 1234567890, 25.99, 3),
  (2, 2345678901, 12.99, 2),
  (3, 3456789012, 18.99, 5),
  (4, 4567890123, 29.99, 1),
  (5, 5678901234, 39.99, 4),
  (6, 6789912345, 19.99, 3),
  (7, 7891123456, 14.99, 2),
  (8, 8901734567, 9.99, 1),
  (9, 9412345678, 22.99, 5),
  (10, 1234765890, 49.99, 3);


--Carrito--

INSERT INTO general.Carrito (id_carrito, id_usuario, cantidad)
VALUES
  (123456, 1, 3),
  (234567, 10, 2),
  (345678, 5, 4),
  (456789, 15, 1),
  (567890, 7, 5),
  (678901, 20, 3),
  (789012, 2, 3),
  (890123, 12, 4),
  (901234, 8, 2),
  (102345, 18, 3),
  (113456, 3, 5),
  (124567, 19, 1),
  (135678, 6, 4),
  (146789, 13, 2),
  (157890, 9, 3),
  (168901, 14, 5),
  (179012, 4, 1),
  (190123, 17, 4),
  (201234, 11, 2),
  (212345, 16, 3),
  (223456, 7, 1),
  (234467, 20, 4),
  (245678, 5, 2),
  (256789, 1, 3),
  (267890, 10, 5),
  (278901, 9, 1);


--Car-prod--

INSERT INTO general.car_prod (id_carrito, id_producto, montoparcial, cantidad)
VALUES
(123456, 1234567890, 25.99, 3),
(234567, 2345678901, 12.99, 2),
(345678, 3456789012, 18.99, 4),
(567890, 4567890123, 29.99, 1),
(789012, 5678901234, 39.99, 5),
(890123, 6789912345, 19.99, 3),
(901234, 7891123456, 14.99, 3),
(102345, 8901734567, 9.99, 4),
(113456, 9412345678, 22.99, 2),
(124567, 1234765890, 49.99, 3),
(135678, 2345678900, 25.99, 5),
(146789, 3556789012, 12.99, 1),
(168901, 4567890124, 18.99, 4),
(179012, 5677901234, 29.99, 2),
(201234, 6789012345, 39.99, 3),
(212345, 7890123456, 19.99, 5),
(223456, 8901234567, 14.99, 1),
(234567, 9012345678, 9.99, 4),
(245678, 1234567880, 22.99, 2),
(256789, 3345678901, 49.99, 3);


---compra_carrito
INSERT INTO general.compra_carrito (id_carrito, id_usuario, id_producto, detalles, montoparcial)
VALUES
(123456, 1, 1234567890, 'Compra del producto', 25.99),
(234567, 10, 2345678901, 'Compra del producto', 12.99),
(345678, 5, 3456789012, 'Compra del producto', 18.99),
(567890, 7, 4567890123, 'Compra del producto', 29.99),
(789012, 2, 5678901234, 'Compra del producto', 39.99),
(890123, 12, 6789912345, 'Compra del producto', 19.99),
(901234, 8, 7891123456, 'Compra del producto', 14.99),
(102345, 18, 8901734567, 'Compra del producto', 9.99),
(113456, 3, 9412345678, 'Compra del producto', 22.99),
(124567, 19, 1234765890, 'Compra del producto', 49.99),
(135678, 6, 2345678900, 'Compra del producto', 25.99),
(146789, 13, 3556789012, 'Compra del producto', 12.99),
(168901, 14, 4567890124, 'Compra del producto', 18.99),
(179012, 4, 5677901234, 'Compra del producto', 29.99),
(201234, 11, 6789012345, 'Compra del producto', 39.99),
(212345, 16, 7890123456, 'Compra del producto', 19.99),
(223456, 7, 8901234567, 'Compra del producto', 14.99),
(234567, 20, 9012345678, 'Compra del producto', 9.99),--
(245678, 5, 1234567880, 'Compra del producto', 22.99),
(256789, 1, 3345678901, 'Compra del producto', 49.99);


--Select de todas las tablas

select * from catalogos.ESTADO--1
select * from general.USUARIO_COMUN--2
select * from catalogos.CENTRO--3
select * from empleados.EMPLEADO--4
select * from empleados.ADMINISTRATIVO--5
select * from catalogos.oferta--6
select * from catalogos.CATEGORIA_PRODUCTO--7
select * from catalogos.producto_central--8
select * from catalogos.producto_tienda--9
select * from empleados.vendedor--10
select * from empleados.PERSONAL_AYUDA--11
select * from catalogos.Telefono_Personal--12
select * from empleados.VETERINARIO--13
select * from general.GUARDERIA--14
select * from general.MASCOTA--15
select * from general.CONSULTA--16
select * from general.REGISTRO_BRAZALETE--17
select * from catalogos.MEDICAMENTO--18
select * from general.venta_fisica--19
SELECT * from general.detalle_cuenta--20
SELECT * from general.carrito--21
select * from general.car_prod--22
select * from general.compra_carrito--23
