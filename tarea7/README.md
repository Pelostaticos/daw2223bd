Tarea 7: Implementación de Bases de Datos Objeto-Relacionales (BDOR)
Módulo: Bases de Datos (DAW/DAM)
Unidad de Trabajo: UT07. Uso de Bases de Datos Objeto-Relacionales.
Curso Académico: 2022/2023 (Referencia)
📝 Descripción del Proyecto
Este proyecto corresponde a la Tarea 7 del módulo de Bases de Datos, y se centra en la aplicación de los conceptos de las Bases de Datos Objeto-Relacionales (BDOR) en un entorno de SGBD que soporta estas características (generalmente Oracle).
La tarea consiste en modelar un juego de cartas, representando elementos como cartas, mazos, hordas y jugadores como tipos de objetos dentro de la base de datos. Esto implica la creación de colecciones (VARRAY y tablas anidadas) y el uso de bloques PL/SQL para manipular estos objetos y sus relaciones.
🎯 Objetivos de Aprendizaje
Los principales resultados de aprendizaje trabajados en esta tarea son:
    • RA7: Utilizar bases de datos objeto-relacionales, analizando sus características y aplicando técnicas para mantener la persistencia de la información.
    • Modelado BDOR: Diseñar y crear tipos de datos complejos (objetos con atributos y métodos).
    • Colecciones y Tipos: Implementar estructuras de datos colección (Arrays de tamaño variable o Tablas Anidadas) para manejar atributos multivaluados.
    • Manipulación de Objetos: Realizar operaciones DML (INSERT, UPDATE, DELETE) y consultas sobre tablas de objetos y tablas de columnas objeto.
⚙️ Estructura de la Tarea y Elementos BDOR Creados
La tarea se desarrolla en torno a la creación de los siguientes elementos fundamentales de la BDOR, siguiendo un flujo de trabajo procedimental con bloques PL/SQL:
Tipo de Elemento
Objeto Creado (Ejemplos)
Propósito
Tipos de Objeto
Criatura, Horda, Mazo, Usuario
Definición de las estructuras de datos complejas del universo del discurso.
Tipos de Colección
VARRAY o Tablas Anidadas
Permitir que los objetos tengan atributos multivaluados (por ejemplo, una lista de cartas en un mazo).
Tablas de Objetos
MAZO_TABLA, USUARIO_TABLA
Creación de tablas donde cada fila es un objeto completo de un tipo definido.
Bloques PL/SQL
Bloques anónimos para DML
Inserción y modificación de objetos complejos, a menudo utilizando subconsultas SQL para obtener los datos necesarios antes de la inserción.
🛠️ Tecnologías Utilizadas
    • Sistema de Gestión de Bases de Datos (SGBD): Oracle Database Express Edition (11g o superior).
    • Herramienta: SQL Developer (o herramienta similar para ejecutar sentencias y bloques PL/SQL).
    • Lenguajes: SQL y PL/SQL.
📂 Contenido del Repositorio
El repositorio debe incluir:
    1. SQL/: Directorio conteniendo el fichero o ficheros con las sentencias SQL (DDL) para la creación de todos los tipos de objetos, tipos de colección y tablas de objetos, así como los bloques PL/SQL para la manipulación e inserción de los datos.
    2. Documentacion/: Archivo (o archivos) con las capturas de pantalla que demuestran la creación de los tipos y las tablas, y la ejecución exitosa de los bloques PL/SQL con los resultados de las consultas de verificación.
    3. README.md (Este archivo).
Este proyecto demuestra la comprensión y aplicación de los principios de la Orientación a Objetos en un entorno de Base de Datos Relacional, utilizando las capacidades procedimentales de Oracle.