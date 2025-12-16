Tarea 5: Manipulación de Datos con SQL (DML)
Módulo: Bases de Datos (DAW/DAM)
Unidad de Trabajo: UT05. Tratamiento de datos.
Curso Académico: 2022/2023 (Referencia)
📝 Descripción del Proyecto
Este proyecto corresponde a la Tarea 5 del módulo de Bases de Datos y tiene como objetivo principal consolidar el uso del Lenguaje de Manipulación de Datos (DML) de SQL. La tarea se realiza sobre una base de datos ya existente (grupos_trabajo.sql) y se centra en las operaciones CRUD (Create, Read, Update, Delete) para gestionar el contenido de las tablas.
Se exploran las restricciones de integridad y la consistencia de los datos al intentar realizar operaciones que podrían violar las reglas definidas en el esquema.
🎯 Objetivos de Aprendizaje
Los principales resultados de aprendizaje trabajados en esta tarea son:
    • RA4: Realizar operaciones de manipulación de datos con el lenguaje SQL, garantizando la integridad.
    • Dominio de DML: Reforzar el conocimiento y la aplicación de las sentencias INSERT, UPDATE, y DELETE.
    • Integridad y Bloqueo: Identificar los efectos de las políticas de bloqueo y las medidas para mantener la consistencia de la información.
⚙️ Estructura de la Tarea y Operaciones Clave
La tarea se divide en varias actividades que cubren el ciclo completo de manipulación de datos:
Actividad
Tema Principal
Sentencias SQL Involucradas
Enfoque
Punto de Control 1
Inserción Visual y Restricciones
INSERT (Implícito/Manual)
Inserción de datos a través de la herramienta (Workbench) e identificación de fallos de integridad.
Punto de Control 2
Inserción Programada
INSERT INTO
Inserción masiva de registros utilizando un guion SQL.
Punto de Control 3
Actualización de Datos
UPDATE
Modificación de registros existentes con criterios específicos (WHERE).
Punto de Control 4
Borrado de Registros
DELETE FROM
Eliminación de registros, prestando especial atención a las dependencias de clave foránea.
Punto de Control 5
Sentencias de Bloqueo
LOCK TABLES, UNLOCK TABLES
Aplicación de sentencias para gestión de concurrencia y análisis de sus efectos.
🛠️ Tecnologías Utilizadas
    • Sistema de Gestión de Bases de Datos (SGBD): MySQL.
    • Herramienta: MySQL Workbench (para operaciones visuales y de scripting).
    • Lenguaje: SQL (DML).
📂 Contenido del Repositorio
El repositorio incluye:
    1. SQL/: Directorio que contiene el fichero o ficheros con todas las sentencias SQL (INSERT, UPDATE, DELETE, LOCK) realizadas durante las actividades, agrupadas o secuenciadas para su correcta ejecución.
    2. Documentacion/: Archivo (o archivos) con las capturas de pantalla que documentan la ejecución exitosa de las sentencias, la verificación de los resultados y el análisis de los errores de integridad/bloqueo, tal como se requiere en el enunciado.
    3. README.md (Este archivo).
Este proyecto demuestra la habilidad para manejar y mantener la consistencia de los datos en un entorno relacional, aplicando sentencias DML de forma precisa y controlada.