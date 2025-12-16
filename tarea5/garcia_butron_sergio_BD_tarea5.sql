/* ----------------------------------------------------------------------
TAREA5: TRATAMIENTO DE DATOS			(12/03/2023 al 22/03/2023)
	ALUMNO: Sergio García Butrón
    MODULO: Base de datos (BD)
    CURSO-: Desarrollo de Aplicaciones Web 2022/23 (DAW)
	PROFE-: José Lluyot Sánchez
---------------------------------------------------------------------- */

/* Sentencia SQL para seleccionar la base de datos de la tarea 5 */
USE `grupos_trabajo`;

/* APARTADO 1.1.A:
Inserta el centro público 'E.O.I. Alcalá de Guadaíra' (cuya denominación es Escuela Oficial de Idiomas), con código 41700932 y con dirección en C/ Cuesta de Santa María, 14, Alcalá de Guadaíra (Sevilla). cp:41500. Su teléfono es 955622115. (No bilingüe)
 */
INSERT INTO centro VALUE ('41700932','Escuela Oficial de Idiomas', 'E.O.I. Alcalá de Guadaíra','publico','C/ Cuesta de Santa María, 14','Alcalá de Guadaira','Sevilla', '41500', '955221115', false);
SELECT * FROM centro;

/* APARTADO 1.1.B:
Inserta el grupo de trabajo Primeros auxilios con código GT110232, en el siguiente período: del 01/10/2018 al 31/05/2019. El coordinador será el profesor con código: AE112
 */
INSERT INTO grupotrabajo (cod_gt,nombre,fec_inicio,fec_fin,cod_coordinador) VALUE ('GT110232','Primeros auxilios', '2018/10/01','2019/05/31', 'AE112');
SELECT * FROM grupotrabajo;

/* APARTADO 1.2.A:
Elimina todos los teléfonos de los profesores del centro con código 41000272 que pertenecen al departamento de Dibujo. NOTA:Eliminar un teléfono es equivalente a poner NULL en su campo
*/
UPDATE profesor SET telefono=NULL WHERE cod_centro='41000272' AND cod_dep=(SELECT codigo FROM departamento WHERE nombre='Dibujo');
SELECT * FROM profesor WHERE cod_centro='41000272' AND cod_dep=(SELECT codigo FROM departamento WHERE nombre='Dibujo');

/* APARTADO 1.2.B
Actualiza el departamento de la profesora Cristina Sevilla López para que sea el de Latín y Griego
*/
UPDATE profesor SET cod_dep=(SELECT codigo FROM departamento WHERE nombre='Latín y Griego') WHERE nombre='Cristina' AND apellido1='Sevilla' AND apellido2='López';
SELECT * FROM profesor WHERE nombre='Cristina' AND apellido1='Sevilla' AND apellido2='López'; 

/* APARTADO 1.3.A
Elimina del grupo de trabajo "Arduino en el aula" el profesor "David Ares".
*/
DELETE FROM componentes_gt WHERE cod_gt=(SELECT cod_gt FROM grupotrabajo WHERE nombre='Arduino en el aula') AND cod_profesor=(SELECT cod_profesor FROM profesor WHERE nombre='David' AND apellido1='Ares');
SELECT pf.nombre, pf.apellido1, gpt.nombre FROM componentes_gt cgt
INNER JOIN profesor pf ON (pf.cod_profesor=cgt.cod_profesor)
INNER JOIN grupotrabajo gpt ON (gpt.cod_gt=cgt.cod_gt)
WHERE pf.nombre='David' AND pf.apellido1='Ares';

/* APARTADO 1.3.B:
Elimina a la profesora natural de "Moguer" que aún no tiene asignado ningún centro educativo
*/
SELECT * FROM profesor WHERE cod_centro IS NULL AND localidad='Moguer' AND sexo='M';
DELETE FROM profesor WHERE cod_centro IS NULL AND localidad='Moguer' AND sexo='M';
SELECT * FROM profesor WHERE cod_centro IS NULL AND localidad='Moguer' AND sexo='M';

/* APARTADO 2.1:
Asocia los siguientes profesores a cada grupo de trabajo, insertando los siguientes registros en la base de datos, usando una única sentencia SQL.
*/
INSERT componentes_gt VALUES ('GT900122','CC989'),('GT663526','CS115'),('GT993818','FP664'),('GT188934','FT369');
SELECT * FROM componentes_gt WHERE cod_profesor='CC989' OR cod_profesor='CS115' OR cod_profesor='FP664' OR cod_profesor='FT369';

/* APARTADO 2.2:
Actualizar el nombre del profesor "Raquel Aguirre Ballester" del centro con código 41700105, por el profesor "Ana Domínguez Navarro".
NOTA: no es válido poner en la sentencia el cod_profesor AB280, debes obtenerlo a partir del nombre "Raquel Aguirre Ballester"
*/
SELECT cod_profesor FROM profesor WHERE nombre='Raquel' AND apellido1='Aguirre' AND apellido2='Ballester';
UPDATE profesor SET nombre='Ana',apellido1='Domínguez',apellido2='Navarro' WHERE cod_profesor=(SELECT cod_profesor FROM (SELECT * FROM profesor WHERE nombre='Raquel' AND apellido1='Aguirre' AND apellido2='Ballester') AS TEMP);
SELECT * FROM profesor WHERE cod_profesor='AB280';

/*
APARTADO 2.3:
Eliminar (en una única sentencia SQL) a todos los profesores de cualquier centro educativo de la provincia de Córdoba que pertenecen al departamento 14 (Departamento de Tecnología), junto a todos los profesores que tienen los teléfonos 620387725 y 645800612.
*/
SELECT cod_profesor FROM profesor WHERE provincia='Córdoba' AND cod_dep='14'
UNION
SELECT cod_profesor FROM profesor WHERE telefono='620387725' OR telefono='645800612';
DELETE FROM profesor WHERE cod_profesor IN (SELECT cod_profesor FROM (SELECT * FROM profesor WHERE provincia='Córdoba' AND cod_dep='14') AS TEMP1
UNION
SELECT cod_profesor FROM ( SELECT * FROM profesor WHERE telefono='620387725' OR telefono='645800612') AS TEMP2);
SELECT cod_profesor FROM profesor WHERE provincia='Córdoba' AND cod_dep='14'
UNION
SELECT cod_profesor FROM profesor WHERE telefono='620387725' OR telefono='645800612';

/* APARTADO 3.1:
Inicia una transacción. Eliminar del grupo de trabajo GT123411 los profesores del "IES Cristóbal de Monroy". No se dará por correcto este apartado si pones en la sentencia el código del centro 41000272, este código debes obtenerlo a partir de los datos que nos dan, a partir del nombre del centro.
*/
BEGIN;
DELETE FROM componentes_gt WHERE cod_profesor IN (SELECT cod_profesor FROM (SELECT cgt.cod_profesor, cte.nombre, cte.denominacion FROM componentes_gt cgt
INNER JOIN profesor pf ON (pf.cod_profesor=cgt.cod_profesor)
INNER JOIN centro cte ON (pf.cod_centro=cte.codigo)
WHERE cte.denominacion='Instituto de Educación Secundaria' AND cte.nombre='Cristóbal de Monroy' AND cgt.cod_gt='GT123411') AS TEMP);
ROLLBACK;

/* APARTADO 3.2:
Insertar el departamento de Informática para aquellos centros en los que no exista dicho departamento. Utiliza una transacción.
*/
SELECT * FROM dep_centro WHERE cod_dep='15';
BEGIN;
INSERT INTO dep_centro (cod_centro,cod_dep)
SELECT codigo, (SELECT codigo FROM departamento WHERE nombre='Informática') as 'dpto'
FROM centro  
WHERE codigo NOT IN (SELECT cod_centro FROM (SELECT * FROM dep_centro WHERE cod_dep=(SELECT codigo FROM departamento WHERE nombre='Informática')) AS TEMP);
SELECT * FROM dep_centro WHERE cod_dep='15';
ROLLBACK;

/*
APARTADO 3.3:
Actualizar el número de profesores de cada grupo de trabajo, con el número actual de profesores participantes en cada grupo de trabajo. Utiliza una transacción
*/
SELECT * FROM grupotrabajo;
BEGIN;
UPDATE grupotrabajo 
	SET num_profesores=(SELECT COUNT(*) FROM componentes_gt WHERE cod_gt=grupotrabajo.cod_gt);
SELECT * FROM grupotrabajo;
ROLLBACK;

/* APARTADO 4.1:
Queremos modificar el actual coordinador del grupo de trabajo "Huerto en el centro" de forma que sea el profesor "Francisca Jorge Ferrández". El actual coordinador formará parte de los participantes de ese grupo de trabajo
*/
BEGIN;
SELECT * FROM grupotrabajo;
SELECT * FROM componentes_gt WHERE cod_gt='GT123411';
INSERT INTO componentes_gt (cod_gt,cod_profesor) 
VALUES ((SELECT cod_gt FROM grupotrabajo WHERE nombre='Huerto en el centro'),(SELECT cod_coordinador FROM grupotrabajo WHERE nombre='Huerto en el centro'));
DELETE FROM componentes_gt
WHERE cod_gt=(SELECT cod_gt FROM grupotrabajo WHERE nombre='Huerto en el centro') AND cod_profesor=(SELECT cod_profesor FROM profesor WHERE nombre='Francisca' AND apellido1='Jorge' AND apellido2='Ferrández');
UPDATE grupotrabajo
SET cod_coordinador=(SELECT cod_profesor FROM profesor WHERE nombre='Francisca' AND apellido1='Jorge' AND apellido2='Ferrández')
WHERE nombre='Huerto en el centro';
SELECT * FROM grupotrabajo;
SELECT * FROM componentes_gt WHERE cod_gt='GT123411';
ROLLBACK;

/* APARTADO 5.1: Para esta actividad debes establecer dos sesiones de trabajo.
Describe todo el proceso siguiente indicando con comentarios los resultados obtenidos.
    > En la primera sesión debes Bloquear la tabla "grupotrabajo" en modo escritura. 
    > En la segunda sesión, trata de insertar un nuevo grupo de trabajo (estando la tabla "grupotrabajo" bloqueada en la otra sesión en modo escritura).
    > En la primera sesión, inserta un nuevo grupo de trabajo.
    > En la primera sesión, desbloquea la tabla "grupotrabajo" y comprueba si el nuevo grupo de trabajo insertado en la segunda sesión se ha llevado a cabo.
*/

/* PRIMERO: Bloqueo la tabla grupotrabajo en la primera sesión */
USE `grupos_trabajo`;
LOCK TABLE grupotrabajo WRITE;

/* SEGUNDO: Intento insertar un nuevo grupo mientras la tabla grupotrabajo está bloqyeada en la primera sesion
INSERT INTO grupotrabajo (cod_gt,nombre,fec_inicio,fec_fin,num_profesores,cod_coordinador) 
VALUES ('GT987456','Proyectos IoT con Raspberry Pi','2023-03-18','2023-06-30',0,NULL);

OBSERVACIÓN: Ejecutar sentencia SQL en la segunda sesión abierta.
*/

/* TERCERO: Inserto un nuevo grupo en la primera sesion y compruebo resultado con consulta a la tabla */
INSERT INTO grupotrabajo (cod_gt,nombre,fec_inicio,fec_fin,num_profesores,cod_coordinador) 
VALUES ('GT876543','Redes LoRA en proyectos IoT','2023-03-18','2023-06-30',0,NULL);
SELECT * FROM grupotrabajo;

/* CUARTO: Desbloqueo la tabla grupotrabajo y verifico si la inserción de la segunda sesión se ha realizado */
UNLOCK TABLES;
SELECT * FROM grupotrabajo;