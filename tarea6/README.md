Tarea 6: Programación Avanzada en Bases de Datos (PL/SQL o T-SQL)
Módulo: Bases de Datos (DAW/DAM)
Unidad de Trabajo: UT06. Programación de bases de datos.
Curso Académico: 2022/2023 (Referencia)
📝 Descripción del Proyecto
Este proyecto se centra en la Tarea 6 del módulo de Bases de Datos, cuyo objetivo principal es aplicar conceptos de Programación Procedimental en Bases de Datos. La tarea utiliza la base de datos Actividades deportivas como esquema base y requiere la creación de diversos objetos programáticos (procedimientos, funciones y disparadores) para automatizar la lógica de negocio y garantizar la integridad referencial y la consistencia de los datos.
La base de datos se implementa en un entorno que soporta lenguaje procedimental (típicamente Oracle PL/SQL o similar, basado en el enunciado).
🎯 Objetivos de Aprendizaje
Los principales resultados de aprendizaje trabajados en esta tarea son:
    • RA5: Realizar la programación de procedimientos en la base de datos para automatizar tareas.
    • Dominio de Lenguaje Procedimental: Implementar procedimientos, funciones y disparadores (triggers) usando las estructuras de control (IF, LOOP, etc.) y el manejo de excepciones.
    • Automatización: Crear lógica que se ejecute automáticamente (triggers) o bajo demanda (procedimientos/funciones) para simplificar las aplicaciones externas.
⚙️ Estructura de la Tarea y Objetos Programáticos
La tarea se divide en 4 actividades principales, cada una enfocada en un tipo de objeto programático distinto:
Actividad
Objeto Programático
Propósito y Funcionalidad
Actividad 1
Función (Function)
Calcular y devolver un valor específico (p.ej., el porcentaje o la duración media de una actividad).
Actividad 2
Procedimiento Almacenado (Procedure)
Ejecutar una secuencia de acciones o una tarea de gestión compleja (p.ej., mostrar los participantes de una actividad).
Actividad 3
Procedimiento Almacenado (Procedure)
Manejar la inserción de nuevos datos, incluyendo validaciones y estructuras de control dentro del procedimiento.
Actividad 4
Disparador (Trigger)
Automatizar acciones en respuesta a eventos DML (INSERT, UPDATE, DELETE), como actualizar campos o evitar inserciones no válidas.
🛠️ Tecnologías Utilizadas
    • Sistema de Gestión de Bases de Datos (SGBD): Oracle (o un SGBD que soporte programación procedimental como MySQL con PL/SQL o SQL Server con T-SQL, según se haya instruido).
    • Lenguaje: PL/SQL, T-SQL o el lenguaje procedimental del SGBD utilizado.
    • Base de Datos: Actividades deportivas (esquema predefinido).
📂 Contenido del Repositorio
El repositorio debe incluir:
    1. SQL/: Directorio conteniendo el fichero o ficheros con las sentencias SQL para crear la base de datos, los procedimientos almacenados, las funciones y los disparadores (triggers).
    2. Documentacion/: Archivo (o archivos) con las capturas de pantalla de la ejecución y prueba de todos los objetos programáticos, incluyendo la verificación de los resultados y el manejo de excepciones.
    3. README.md (Este archivo).
Este proyecto demuestra la habilidad para extender las capacidades del SGBD mediante programación, permitiendo una gestión de datos más robusta, eficiente y centralizada.