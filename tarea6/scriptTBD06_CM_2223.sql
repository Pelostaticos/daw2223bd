drop table inscripcion;
drop table sesion;
drop table actividad;
drop table cliente;

-- crear la tabla "cliente"
CREATE TABLE cliente (
  id NUMBER(10) PRIMARY KEY,
  dni char(9) UNIQUE NOT NULL,
  nombre VARCHAR2(50) NOT NULL,
  apellidos VARCHAR2(50) NOT NULL,
  fec_nac DATE NOT NULL,
  genero char(1) NOT NULL check (genero in ('H','M')),
  telefono VARCHAR2(15) NOT NULL,
  direccion VARCHAR2(100) NOT NULL
);

INSERT INTO cliente VALUES (1, '50984975R', 'Juan', 'González Sánchez', TO_DATE('1985-01-15', 'YYYY-MM-DD'), 'H', '956123456', 'C/. del Sol, 1, 1B - Rota');
INSERT INTO cliente VALUES (2, '39540031H', 'María', 'López Fernández', TO_DATE('1990-06-20', 'YYYY-MM-DD'), 'M', '956654321', 'Av. de los Pinares, 5, 2A - Sanlúcar');
INSERT INTO cliente VALUES (3, '32585558D', 'Antonio', 'García Pérez', TO_DATE('1982-09-12', 'YYYY-MM-DD'), 'H', '617123456', 'C/. Mayor, 10, 1D - Chipiona');
INSERT INTO cliente VALUES (4, '36960400K','Ana', 'Torres Ruiz', TO_DATE('1995-03-01', 'YYYY-MM-DD'), 'M', '617654321', 'Av. del Mar, 25, 2C - Rota');
INSERT INTO cliente VALUES (5, '32070947T', 'Carlos', 'Gutiérrez Ramírez', TO_DATE('1988-11-02', 'YYYY-MM-DD'), 'H', '956555444', 'C/. de la Palmera, 2, 3B - Sanlúcar');
INSERT INTO cliente VALUES (6, '01081529T', 'Carmen', 'Fernández González', TO_DATE('1993-07-28', 'YYYY-MM-DD'), 'M', '956444555', 'Av. de los Cipreses, 15, 2D - Chipiona');
INSERT INTO cliente VALUES (7, '92704434J', 'David', 'Martín Sánchez', TO_DATE('1992-02-16', 'YYYY-MM-DD'), 'H', '617987654', 'C/. del Mar, 6, 1A - Rota');
INSERT INTO cliente VALUES (8, '31168812V', 'Isabel', 'Pérez Romero', TO_DATE('1986-04-10', 'YYYY-MM-DD'), 'M', '617876543', 'Av. de los Pinares, 10, 3C - Sanlúcar');
INSERT INTO cliente VALUES (9, '39899727V', 'Jorge', 'González Rodríguez', TO_DATE('1980-12-05', 'YYYY-MM-DD'), 'H', '956222333', 'C/. Mayor, 3, 2B - Chipiona');
INSERT INTO cliente VALUES (10, '38997861G', 'Laura', 'Sánchez Gómez', TO_DATE('1998-08-23', 'YYYY-MM-DD'), 'M', '956333222', 'Av. del Mar, 20, 1C - Rota');
INSERT INTO cliente VALUES (11, '10644555V', 'Sofía', 'Hernández Torres', TO_DATE('1991-05-08', 'YYYY-MM-DD'), 'M', '956888999', 'C/. de la Rosa, 5, 2B - Sanlúcar');
INSERT INTO cliente VALUES (12, '45383424P', 'Javier', 'Ruiz Gutiérrez', TO_DATE('1986-11-12', 'YYYY-MM-DD'), 'H', '956777888', 'Av. del Mar, 10, 1D - Chipiona');
INSERT INTO cliente VALUES (13, '49248215V', 'Lucía', 'Sánchez Fernández', TO_DATE('1994-02-17', 'YYYY-MM-DD'), 'M', '617234567', 'C/. de los Olivos, 20, 3C - Rota');
INSERT INTO cliente VALUES (14, '61209680X', 'Daniel', 'García Ruiz', TO_DATE('1983-09-28', 'YYYY-MM-DD'), 'H', '617345678', 'Av. de los Cipreses, 3, 1B - Sanlúcar');
INSERT INTO cliente VALUES (15, '84250265T', 'Adriana', 'Pérez Torres', TO_DATE('1996-06-30', 'YYYY-MM-DD'), 'M', '956444555', 'C/. del Sol, 15, 2D - Chipiona');
INSERT INTO cliente VALUES (16, '39892898L', 'Manuel', 'González Pérez', TO_DATE('1989-12-17', 'YYYY-MM-DD'), 'H', '956888777', 'Av. de los Pinares, 1, 3A - Rota');
INSERT INTO cliente VALUES (17, '36627215Z', 'Sara', 'Torres Fernández', TO_DATE('1992-07-22', 'YYYY-MM-DD'), 'M', '617456789', 'C/. Mayor, 5, 2C - Sanlúcar');
INSERT INTO cliente VALUES (18, '91859581L', 'Miguel', 'García Sánchez', TO_DATE('1987-03-04', 'YYYY-MM-DD'), 'H', '956999888', 'Av. de la Playa, 20, 1B - Chipiona');
INSERT INTO cliente VALUES (19, '15332307R', 'Alicia', 'Martín López', TO_DATE('1981-10-19', 'YYYY-MM-DD'), 'M', '617567890', 'C/. de los Pescadores, 8, 3D - Rota');
INSERT INTO cliente VALUES (20, '60696291G', 'Pedro', 'González Torres', TO_DATE('1997-04-25', 'YYYY-MM-DD'), 'H', '956777666', 'Av. de los Cipreses, 6, 2B - Sanlúcar');
INSERT INTO cliente VALUES (21, '61081184S', 'María', 'Martínez García', TO_DATE('01-01-1980','DD-MM-YYYY'), 'M', '956123456', 'C/. Alameda, 15, 2ºB, Sanlúcar');
INSERT INTO cliente VALUES (22, '86468415F', 'Antonio', 'Hernández Pérez', TO_DATE('15-06-1975','DD-MM-YYYY'), 'H', '677654321', 'Av. de la Constitución, 23, Rota');
INSERT INTO cliente VALUES (23, '15243281P', 'Isabel', 'González Torres', TO_DATE('12-12-1990','DD-MM-YYYY'), 'M', '956987654', 'C/. Gran Vía, 8, 3ºD, Rota');
INSERT INTO cliente VALUES (24, '88737813H', 'Manuel', 'García Sánchez', TO_DATE('22-09-1985','DD-MM-YYYY'), 'H', '679876543', 'C/. de la Palma, 5, 1ºA, Chipiona');
INSERT INTO cliente VALUES (25, '06349006V', 'Ana', 'Fernández Gómez', TO_DATE('08-03-1988','DD-MM-YYYY'), 'M', '956456789', 'C/. Rosalía de Castro, 12, 2ºC, Sanlúcar');

-- Crear la tabla "actividad"
CREATE TABLE actividad (
  id CHAR(3) PRIMARY KEY,
  nombre VARCHAR2(50) NOT NULL,
  descripcion VARCHAR2(200) NOT NULL,
  duracion NUMBER(2) NOT NULL,
  capacidad_max NUMBER(2) NOT NULL,
  coste number(3,1) default 5.0
);
INSERT INTO actividad VALUES ('SPI', 'Spinning', 'Actividad cardiovascular en bicicleta estática',  45, 20, 6);
INSERT INTO actividad VALUES ('YOG', 'Yoga', 'Actividad de estiramientos y relajación', 60, 15, 7);
INSERT INTO actividad VALUES ('PIL', 'Pilates', 'Actividad centrada en el fortalecimiento del cuerpo', 45, 10, 10);
INSERT INTO actividad VALUES ('BOD', 'Body Pump', 'Actividad de fuerza y resistencia muscular', 60, 20, 9);

CREATE TABLE sesion (
    id NUMBER(10) PRIMARY KEY,
    id_actividad CHAR(3),
    fecha_actividad TIMESTAMP default SYSDATE NOT NULL UNIQUE,
    ocupacion NUMBER(2) DEFAULT 0,
    FOREIGN KEY (id_actividad) REFERENCES actividad(id)
);

INSERT INTO sesion VALUES (1, 'SPI', TO_TIMESTAMP('14-03-2023 18:30','DD/MM/YYYY HH24:MI') ,0);
INSERT INTO sesion VALUES (2, 'YOG', TO_TIMESTAMP('14-03-2023 20:00','DD/MM/YYYY HH24:MI') ,0);
INSERT INTO sesion VALUES (3, 'PIL', TO_TIMESTAMP('11-04-2023 18:00','DD/MM/YYYY HH24:MI') ,0);
INSERT INTO sesion VALUES (4, 'BOD', TO_TIMESTAMP('11-04-2023 19:00','DD/MM/YYYY HH24:MI') ,0);
INSERT INTO sesion VALUES (5, 'SPI', TO_TIMESTAMP('12-04-2023 17:30','DD/MM/YYYY HH24:MI') ,0);
INSERT INTO sesion VALUES (6, 'SPI', TO_TIMESTAMP('12-04-2023 18:30','DD/MM/YYYY HH24:MI') ,0);
INSERT INTO sesion VALUES (7, 'PIL', TO_TIMESTAMP('22-05-2023 20:00','DD/MM/YYYY HH24:MI') ,0);
INSERT INTO sesion VALUES (8, 'PIL', TO_TIMESTAMP('25-05-2023 12:00','DD/MM/YYYY HH24:MI') ,0);

-- Crear la tabla "inscripcion"
CREATE TABLE inscripcion (
  id NUMBER(10) PRIMARY KEY,
  id_cliente NUMBER(10) NOT NULL,
  id_sesion NUMBER(10) NOT NULL,
  fecha_inscripcion TIMESTAMP default SYSDATE NOT NULL,
  estado VARCHAR2(10) NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_sesion) REFERENCES sesion(id)
);

-- 1
INSERT INTO inscripcion VALUES (1, 1, 1, TO_TIMESTAMP('08-03-2023 14:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (8, 2, 1, TO_TIMESTAMP('08-03-2023 14:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');
INSERT INTO inscripcion VALUES (17, 3, 1, TO_TIMESTAMP('11-03-2023 11:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (18, 4, 1, TO_TIMESTAMP('12-03-2023 02:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (19, 5, 1, TO_TIMESTAMP('12-03-2023 11:05:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (20, 6, 1, TO_TIMESTAMP('11-03-2023 13:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (21, 7, 1, TO_TIMESTAMP('09-03-2023 16:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (22, 9, 1, TO_TIMESTAMP('08-03-2023 17:01:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (23, 10, 1, TO_TIMESTAMP('11-03-2023 15:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (24, 11, 1, TO_TIMESTAMP('12-03-2023 14:03:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (25, 13, 1, TO_TIMESTAMP('11-03-2023 11:05:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (26, 14, 1, TO_TIMESTAMP('09-03-2023 14:09:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (27, 15, 1, TO_TIMESTAMP('08-03-2023 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (28, 18, 1, TO_TIMESTAMP('08-03-2023 14:01:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (29, 19, 1, TO_TIMESTAMP('09-03-2023 14:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (30, 20, 1, TO_TIMESTAMP('11-03-2023 14:10:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (31, 21, 1, TO_TIMESTAMP('09-03-2023 14:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (32, 22, 1, TO_TIMESTAMP('09-03-2023 13:14:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (33, 23, 1, TO_TIMESTAMP('12-03-2023 09:24:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (34, 24, 1, TO_TIMESTAMP('09-03-2023 10:44:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
-- 2
INSERT INTO inscripcion VALUES (2, 1, 2, TO_TIMESTAMP('11-03-2023 14:10:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (9, 2, 2, TO_TIMESTAMP('13-03-2023 11:12:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (13, 3, 2, TO_TIMESTAMP('08-03-2023 09:25:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');
INSERT INTO inscripcion VALUES (35, 7, 2, TO_TIMESTAMP('13-03-2023 08:25:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (36, 13, 2, TO_TIMESTAMP('09-03-2023 14:12:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');
INSERT INTO inscripcion VALUES (37, 14, 2, TO_TIMESTAMP('12-03-2023 08:23:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (38, 19, 2, TO_TIMESTAMP('09-03-2023 14:03:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (39, 20, 2, TO_TIMESTAMP('11-03-2023 07:25:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');
INSERT INTO inscripcion VALUES (40, 22, 2, TO_TIMESTAMP('09-03-2023 08:25:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
-- 3
INSERT INTO inscripcion VALUES (3, 1, 3, TO_TIMESTAMP('09-04-2023 11:01:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (14, 3, 3, TO_TIMESTAMP('10-04-2023 09:28:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (41, 23, 3, TO_TIMESTAMP('10-04-2023 10:10:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (42, 11, 3, TO_TIMESTAMP('10-04-2023 11:26:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (43, 5, 3, TO_TIMESTAMP('10-04-2023 19:06:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
-- 4
INSERT INTO inscripcion VALUES (10, 2, 4, TO_TIMESTAMP('10-04-2023 11:01:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (15, 3, 4, TO_TIMESTAMP('09-04-2023 11:11:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (44, 10, 4, TO_TIMESTAMP('10-04-2023 11:11:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');
-- 5
INSERT INTO inscripcion VALUES (5, 1, 5, TO_TIMESTAMP('10-04-2023 19:09:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');
INSERT INTO inscripcion VALUES (11, 2, 5, TO_TIMESTAMP('11-04-2023 15:01:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
-- 6
INSERT INTO inscripcion VALUES (6, 1, 6, TO_TIMESTAMP('11-04-2023 08:34:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (16, 3, 6, TO_TIMESTAMP('11-04-2023 23:07:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
-- 7
INSERT INTO inscripcion VALUES (7, 1, 7, TO_TIMESTAMP('12-05-2023 12:01:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');
INSERT INTO inscripcion VALUES (12, 2, 7, TO_TIMESTAMP('11-05-2023 16:30:00', 'DD/MM/YYYY HH24:MI:SS'), 'Reservado');
INSERT INTO inscripcion VALUES (45, 10, 7, TO_TIMESTAMP('20-05-2023 11:12:00', 'DD/MM/YYYY HH24:MI:SS'), 'Cancelado');


