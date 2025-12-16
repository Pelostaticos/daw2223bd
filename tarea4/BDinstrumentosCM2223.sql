/*Este código crea una base de datos llamada "instrumentos_musicales" correspondiente a la bd de la tarea 4 del módulo
de Bases de Datos.
La base de datos es original de P.Lluyot.*/

-- Crear la base de datos
drop database if exists instrumentos_musicales;
CREATE DATABASE instrumentos_musicales;

-- Seleccionar la base de datos
USE instrumentos_musicales;

-- Crear la tabla de instrumentos
CREATE TABLE INSTRUMENTO (
  id CHAR(3),
  nombre VARCHAR(50) NOT NULL UNIQUE,
  tipo enum('Cuerda', 'Teclado', 'Percusión' , 'Viento') NOT NULL,
  origen VARCHAR(25),
  descripcion VARCHAR(200),
  PRIMARY KEY (id)
);
-- Crear la tabla Marca
CREATE TABLE MARCA (
  id CHAR(3) NOT NULL ,
  nombre VARCHAR(30) NOT NULL UNIQUE,
  ubicacion VARCHAR(25) NOT NULL,
  descripcion VARCHAR(100) ,
  fecha_fundacion DATE,
  PRIMARY KEY (id)
);
-- Crear la tabla modelo instrumento
CREATE TABLE MODELO_INSTRUMENTO (
  id_modelo VARCHAR(50) NOT NULL,
  id_instrumento CHAR(3) NOT NULL,
  id_marca CHAR(3) NOT NULL,
  PRIMARY KEY (id_modelo),
  FOREIGN KEY (id_instrumento) REFERENCES INSTRUMENTO(id),
  FOREIGN KEY (id_marca) REFERENCES MARCA(id)
);
-- Insertamos valores en la tabla instrumento
INSERT INTO `INSTRUMENTO` VALUES 
('GTR','Guitarra','Cuerda','España','Instrumento de cuerda frotada'),
('PIA' ,'Piano','Teclado','Italia','Instrumento de teclado con sonido percutido'),
('BAT','Batería','Percusión','EE. UU.','Instrumento de percusión con varios componentes'),
('VIO','Violín','Cuerda','Italia','Instrumento de cuerda frotada de tamaño reducido'),
('SAX','Saxofón','Viento','Belgica','Instrumento de viento de metal con boquilla'),
('TRB','Trombón','Viento','Alemania','Instrumento de viento de vara con embocadura en forma de U'),
('FLA','Flauta','Viento','China','Instrumento de viento de metal o madera con boquilla'),
('CLA','Clarinete','Viento','Alemania','Instrumento de viento de madera con boquilla'),
('TRO','Trompeta','Viento','Italia','Instrumento de viento de metal con boquilla y embocadura en forma de V'),
('UKE','Ukulele','Cuerda','Hawaii','Instrumento de cuerda frotada de pequeño tamaño'),
('HAR','Harmónica','Viento','Alemania','Instrumento de viento con boquilla y platillos'),
('MAN','Mandolina','Cuerda','Italia','Instrumento de cuerda frotada con forma de media luna'),
('OBO','Oboe','Viento','Francia','Instrumento de viento de madera con boquilla y doble agujero');
-- insertamos valores en la tabla marca
INSERT INTO MARCA (id, nombre, ubicacion, descripcion, fecha_fundacion) VALUES
  ('GIB', 'Gibson', 'EE. UU.', 'Fabricante de guitarras y bajos de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('YMH', 'Yamaha', 'Japón', 'Fabricante de pianos y teclados de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('PRL', 'Pearl', 'Japón', 'Fabricante de baterías y percusión de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('STR', 'Stradivarius', 'Italia', 'Fabricante de violines de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('SLM', 'Selmer', 'Francia', 'Fabricante de saxofones de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('CNN', 'Conn', 'EE. UU.', 'Fabricante de trombones de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('BCH', 'Bach', 'EE. UU.', 'Fabricante de trompetas de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('KAL', 'Kala', 'EE. UU.', 'Fabricante de ukuleles de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('HON', 'Hohner', 'Alemania', 'Fabricante de armónicas de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('EPI', 'Epiphone', 'EE. UU.', 'Fabricante de mandolinas de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  )),
  ('BCR', 'Buffet Crampon', 'Francia', 'Fabricante de oboes de alta calidad', ADDDATE(
    '1890-01-01',
    INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '1890-01-01', '2000-12-31') + 1)) DAY
  ));
-- insertamos valores en la tabla modelo instrumento
INSERT INTO MODELO_INSTRUMENTO (id_modelo, id_instrumento, id_marca) VALUES
('Les Paul G-101', 'GTR', 'GIB'),
('U1 Y-202', 'PIA', 'YMH'),
('Export P-303', 'BAT', 'PRL'),
('Stradivarius V-404', 'VIO', 'STR'),
('Mark VI S-505', 'SAX', 'SLM'),
('88H T-606', 'TRB', 'CNN'),
('Stradivarius TP-707', 'TRO', 'BCH'),
('KA-S U-808', 'UKE', 'KAL'),
('Marine Band HM-909', 'HAR', 'HON'),
('MM-50E MD-1010', 'MAN', 'EPI'),
('1430P OB-1111', 'OBO', 'BCR'),
('Les Paul G-101-A', 'GTR', 'GIB'),
('U1 Y-202-B', 'PIA', 'YMH'),
('Export P-303-C', 'BAT', 'PRL'),
('Stradivarius V-404-D', 'VIO', 'STR'),
('Mark VI S-505-E', 'SAX', 'SLM'),
('88H T-606-F', 'TRB', 'CNN'),
('Stradivarius TP-707-G', 'TRO', 'STR'),
('KA-S U-808-H', 'UKE', 'KAL'),
('Marine Band HM-909-I', 'HAR', 'HON'),
('MM-50E MD-1010-J', 'MAN', 'EPI'),
('Explorer X-101', 'GTR', 'YMH'),
('SG Standard', 'GTR', 'PRL'),
('ES-335', 'GTR', 'STR'),
('Les Paul Special', 'GTR', 'SLM'),
('Stratocaster', 'GTR', 'CNN'),
('Telecaster', 'GTR', 'BCH'),
('Jazzmaster', 'GTR', 'KAL'),
('Mustang', 'GTR', 'HON'),
('Jaguar', 'GTR', 'EPI'),
('Duo-Sonic', 'GTR', 'BCR'),
('U3', 'PIA', 'YMH'),
('Upright', 'PIA', 'PRL'),
('Baby Grand', 'PIA', 'STR'),
('Full Grand', 'PIA', 'SLM'),
('Superstar', 'BAT', 'PRL'),
('Export Elite', 'BAT', 'STR'),
('Session Studio', 'BAT', 'SLM'),
('Thunderbird', 'VIO', 'GIB'),
('Rickenbacker', 'VIO', 'YMH'),
('Precision Bass', 'VIO', 'PRL'),
('Jazz Bass', 'VIO', 'STR');
-- creamos la tabla tienda
CREATE TABLE TIENDA (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(40) NOT NULL,
  ubicacion VARCHAR(25) NOT NULL,
  horario VARCHAR(100),
  descripcion VARCHAR(255),
  PRIMARY KEY (id)
);
-- insertamos datos en la tabla tienda
INSERT INTO TIENDA (nombre, ubicacion, horario, descripcion) VALUES
  ('Musical Store', 'Madrid', 'L-S 10:00-22:00', 'Tienda especializada en instrumentos musicales'),
  ('Sound Shop', 'Barcelona', 'L-V 11:00-20:00', 'Tienda especializada en equipamiento de sonido'),
  ('Music World', 'Valencia', 'L-D 10:00-21:00', 'Gran superficie de instrumentos musicales y accesorios'),
  ('Musical Express', 'Sevilla', 'L-V 10:00-21:00', 'Tienda especializada en instrumentos de viento y cuerda'),
  ('Music House', 'Bilbao', 'L-D 11:00-20:00', 'Gran superficie de instrumentos y accesorios para músicos'),
  ('Sound Shop', 'Málaga', 'L-S 9:00-22:00', 'Tienda especializada en equipamiento de sonido para grupos de música'),
  ('Music Center', 'Alicante', 'L-V 10:00-21:00', 'Tienda especializada en instrumentos de viento y percusión'),
  ('Musical Zone', 'Tenerife', 'L-D 11:00-20:00', 'Gran superficie de instrumentos y accesorios para músicos'),
  ('Instrumental Shop', 'Zaragoza', 'L-S 9:00-22:00', 'Tienda especializada en instrumentos de cuerda y teclado');

-- Crear la tabla de precios de instrumentos
CREATE TABLE PRECIO (
  id_modelo_instrumento VARCHAR(50),
  id_tienda INT NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  fecha_actualizacion DATE NOT NULL,
  PRIMARY KEY (id_modelo_instrumento, id_tienda),
  FOREIGN KEY (id_modelo_instrumento) REFERENCES MODELO_INSTRUMENTO (id_modelo),
  FOREIGN KEY (id_tienda) REFERENCES TIENDA (id)
);
-- insertamos distintos precios
INSERT  INTO PRECIO (id_modelo_instrumento, id_tienda, precio ,fecha_actualizacion )
SELECT MI.id_modelo, T.id 'tienda', 
CASE
    WHEN MI.id_instrumento = 'PIA' THEN Round(1500.00 + ROUND(RAND() * (CEIL(-400.00) - FLOOR(400.00)), 2) + FLOOR(400.00),2)
    WHEN MI.id_instrumento IN ('MAN','UKE', 'HAR','FLA') THEN round(150.00 + ROUND(RAND() * (CEIL(-70.00) - FLOOR(70.00)), 2) + FLOOR(70.00),2)
    ELSE round(500.00 + ROUND(RAND() * (CEIL(-300.00) - FLOOR(300.00)), 2) + FLOOR(300.00),2)
END,
    ADDDATE( '2019-01-01', INTERVAL FLOOR(RAND() * (TIMESTAMPDIFF(DAY, '2019-01-01', '2023-01-11') + 1)) DAY)
from MODELO_INSTRUMENTO as MI, TIENDA T
order by 4 desc LIMIT 300;

-- Crear la tabla de estilos musicales
CREATE TABLE ESTILO (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(20) NOT NULL,
  PRIMARY KEY (id)
);
-- crear la tabla estilo instumento
create table ESTILO_INSTRUMENTO(
	id_estilo INT,
    id_instrumento CHAR(3),
    primary key(id_estilo, id_instrumento),
    foreign key (id_estilo) REFERENCES ESTILO (id)
    ,foreign key (id_instrumento) REFERENCES INSTRUMENTO (id)
  );
-- insertamos distintos estilos
  INSERT INTO ESTILO (nombre) VALUES
  ('Jazz'),-- , 'Guitarra, Piano, Batería'),
  ('Rock'),--  'Guitarra, Bajo, Batería'),
   ('Clásica'), -- 'Violín, Piano, Guitarra'),
  ('Blues'), -- 'Guitarra, Bajo, Piano'),
  ('Salsa'), -- 'Trombón, Piano, Percusión'),
  ('Folk'),-- 'Guitarra, Flauta, Violín'),
  ('Hip Hop');-- 'Bajo, Piano, Batería');
  
  -- asociamos distintos instrumentos a los estilos
  INSERT INTO ESTILO_INSTRUMENTO (id_estilo, id_instrumento) VALUES
(1,	'BAT'),
(1,	'GTR'),
(1,	'PIA'),
(2,	'BAT'),
(2,	'GTR'),
(2,	'SAX'),
(3,	'PIA'),
(3,	'VIO'),
(4,	'GTR'),
(4,	'PIA'),
(4,	'SAX'),
(5,	'BAT'),
(5,	'FLA'),
(5,	'PIA'),
(6,	'GTR'),
(6,	'TRB'),
(7,	'BAT'),
(7,	'PIA'),
(7,	'SAX');
-- crear la tabla musico
create table MUSICO (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	  nombre VARCHAR(255) NOT NULL UNIQUE,
	  id_instrumento CHAR(3)  NULL,
	  foreign key (id_instrumento) references INSTRUMENTO (id)
  );
-- insertar distintos músicos con su instrumento.  
INSERT INTO MUSICO (id, nombre, id_instrumento) VALUES
(1, 'John Lennon', 'GTR'),
(2, 'Paul McCartney', 'GTR'),
(3, 'George Harrison', 'GTR'),
(4, 'Ringo Starr', 'BAT'),
(5, 'Jimi Hendrix', 'GTR'),
(6, 'Mick Jagger', NULL),
(7, 'Miles Davis', 'FLA'),
(8, 'Charlie Parker', 'SAX'),
(9, 'Duke Ellington', 'PIA'),
(10, 'Roger Daltrey', NULL),
(11, 'Jim Morrison', 'GTR'),
(12, 'Thelonious Monk', 'PIA'),
(13, 'Herbie Hancock', 'PIA'),
(14, 'Keith Richards', 'GTR'),
(15, 'Bob Dylan', 'GTR'),
(16, 'Elvis Presley', 'GTR'),
(17, 'Michael Jackson', 'GTR'),
(18, 'Aretha Franklin', 'PIA'),
(19, 'Prince', 'GTR'),
(20, 'Jimmy Page', 'GTR'),
(21, 'Robert Plant', 'GTR'),
(22, 'Janis Joplin', NULL),
(23, 'Stevie Wonder', 'PIA'),
(24, 'Whitney Houston', NULL),
(25, 'Nina Simone', 'PIA'),
(26, 'Frank Sinatra', NULL);
-- crar la tabla grupo
CREATE TABLE GRUPO (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(40) NOT NULL,
  PRIMARY KEY (id)
);
-- insertamos algunos grupos
INSERT INTO GRUPO (id, nombre) VALUES 
(1, 'The Beatles'),(2, 'The Jimi Hendrix Experience'),(3, 'The Rolling Stones'),
(4, 'The Miles Davis Quintet'),(5, 'The Charlie Parker All-Stars'),(6, 'Duke Ellington Orchestra'),
(7, 'The Who'),(8, 'The Doors'),(9, 'The Thelonious Monk Quartet'),(10, 'The Traveling Wilburys'),(11, 'The TCB Band'),
(12, 'Jackson 5'),(13, 'The New Power Generation'),(14, 'Led Zeppelin');

-- Crear la tabla de músicos y grupos
CREATE TABLE MUSICO_GRUPO (
  id_musico int NOT NULL PRIMARY KEY,
  id_grupo INT,
  foreign key (id_musico) references MUSICO (id),
  FOREIGN KEY (id_grupo) REFERENCES GRUPO (id)
);
-- asociamos músicos a los grupos.
INSERT INTO MUSICO_GRUPO VALUES
(1, 1), -- John Lennon, The Beatles
(2, 1), -- Paul McCartney, The Beatles
(3, 1), -- George Harrison, The Beatles
(4, 1), -- Ringo Starr, The Beatles
(5, 2), -- Jimi Hendrix, The Jimi Hendrix Experience
(6, 3), -- Mick Jagger, The Rolling Stones
(7, 4), -- Miles Davis, The Miles Davis Quintet
(8, 5), -- Charlie Parker, The Charlie Parker All-Stars
(9, 6), -- Duke Ellington, Duke Ellington Orchestra
(10, 7), -- Roger Daltrey, The Who
(11, 8), -- Jim Morrison, The Doors
(12, 9), -- Thelonious Monk, The Thelonious Monk Quartet
(14, 3), -- Keith Richards, The Rolling Stones
(15, 10), -- Bob Dylan, The Traveling Wilburys
(16, 11), -- Elvis Presley, The TCB Band
(17, 12), -- Michael Jackson, Jackson 5
(19, 13), -- Prince, The New Power Generation
(20, 14), -- Jimmy Page, Led Zeppelin
(21, 14); -- Robert Plant, Led Zeppelin
