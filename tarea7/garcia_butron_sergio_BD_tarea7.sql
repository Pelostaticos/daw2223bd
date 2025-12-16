/*  TAREA7: USO BASES DE DATOS OBJETO-RELACIONES		(04/05/2023 al 06/05/2023)
	ALUMNO: Sergio García Butrón
    MODULO: Base de datos (BD)
    CURSO-: Desarrollo de Aplicaciones Web 2022/23 (DAW)
	PROFE-: José Lluyot Sánchez

-----------------------------------------------------------------------------------------------------------------------

El propósito de esta tarea es crear los objetos, tablas y bloques de código necesarios para crear la BD objeto-relacional 
que se propone a continuación y probarla mediante la creación de instancias creadas a partir de esos objetos.

Nuestra empresa ha generado un juego online de cartas, en el que cualquier usuario se puede registrar para luchar y competir
con otros usuarios. Para cada jugador se va a registrar información sobre sus partidas, así como el conjunto de cartas que va a usar.
El mazo de cartas de un jugador estará compuesto de un jefe y a lo sumo de tres criaturas que el jugador podrá ir mejorando, 
adquiriendo o vendiendo... Vamos a comenzar a implementar paso a paso nuestra base de datos.

Para comenzar vamos a crear los objetos y tablas siguientes apoyándote en el diagrama que puedes consultar en el apartado 2 
de información de interés.

Debes realizar los siguientes apartados y subapartados en el mismo orden para lo cual deberás incluir en cada uno de ellos:

    El código que se pide PL/SQL o bien las sentencias dependiendo del apartado/subapartado.
    Los comentarios del código o explicación del mismo.
    Al menos una captura que muestre su correcta ejecución.

Consta de cuatro apartados principales divididos cada uno en subapartados.

*/

/* ELIMINACIONES PREVIAS PARA PERMITIR CAMBIOS DE OBJETOS DEPENDIENTES: Añadido perosnal durante pruebas.
-- >>> Borrar tipos de objeto:
DROP TYPE jugador FORCE;
DROP TYPE horda FORCE;
DROP TYPE lista_criaturas FORCE;
DROP TYPE carta_jefe FORCE;
DROP TYPE carta_hechizo FORCE;
DROP TYPE carta_criatura FORCE;
DROP TYPE carta FORCE;
-- >>> Borrar tablas objeto:
DROP TABLE USUARIO;
DROP TABLE MAZO;
DROP TABLE JEFE;
DROP TABLE HECHIZO;
DROP TABLE CRIATURA;
-- >>> Limpiar tablas de objeto:
TRUNCATE TABLE USUARIO;
TRUNCATE TABLE MAZO;
TRUNCATE TABLE JEFE;
TRUNCATE TABLE HECHIZO;
TRUNCATE TABLE CRIATURA;
*/

-- Habilito la salida por pantalla del servidor
SET SERVEROUTPUT ON;


/* ACTIVIDAD-1: Creación de objetos y herencia.
    
    > APARTADO-1.A:  Crea el tipo de objeto “carta” con los siguientes atributos teniendo en cuenta que otros objetos 
    heredarán de éste: ¿Qué atributos precisa este objeto padre?
    
        • id_carta NUMBER,
        • nombre varchar2(50),
        • descripcion varchar2(200),
        • nivel number(2)
*/

-- Declaro el objeto padre de tipo "carta".
CREATE OR REPLACE TYPE carta AS OBJECT (
    -- Declaro los atributos requeridos por el objeto.
    id_carta NUMBER,
    nombre varchar2(50),
    descripcion varchar2(200),
    nivel number(2)
) NOT FINAL;
/


/*  > APARTADO-1.B: Crea, como tipo heredado de “carta”, el tipo de objeto “carta_criatura” con 
    los siguientes atributos:
    
        · fuerza number(2),
        · efensa number(2),
        · vida number(2)

*/

-- Declaro el objeto hijo de tipo “carta_criatura” que hereda de "carta".
CREATE OR REPLACE TYPE carta_criatura UNDER carta (
    -- Declaro los atributos requeridos por el objeto.
    fuerza number(2),
    defensa number(2),
    vida number(2)
);
/

/*  > APARTADO1.C: Crea, como tipo heredado de “carta”, el tipo de objeto “carta_hechizo” con 
    los siguientes atributos:

        · danio_base number(2),
        · tipo varchar2(20)

*/

-- Declaro el objeto hijo de tipo “carta_hechizo” que hereda de "carta".
CREATE OR REPLACE TYPE carta_hechizo UNDER carta (
    danio_base number(2),
    tipo varchar2(20)
);
/

/* ACTIVIDAD2: Creando método para un objeto

    > APARTADO2.A:  Crea, como tipo heredado de “carta”, el tipo de objeto “carta_jefe” con 
    los siguientes atributos:

        · tipo varchar2(20),
        · hechizo OBJ carta_hechizo,
        · vida number(2)

    Y el siguiente método: lanzar_hechizo que devolverá el daño total causado por el hechizo asignado al jefe. Para ello
    hay que tener en cuenta los siguientes puntos:
        + El daño de un hechizo se calcula sumando al daño base del propio hechizo, el daño base por cada nivel del jefe 
        multiplicado por un modificador.
        + El modificador tendrá el valor 1 en el caso de que el tipo del jefe coincida con el tipo de hechizo, en otro caso 
        el modificador es de 0.5
        + El daño realizado es un número entero, por lo que el resultado si es decimal debe ser truncado.

Por ejemplo: Si una carta jefe de nivel 5 de tipo "fuego" tiene un hechizo con un daño base de 4 de tipo "aire", al 
lanzar el hechizo se hará un total de: 4 (daño base) + 5 (nivel) x 4 (daño base) x 0.5 (modificador) = 14 puntos de daño.

*/

-- Declaro el objeto hijo de tipo “carta_jefe” que hereda de "carta".
CREATE OR REPLACE TYPE carta_jefe UNDER carta (
    -- Declaro los atributos especificos del objeto
    tipo varchar2(20),
    hechizo carta_hechizo,
    vida number(2),
    
    -- Declaro los métodos requeridos por el objeto
    MEMBER FUNCTION lanzar_hechizo RETURN NUMBER
);
/

-- Defino el cuerpo del objeto hijo de tipo “carta_jefe” que hereda de "carta".
CREATE OR REPLACE TYPE BODY carta_jefe AS

    -- Defino el método "lanzar_hechizo". que devolverá el daño total causado por el hechizo asignado al jefe
    MEMBER FUNCTION lanzar_hechizo RETURN NUMBER
    IS
        -- Declaro variables local para guardar el calculo del daño del hechizo asignad al jefe
        vDanio_hechizo NUMBER;
              
    BEGIN
    
        -- Defino la lógica deseada para el método
        IF SELF.tipo = SELF.hechizo.tipo THEN
            vDanio_hechizo := SELF.hechizo.danio_base + (SELF.hechizo.danio_base * SELF.nivel);
        ELSE
            vDanio_hechizo := (SELF.hechizo.danio_base + (SELF.hechizo.danio_base * SELF.nivel)) * 0.5;
        END IF;
        
        -- Trunco el valor calculado del daño del hechizo a un número sin decimales
        SELECT TRUNC(vDanio_hechizo, 0) INTO vDanio_hechizo FROM DUAL;
        
        --  Devuelvo el valor de daño del hechizo calculado
        RETURN vDanio_hechizo;
               
    END;
    
END;
/

/* ACTIVIDAD3: Colecciones de objetos y constructor propio.

    > APARTADO-3.A) Crea una colección VARRAY llamada lista_criaturas en la que se puedan almacenar hasta 3 objetos de tipo "carta_criatura.". */

-- Declaro una colección de tipo VARRAY que contenga como máximo tres objetos de tipo "carta_criatura"
CREATE OR REPLACE TYPE lista_criaturas AS VARRAY(3) OF carta_criatura;
/

/*  > APARTADO-3.B) Crea el tipo de objeto "horda" con los siguientes atributos:

        · id_horda NUMBER,
        · nombre varchar2(20),
        · jefe OBJ carta_jefe,
        · criaturas lista_criaturas,
        · nivel number(2)
        
    Y el siguiente método constructor: horda (parámetos_necesarios ) : el valor del atributo nivel se inicializará de forma 
    automática cuando se cree una instancia mediante este constructor en el que se pasan como parámetros necesarios todos los 
    atributos excepto el nivel, que deberá calcularse automáticamente de la siguiente forma:

        · FORMULA: nivel = 1 + parte entera ( (nivel del jefe + suma del nivel de todas sus criaturas)/5 )

    Es otras palabras, el nivel inicial de una horda es 1, y por cada 5 niveles adquiridos por los niveles de sus criaturas
    y jefe, va aumentando un nivel. Por ejemplo: si el nivel del jefe es (5) y la suma de los niveles de sus criaturas es 7 (2+2+3), 
    tendríamos nivel de horda = 1 + entero (( 5 + 7) / 5 ) = 1 + 2 = 3

*/

-- Declaro la cabecera del objeto "horda".
CREATE OR REPLACE TYPE horda AS OBJECT (

    -- Declaro los atributos requeridos por el objeto
    id_horda NUMBER,
    nombre varchar2(20),
    jefe carta_jefe,
    criaturas lista_criaturas,
    nivel number(2),

    -- Declaro un constryctor propio para el objeto
    CONSTRUCTOR FUNCTION horda (id_horda NUMBER, nombre VARCHAR2, jefe carta_jefe, criaturas lista_criaturas) RETURN SELF AS RESULT

);
/

-- Defino el cuerpo del objeto "horda".
CREATE OR REPLACE TYPE BODY horda AS

    CONSTRUCTOR FUNCTION horda (id_horda NUMBER, nombre VARCHAR2, jefe carta_jefe, criaturas lista_criaturas) 
    RETURN SELF AS RESULT
    IS
    
        -- Declaro las variables locales que sean esenciales para el método constructor
        sum_criaturas_jefe NUMBER := 0;
            
    BEGIN
    
        -- Asigno los atributos del objeto pasado por parámetros
        SELF.id_horda := id_horda;
        SELF.nombre := nombre;
        SELF.jefe := jefe;
        SELF.criaturas := criaturas;
        
        -- Calculo el sumatorio de los niveles de las criaturas del jefe
        FOR i IN SELF.criaturas.first .. criaturas.last LOOP                
            sum_criaturas_jefe := sum_criaturas_jefe + SELF.criaturas(i).nivel;
        END LOOP;
        
        -- Asigno los atributos del objeto que son calculados automaticamente
        SELF.nivel := (SELF.jefe.nivel + (sum_criaturas_jefe / 5));
        SELECT CEIL(SELF.nivel) INTO SELF.nivel FROM DUAL;
        
        -- Devuelvo la instancia del objeto
        RETURN;
        
    END;

END;
/

/* ACTIVIDAD5. Atributos referencia de objetos y tablas de objeto:

    > APARTADO-5.A) Crea el tipo de objeto "jugador" con los siguientes atributos:
    
        · id_jugador number,
        · nombre_jugador varchar2(20),
        · partidas_jugadas number,
        · partidas_ganadas number,
        · horda_jugador REF horda (referencia a un objeto) 

*/

-- Declaro la cabecera del objeto de tipo "Jugador".
CREATE OR REPLACE TYPE jugador AS OBJECT (
    id_jugador number,
    nombre_jugador varchar2(20),
    partidas_jugadas number,
    partidas_ganadas number,
    horda_jugador REF horda
);
/

/* APARTADO-5.B) Crea las siguientes tablas de objetos con la sentencia apropiada para cada uno de los subapartados: */
    -- Creo una tabla de objetos llamada CRIATURA de objetos tipo carta_criatura.
    CREATE TABLE CRIATURA OF carta_criatura;
    /

    -- Creo tabla de objetos llamada HECHIZO de objetos tipo carta_hechizo.
    CREATE TABLE HECHIZO OF carta_hechizo;
    /

    -- Creo tabla de objetos llamada JEFE de objetos tipo carta_jefe.
    CREATE TABLE JEFE OF carta_jefe;
    /

    -- Creo tabla llamada MAZO de objetos tipo horda.
    CREATE TABLE MAZO OF horda;
    /

    -- Creo tabla llamada USUARIO de objetos tipo jugador.
    CREATE TABLE USUARIO OF jugador;
    /

/* AQUÍ PONGO UNIFICADO EL BLOQUE DE CÓDIGO PL/SQL PARA LAS ACTTIVIDADES CUATRO Y SEIS  DEL CASO PRÁCTICO */

DECLARE

    /* ACTIVIDAD4: Declaraciones para trabajar con los tipos de objetos creados generando instancias de ellos
        > APARTADO-4.A) Variables para las instancias de los objetos deseados: */
    
    -- Declaro las variables para las instancias de tipo carta_hechizo:
    hechizo1 carta_hechizo;
    hechizo2 carta_hechizo;
    hechizo3 carta_hechizo;
    
    -- Declaro las variables para las instancias de tipo carta_criatura:
    criatura1 carta_criatura;
    criatura2 carta_criatura;
    criatura3 carta_criatura;
    criatura4 carta_criatura;
    criatura5 carta_criatura;
    criatura6 carta_criatura;
    
    -- Declaro las variables para las instancias de tipo carta_jefe:
    jefe1 carta_jefe;
    jefe2 carta_jefe;
    
    -- Declaro las variables para las instancias de tipo lista_criaturas:
    listado1 lista_criaturas;
    listado2 lista_criaturas;
    
    -- Declaro las variables para las instancias de tipo horda:
    horda1 horda;
    horda2 horda;
    
    /* ACTIVIDAD6: Declaraciones para trabajar con los tipos de objetos creados y tablas */
    jefe_horda carta_jefe;
    criaturas_horda lista_criaturas;
    un_jugador jugador;
    horda_jugador REF horda;

BEGIN

    /* ACTIVIDAD4: Sentencias necesarias para crear las instancias de los objetos creados y solicitados en enunciado
        > APARTADO-4.A) Creación de las instancias de los objetos deseados: */
    -- Instancio los tres objetos de tipo carta_hechizo:
    hechizo1 := NEW carta_hechizo(1, 'Bola de Fuego', 'Inflige daño de fuego a un individuo', 1, 5, 'fuego');
    hechizo2 := NEW carta_hechizo(2, 'Hechizo de aire', 'Invoca un torbellino que daña a todos los enemigos', 1,4, 'aire');
    hechizo3 := NEW carta_hechizo(3, 'Flecha de fuego', 'Inflige daño de fuego a un individuo', 2, 4, 'fuego');
    
    -- Instancio los seis objetos de tipo carta_criatura:
    criatura1 := NEW carta_criatura(101, 'Elfo de Fuego', 'Guerrero experto en la batalla', 1, 4, 1, 15);
    criatura2 := NEW carta_criatura(102, 'Dragón Escarlata', 'Feroz depredador de las montañas', 2, 8, 2, 20);
    criatura3 := NEW carta_criatura(103, 'Ogro de las nieves', 'Bestia gigante que ronda por los valles helados', 3, 12, 2, 30);
    criatura4 := NEW carta_criatura(104, 'Hombre Rata', 'Ágil ladrón que merodea por las alcantarillas', 1, 3, 3, 10);
    criatura5 := NEW carta_criatura(105, 'Gárgola de Piedra', 'Guardían de los templos antiguos', 2, 6, 3, 15);
    criatura6 := NEW carta_criatura(106, 'Demonio de la Oscuridad', 'Criatural infernal invocada por magos oscuros', 3, 10, 1, 30);
    
    -- Instancio los dos objetos de tipo carta_jefe:
    jefe1 := NEW carta_jefe(201, 'Jefe Dragón', 'El rey de los dragones', 3, 'fuego', hechizo1, 40);
    jefe2 := NEW carta_jefe(202, 'Dama del Aire', 'Dama del aire', 3, 'aire', hechizo3, 35);
    
    -- Instancio las dos colecciones de tipo lista_criaturas:
    listado1 := NEW lista_criaturas(criatura1, criatura2, criatura3);
    listado2 := NEW lista_criaturas(criatura4, criatura5, criatura6);
    
    -- Instancio los dos objetos de tipo horda:
    horda1 := NEW horda(301, 'Dragones del caos', jefe1, listado1, 2);
    horda2 := NEW horda(302, 'Tornado Final', jefe2, listado2);
    
    /*  > APARTADO-4.B) Mostrar información por consola de los siguientes objetos */
    -- Muestra de un objeto carta_criatura su identificador, nombre y descripción:
    DBMS_OUTPUT.PUT_LINE('La carta_criatura con ID (' || criatura4.id_carta || '): ' || criatura4.nombre
    || ' >>> ' || criatura4.descripcion);
    
    -- Muestra de un objeto carta_hechizo su identificador, nombre y descripción:
    DBMS_OUTPUT.PUT_LINE('La carta_hechizo con ID (' || hechizo2.id_carta || '): ' || hechizo2.nombre
    || ' >>> ' || hechizo2.descripcion);   
    
    -- Muestra de un objeto carta_jefe su nombre, descripción, hechizo y daño:
    DBMS_OUTPUT.PUT_LINE('La carta_jefe: ' || jefe1.nombre || ' >>> ' || jefe1.descripcion);  
    DBMS_OUTPUT.PUT_LINE('  >> Tiene el hechizo' || jefe1.hechizo.nombre || '- Daño: ' || jefe1.lanzar_hechizo());
    
    -- Muestra de un objeto horda su nombre y nivel: Jefe (nombre, nivel y vida) + Criaturas (nombre, nivel, fuerza, vida)
    DBMS_OUTPUT.PUT_LINE('La horda ' || horda2.nombre || ' de nivel ' || horda2.nivel);
    DBMS_OUTPUT.PUT_LINE('  >> Su jefe ' || horda2.jefe.nombre || ' de nivel ' || horda2.jefe.nivel || ' - Vidas: '
    || horda2.jefe.vida);
    DBMS_OUTPUT.PUT_LINE('  >> Criaturas: ¿Cuáles tiene este jefe?');
    FOR i IN horda2.criaturas.first .. horda2.criaturas.last LOOP
        DBMS_OUTPUT.PUT_LINE('      > ' || horda2.criaturas(i).nombre || ' N: ' || horda2.criaturas(i).nivel || ' F: ' || horda2.criaturas(i).fuerza
        || ' V: ' || horda2.criaturas(i).vida);
    END LOOP;
    
    
    /* ACTIVIDAD6: Sentencias para trabajar con los tipos de objetos creados y tablas 
    NOTA: He decidio modificar las instancias de los objetos creados en el apartado 4.A para
    añadir los objetos o sus referencias de los almacenados en las tablas en subapartados que
    así lo solicite su enunciado. Para el resto, uso directamente las instancias de */
    -- APARTADO-6.A) Inserto en la tabla CRIATURA las seis instancias de carta_criatura:
    INSERT INTO CRIATURA VALUES (criatura1);
    INSERT INTO CRIATURA VALUES (criatura2);
    INSERT INTO CRIATURA VALUES (criatura3);
    INSERT INTO CRIATURA VALUES (criatura4);
    INSERT INTO CRIATURA VALUES (criatura5);
    INSERT INTO CRIATURA VALUES (criatura6);
    -- >>> Muestro el contenido de la tabla CRIATURA
    SELECT * FROM CRIATURA;
    
    -- APARTADO-6.B) Inserto en la tabla HECHIZO las tres instancia de carta_hechizo:
    INSERT INTO HECHIZO VALUES (hechizo1);
    INSERT INTO HECHIZO VALUES (hechizo2);
    INSERT INTO HECHIZO VALUES (hechizo3);
    -- >>> Muestro el contenido de la tabla HECHIZO
    SELECT * FROM HECHIZO;
    
    -- APARTADO-6.C) Modifico las instancias de carta_jefe y las añado a la tabla JEFE:
    SELECT VALUE(h) INTO jefe1.hechizo FROM HECHIZO h WHERE h.nombre='Bola de Fuego';
    INSERT INTO JEFE VALUES (jefe1);
    SELECT VALUE(h) INTO jefe2.hechizo FROM HECHIZO h WHERE h.nombre='Hechizo de aire';
    INSERT INTO JEFE VALUES (jefe2);
    -- >>> Muestro el contenido de la tabla JEFE
    SELECT j.*, j.hechizo.nombre FROM JEFE j;

    -- APARTADO-6.D) Modifico una instancia de horda y la añado a la tabla MAZO:
    SELECT VALUE(c) INTO criatura1 FROM CRIATURA c WHERE c.id_carta=101;
    SELECT VALUE(c) INTO criatura2 FROM CRIATURA c WHERE c.id_carta=102;
    SELECT VALUE(c) INTO criatura3 FROM CRIATURA c WHERE c.id_carta=103;
    criaturas_horda := NEW lista_criaturas(criatura1, criatura2, criatura3);
    SELECT VALUE(j) INTO jefe_horda FROM JEFE j WHERE j.nombre='Jefe Dragón';
    horda1.jefe := jefe_horda;
    horda1.criaturas := criaturas_horda;
    INSERT INTO MAZO VALUES (horda1);
    -- >>> Muestro el contenido de la tabla MAZO
    SELECT * FROM MAZO;

    -- APARTADO-6.E) Inserto un jugador a la tabla USUARIO:
    SELECT REF(m) INTO horda_jugador FROM MAZO m WHERE m.nombre='Dragones del caos';
    INSERT INTO USUARIO VALUES(jugador(501, 'Pelostaticos', 100, 85, horda_jugador));  
    -- >>> Muestro el contenido de la tabla USUARIO
    SELECT u.*, u.horda_jugador.nombre FROM USUARIO u;

    -- APARTADO-6.F) Incremento nivel de hechizo de unos jefes en tabla JEFE y muestro resultado por consola:
    DBMS_OUTPUT.PUT_LINE('El nivel anterior del jefe "' || jefe2.nombre || '" es: ' || jefe2.nivel);
    UPDATE JEFE j SET j.nivel = j.nivel + 1 WHERE j.nombre='Dama del Aire';
    SELECT VALUE(j) INTO jefe2 FROM JEFE j WHERE j.nombre='Dama del Aire';
    DBMS_OUTPUT.PUT_LINE('El nuevo nivel del jefe "' || jefe2.nombre || '" es: ' || jefe2.nivel);

END;


/* OBSERVACIONES:

*/
