/* ----------------------------------------------------------------------
TAREA4: REALIZACION DE CONSULTAS			(03/03/2023 al 12/03/2023)
	ALUMNO: Sergio García Butrón
    MODULO: Base de datos (BD)
    CURSO-: Desarrollo de Aplicaciones Web 2022/23 (DAW)
	PROFE-: José Lluyot Sánchez
---------------------------------------------------------------------- */


/* Selecciono la base de datos ara la tarea4 */

USE `instrumentos_musicales`;

/* APAFRTADO A.1 */

SELECT nombre, origen, tipo FROM INSTRUMENTO WHERE origen='Italia';

/* APARTADO A.2 */

SELECT * FROM PRECIO WHERE fecha_actualizacion BETWEEN '20221201' AND NOW();

/* APARTADO A.3 */

SELECT nombre FROM TIENDA WHERE (NOT ubicacion='Sevilla' OR NOT ubicacion='Málaga') AND horario LIKE '%L-D%';

/* APARTADO A.4: */

SELECT nombre FROM MUSICO WHERE (nombre LIKE 'A%' OR nombre LIKE 'M%') AND id_instrumento='GTR';

/* APARTADO B.5 */

SELECT i.nombre FROM INSTRUMENTO i 
INNER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento) 
INNER JOIN MARCA m ON (mi.id_marca=m.id) 
WHERE m.nombre='Gibson';

/* APARTADO B.6 */

SELECT i.nombre, mi.id_modelo, p.precio 
FROM INSTRUMENTO i 
INNER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento) 
INNER JOIN PRECIO p ON (p.id_modelo_instrumento=mi.id_modelo) 
INNER JOIN TIENDA t ON (t.id=p.id_tienda) 
WHERE t.nombre='Musical Store' 
ORDER BY i.nombre;

/* APARTADO B.7 */

SELECT i.nombre, mi.id_modelo, p.precio, t.nombre FROM INSTRUMENTO i
INNER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento)
INNER JOIN MARCA m ON (m.id=mi.id_marca)
INNER JOIN PRECIO p ON (p.id_modelo_instrumento=mi.id_modelo)
INNER JOIN TIENDA t ON (t.id=p.id_tienda)
WHERE i.tipo='Viento' AND p.precio < 350 AND t.ubicacion='Sevilla'
ORDER BY p.precio DESC;

/* APARTADO C.8 */

SELECT DISTINCT i.nombre
FROM INSTRUMENTO i
LEFT OUTER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento)
LEFT OUTER JOIN PRECIO p ON (p.id_modelo_instrumento=mi.id_modelo)
WHERE IFNULL(p.id_modelo_instrumento,'si')='si';

/* APARTADO C.9 */

SELECT 	m.nombre, IFNULL(g.nombre,'#solista#') as 'Grupo'
FROM MUSICO m 
LEFT OUTER JOIN INSTRUMENTO i ON (i.id=m.id_instrumento)
LEFT OUTER JOIN MUSICO_GRUPO mg ON (mg.id_musico=m.id)
LEFT OUTER JOIN GRUPO g ON (g.id=mg.id_grupo)
WHERE i.nombre='Piano';

/* APARTADO C.10 */

SELECT i.nombre, IFNULL(mi.id_modelo,'Sin modelo') as 'Modelo', IFNULL(m.nombre, 'Sin marca') as 'Marca'
FROM MARCA m
RIGHT OUTER JOIN MODELO_INSTRUMENTO mi ON (m.id=mi.id_marca)
RIGHT OUTER JOIN INSTRUMENTO i ON (i.id=mi.id_instrumento)
WHERE i.nombre LIKE '%t%' AND i.tipo='Viento'
ORDER BY 3;

/* APARTADO D.11 */

SELECT ROUND(AVG(p.precio), 2) as 'Precio medio instrumentos cuerda'
FROM INSTRUMENTO i 
INNER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento)
INNER JOIN PRECIO p ON (p.id_modelo_instrumento=mi.id_modelo)
WHERE i.tipo='Cuerda';

/* APARTADO D.12:  */ 

SELECT i.nombre as 'Instrumentos con +2 estilos'
FROM INSTRUMENTO i
INNER JOIN ESTILO_INSTRUMENTO ei ON (i.id=ei.id_instrumento)
GROUP BY i.nombre
HAVING COUNT(ei.id_estilo) > 2;

/* APARTADO D.13 */

SELECT i.nombre, COUNT(mi.id_modelo) as 'Total', MIN(p.precio) as 'Precio mínimo', MAX(p.precio) as 'Precio máximo'
FROM INSTRUMENTO i
INNER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento)
INNER JOIN PRECIO p ON (p.id_modelo_instrumento=mi.id_modelo)
GROUP BY i.nombre
HAVING AVG(p.precio) < 500
ORDER BY 2;

/* APARTADO E.14:  */ 

SELECT i.nombre
FROM INSTRUMENTO i
INNER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento)
INNER JOIN MARCA m ON (m.id=mi.id_marca)
WHERE i.nombre IN (SELECT i.nombre
FROM INSTRUMENTO i
INNER JOIN MODELO_INSTRUMENTO mi ON (i.id=mi.id_instrumento)
GROUP BY mi.id_instrumento
HAVING COUNT(mi.id_marca)=1) AND m.ubicacion='Francia';

/* APARTADO E.15:  */ 

SELECT pm.modelo, pm.minimo, t.nombre as 'tienda'
FROM (SELECT p.id_modelo_instrumento as 'modelo', MIN(p.precio) as 'minimo'
FROM PRECIO p
GROUP BY p.id_modelo_instrumento) pm
INNER JOIN PRECIO p ON (pm.modelo=p.id_modelo_instrumento AND pm.minimo=p.precio)
INNER JOIN TIENDA t ON (t.id=p.id_tienda);

/* APARTADO E.16 */

SELECT t.nombre as 'Tienda', dt.modelos as 'Modelos en venta', pc.id_modelo_instrumento as 'última novedad'
FROM (SELECT ua.tienda as 'tienda', COUNT(ua.modelo) as 'modelos', MIN(ua.ultima_actualizacion) as 'novedad'
FROM (SELECT p.id_tienda as 'tienda', p.id_modelo_instrumento as 'modelo', DATEDIFF(NOW(), p.fecha_actualizacion) as 'ultima_actualizacion'FROM PRECIO p) ua
GROUP BY ua.tienda) dt
INNER JOIN PRECIO pc ON (pc.id_tienda=dt.tienda AND dt.novedad=DATEDIFF(NOW(),pc.fecha_actualizacion))
INNER JOIN TIENDA t ON (t.id=dt.tienda)
ORDER BY 1;