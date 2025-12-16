/*  TAREA5: PROGRAMACION DE BASES DE DATOS		(12/04/2023 al 15/04/2023)
	ALUMNO: Sergio García Butrón
    MODULO: Base de datos (BD)
    CURSO-: Desarrollo de Aplicaciones Web 2022/23 (DAW)
	PROFE-: José Lluyot Sánchez

-----------------------------------------------------------------------------------------------------------------------

NOTA: El código fuente en este fichero SQL esta desarrollado secuencialmente según se va leyendo el PDF, aunque
para ser práctico a la hora de resulver cada actividad, lo he realizado en un fichero independiente cada una.

ACTIVIDAD1: PROCEDIMIENTO ALMACENADO

Crear un procedimiento llamado actualizar_ocupacion de forma que tenga como parámetros de entrada el identificador 
de una sesión. Este procedimiento debe de actualizar el número de inscritos de una sesión, para ello debes realizar 
las siguientes acciones:

    + Mostrar un mensaje por consola en el caso de que la sesión pasada por parámetros no exista en la base de datos
    + En el caso de que la sesión exista, se deben contar las inscripciones realizadas por los clientes para esa sesión 
    (sólo las que se encuentren en estado "Reservado") y actualizar en la base de datos la ocupación de la sesión.
    + Una vez actualizada la ocupación, se mostrará un mensaje por consola, indicando el nombre de la actividad a la que 
    pertenece dicha sesión, la fecha de la sesión, el código de la sesión, la ocupación actual y la ocupación máxima 
    de la actividad. 
    + El formato de salida: La sesión ACTIVIDAD (FECHA) con código CODIGO tiene una ocupación actual (ACTUAL/MAX)

Nota: La ocupación máxima de cada sesión, viene indicada en la actividad a la que pertenece dicha sesión.

*/

-- Habilito la salida por pantalla del servidor
SET SERVEROUTPUT ON;

-- Defino el procedimiento almacedano solicitado en la actvididad primera

CREATE OR REPLACE PROCEDURE actualizar_ocupacion (vIdSesion sesion.id%TYPE) IS

    -- Defino variable para almacenar el total de inscripciones para la sesión deseada
    vCapActual sesion.ocupacion%TYPE;
    
    -- Defino variable para almacenar la capacidad máxima de la actividad de la sesión deseada
    vCapMaxima actividad.capacidad_max%TYPE;
    
    -- Defino variable para almacenar el nombre de la actividad asociada a la sesión deseada
    vNombreActivdad actividad.nombre%TYPE;
    
    -- Defino variable para almacenar la fecha de la actividad asociada a la sesión deseada
    vFechaActividad sesion.fecha_actividad%TYPE;

BEGIN

    -- Cuento el número de clientes inscritos para la sesión deseada (Cursor implicito)
    SELECT COUNT(*) INTO vCapActual FROM inscripcion 
        WHERE id_sesion=vIdSesion AND estado='Reservado';
    
    -- Obtengo la capacidad máxima de la actividad asociada a la sesión deseada (Cursor implicito)
    SELECT nombre, capacidad_max, fecha_actividad  INTO vNombreActivdad, vCapMaxima, vFechaActividad FROM actividad 
        JOIN sesion ON sesion.id_actividad=actividad.id 
        WHERE sesion.id=vIdSesion;

    -- Actualizo la ocupación para la sesion deseada
    UPDATE sesion SET sesion.ocupacion=vCapActual WHERE sesion.id=vIdSesion;
    
    -- Muestro por consola información sobre la sesión deseada
    DBMS_OUTPUT.PUT_LINE('La sesion ' || vNombreActivdad || ' (' || vFechaActividad || ') con código ' || vIdSesion 
    || ' tiene una ocupación de (' || vCapActual || '/' || vCapMaxima ||')');

EXCEPTION

    -- Controlo excepción del subprograma cuando NO existe el identificador de sesion deseado
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO existe la sesión con código ' || vIdSesion); 
    
    -- Controlo excepción del subprograma cuando sucede un ERROR genérico
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Actualizar ocupación tuvo un error inesperado');

END;
/

-- Realizo la llamada al procedimiento desarrollado para esta primera actividad
BEGIN

    -- 1º) Pruebo el procedimiento con un identificador de sesión existente
    actualizar_ocupacion(1);

    -- 2º) Pruebo el procedimiento con un identificador de sesión NO existente
    actualizar_ocupacion(100);

END;


/* ACTIVIDAD2: FUNCIÓN ALMACENADA

Crear una función llamada num_sesiones donde a partir de un identificador de una
actividad y un rango de fechas, devuelva el número de sesiones existentes de 
dicha actividad comprendidas entre la fecha de inicio y de fin. Parámetros de 
entrada a la función

    • id_actividad
    • fecha_inicio
    • fecha_fin

Hay que tener en cuenta que los parámetros fecha_inicio y fecha_fin son 
opcionales y que el valor por defecto de ambos es la fecha actual del sistema.

*/

-- defino la función almacenada solicitada
CREATE OR REPLACE FUNCTION num_sesiones (vIdActividad sesion.id_actividad%TYPE,
vFecha_Inicio DATE := SYSDATE, vFecha_Fin DATE := SYSDATE) 
RETURN VARCHAR2 IS

    -- Defino la variable para almacenar el total de sesiones de actividad deseada
    vTotal_Sesiones NUMBER;

BEGIN

    -- Cuento el número total de sesiones para la actividad deseada (Cursor implicito)
    SELECT COUNT(*) INTO vTotal_Sesiones FROM sesion 
        WHERE id_actividad=vIdActividad AND fecha_actividad 
        BETWEEN vFecha_Inicio AND vFecha_Fin;

    -- Devuelvo el valor de la funcion según el rango de fecha introducido
    IF vFecha_Inicio=SYSDATE OR vFecha_Fin=SYSDATE THEN
        RETURN ('La función devuelve ' || vTotal_Sesiones || ' (teniendo en cuenta que la fecha del sistema al realizar la prueba ha sido el ' || SYSDATE || ')');
    ELSE
        RETURN ('La funcion devuelve ' || vTotal_Sesiones || ' sesiones comprendidas entre esas fechas');
    END IF;

END;
/

-- Realizo la llamada de la funcion desarrollada para verificar su funcionamiento
BEGIN

    -- 1º) Pruebo la funcion dandole una fecha de inicio y fin para el rango de actividades
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI',TO_DATE('12/04/2023','DD/MM/YYYY'), TO_DATE('12/05/2023','DD/MM/YYYY')));

    -- 2º) Pruebo la función dandole sólo la fecha de inicio para el rango de actividades
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI',TO_DATE('12/01/2023','DD/MM/YYYY')));
    
    -- 3º) Pruebo la función dandole sólo el identificador de actividad
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI'));
    
    -- 4º) Pruebo la función dandole como rango de fecha el mismo día
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI',TO_DATE('12/04/2023','DD/MM/YYYY'), TO_DATE('12/04/2023','DD/MM/YYYY')));
    
    -- 5º) Pruebo la función dandole como rango de fecha el mismo dia con franja horaria
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI',TO_DATE('12/04/2023 00:00:00','DD/MM/YYYY HH24:MI:SS'), TO_DATE('12/04/2023 23:59:59','DD/MM/YYYY HH24:MI:SS')));    

    -- 6º) Pruebo la función dandole una fecha de inicio superior a la fecha de fin en rango de actividad
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI',TO_DATE('12/05/2023','DD/MM/YYYY'), TO_DATE('12/04/2023','DD/MM/YYYY')));

END;

/* OBSERVACIONES A LA ACTIVIDAD2: 

El resultado en las pruebas primera y segunda devuelven los solicitado en el enunciado del ejercicio

El resultado de la tercera prueba puede parecer correcto porque para el día probado (13/04/2023) no hay ninguna
actividad dada de alta, pero si observamos la cuarta prueba da incorrecto porque para el mismo dia de busqueda
dice que no hay actividades programadas, cuando el día de prueba es el mismo que para la primera prueba y en dicho
caso encontró dos sesiones
    |-> MOTIVO: El enunciado dice que fecha inicio y fin pueder ser opcionales y ser fecha del sistema (iguales)
    \-> SOLUCION: Habría que añadir a la fecha dada la franja horaria para que pueda encontrar dichas sesiones
    
La prueba quinta muestra la solución planteada al problema descrito en el párrafo anterior

La prueba sexta muestra un error NO contemplado en la función, una fecha de inicio no puede ser superior 
a la fecha fin para el rango de actividad deseado
    \-> PROPUESTA: Controlarlo con una excepción o un mensaje de texto por consola que advierta del caso

MI PROPUESTA DE MEJORA DEL CÓDIGO ACTIVIDAD2:

*/

-- defino la función almacenada solicitada
CREATE OR REPLACE FUNCTION num_sesiones (vIdActividad sesion.id_actividad%TYPE,
vRango_Inicio VARCHAR2 := NULL, 
vRango_Fin VARCHAR2 := NULL, vFormato VARCHAR2 := 'DD/MM/YYYY') 
RETURN VARCHAR2 IS

    -- Defino la variable para almacenar la fecha de inicio del rango
    vFecha_Inicio DATE;
    
    -- Defino la variable para almacenar la fecha de fin del rango
    vFecha_Fin DATE;
    
    -- Defino la variable para almacenar el total de sesiones de actividad deseada
    vTotal_Sesiones NUMBER;

BEGIN

    -- Asigno las fechas de inicio y fin del rango de actividad
    SELECT DECODE(vRango_Inicio, NULL, SYSDATE, TO_DATE(vRango_Inicio || ' 00:00:00',vFormato || 'HH24:MI:SS')) 
        INTO vFecha_Inicio FROM DUAL;
    SELECT DECODE(vRango_Fin, NULL, SYSDATE, TO_DATE(vRango_Fin || ' 23:59:59',vFormato || 'HH24:MI:SS')) 
        INTO vFecha_Fin FROM DUAL;

    -- Cuento el número total de sesiones para la actividad deseada (Cursor implicito)
    SELECT COUNT(*) INTO vTotal_Sesiones FROM sesion 
        WHERE id_actividad=vIdActividad AND fecha_actividad 
        BETWEEN vFecha_Inicio AND vFecha_Fin;

    -- Devuelvo el valor de la funcion según el rango de fecha introducido:
    --  >> Cuando fecha de inicio es inferior al fin muestro el mensaje por pantalla
    IF (vFecha_Fin - vFecha_Inicio) >= 0 THEN
        -- Cuando la fecha de inicio o fin coincide con la de sistema
        IF vFecha_Inicio=SYSDATE OR vFecha_Fin=SYSDATE THEN
            RETURN ('La función devuelve ' || vTotal_Sesiones || ' (teniendo en cuenta que la fecha del sistema al realizar la prueba ha sido el ' || SYSDATE || ')');
        -- Cuando la fecha de inicio o fin NO coincide con la de sistema
        ELSE
            RETURN ('La funcion devuelve ' || vTotal_Sesiones || ' sesiones comprendidas entre esas fechas');
        END IF;
    -- >> Cuando fecha de inicio es superor a la fecha de fin muestro mensaje error por pantalla
    ELSE
        RETURN 'La fecha de inicio NO puede ser superior a la fecha de fin';
    END IF;
    
END;
/


-- Habilito la salida por pantalla del servidor
SET SERVEROUTPUT ON;

-- Realizo la llamada de la funcion desarrollada para verificar su funcionamiento
BEGIN

    -- 1º) Pruebo la funcion dandole una fecha de inicio y fin para el rango de actividades
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI','12/04/2023', '12/05/2023'));

    -- 2º) Pruebo la función dandole sólo la fecha de inicio para el rango de actividades
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI','12/01/2023'));
    
    -- 3º) Pruebo la función dandole sólo el identificador de actividad
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI'));
    
    -- 4º) Pruebo la función dandole como rango de fecha el mismo día
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI','12/04/2023', '12/04/2023'));
    
    -- 5º) Pruebo la función dandole como rango de fecha el mismo dia con formato anglosajon
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI','04/12/2023', '04/12/2023', 'MM/DD/YYYY'));

    -- 6º) Pruebo la función dandole una fecha de inicio superior a la fecha de fin en rango de actividad
    DBMS_OUTPUT.PUT_LINE(num_sesiones('SPI','12/05/2023', '12/04/2023'));

END;

/* OBSERVACIONES A LAS MEJORAS EN ACTIVIDAD2:

El resultado en las pruebas primera y segunda devuelven los solicitado en el enunciado del ejercicio

El resultado de la tercera prueba YA es correcto porque para el día probado (13/04/2023) no hay ninguna
actividad dada de alta, además la fecha introducida por defecto incluye franja horaria.

La prueba cuarta muestra como para un mismo día que sabemos que hay sesiones, la función devuelve resultado comparada
con la codificación del método anterior, que decía existir cero sesiones.
    
La prueba quinta muestra la solución cuando la fecha introducida no sigue el formato español

La prueba sexta muestra el error NO cuando en la función, una fecha de inicio es superior a fecha de fin

*/


/* ACTIVIDAD3: PROCEDIMIENTO ALMACENADO CON CURSORES

Crear un procedimiento llamado info_cliente de forma que pasándole como parámetros 
de entrada: El dni de un cliente, no el identificador del cliente. El procedimiento 
debe realizar una serie de comprobaciones y mostrar por pantalla la siguiente 
información: El nombre y apellidos del cliente a través del siguiente 
mensaje: 'El cliente "nombre apellidos" ha realizado las siguientes actividades. 

En el caso de que el cliente no exista, se debe indicar con otro mensaje a través de la consola.

Además se mostrará por pantalla un listado de las actividades que ha realizado 
el cliente, la fecha de las actividades y el coste de cada actividad. Para ello 
hay que tener en cuenta:

    • Sólo se mostrarán las actividades del cliente con el estado "Reservado"
    • El listado ordenado por fecha de actividad DESCENDENTEMENTE
    • La fecha de la actividad se mostrará con el formato "día/mes/año hora:minutos"
    • El coste se mostrará con el símbolo del €
    • Hacer uso de las funciones LPAD y RPAD para mostrar los datos correctamente 
    posicionados tal y como se muestran en las siguientes imágenes

Finalmente el procedimiento mostrará el coste total del cliente. El coste total 
del cliente se calcula sumando todas las actividades del cliente en estado "Reservado". 

Para la resolución de esta actividad tienes que hacer uso de cursores.

*/

-- Defino el procedimiento almacenado solicitado con uso de cursores
CREATE OR REPLACE PROCEDURE info_cliente (vDni cliente.dni%TYPE) IS

    -- Defino variable para validación del DNI y su excepción
    vDniValidar NUMBER;
    error_dni EXCEPTION;
    
    -- Defino las variables para almacenar el nombre completo del cliente
    vCliNombre cliente.nombre%TYPE;
    vCliApellidos cliente.apellidos%TYPE;
    
    -- Defino un cursor para acceder a todas las actividades del cliente
    CURSOR cActividades IS SELECT actividad.nombre, fecha_actividad, coste
        FROM cliente 
        JOIN inscripcion ON inscripcion.id_cliente=cliente.id
        JOIN sesion ON sesion.id=inscripcion.id_sesion
        JOIN actividad ON sesion.id_actividad=actividad.id
        WHERE cliente.dni=vDni AND inscripcion.estado='Reservado'
        ORDER BY sesion.fecha_actividad DESC;

    -- Defino las variables para almacenar datos de las actividades
    vActividad actividad.nombre%TYPE;
    vFecha_Actividad sesion.fecha_actividad%TYPE;
    vCoste_Actividad actividad.coste%TYPE;
    
    -- Defino variable para el encabezado y listado de actividades
    vListado VARCHAR2(70);

    -- Defino variable para almacenar el coste total del cliente
    vCoste_total NUMBER := 0.00;

BEGIN

    -- Compruebo que el DNI del cliente deseado es válido
    SELECT REGEXP_INSTR(vDni, '^[0-9]{8}[A-Z]$') INTO vDniValidar FROM DUAL;
    
    -- Realizo las acciones del procedimiento según válidez del DNI deseado
    IF vDniValidar <= 0 THEN
    
        -- Desencadeno la excepción por DNI inválido
        RAISE error_dni;
    
    ELSE
    
        -- Obtengo el nombre completo del cliente deseado
        SELECT nombre, apellidos INTO vCliNombre, vCliApellidos
            FROM cliente WHERE dni=vDni;
        
        -- Muestro el nombre completo del cliente deseado
        DBMS_OUTPUT.PUT_LINE('El cliente "' || vCliNombre || ' ' || vCliApellidos || '" ha realizado las siguiente actividaes:');
        
        -- Abro el cursor con las actividades del cliente deseado
        OPEN cActividades;
        
        -- Muestro el encabezado del listado de actividades del cliente deseado
        DBMS_OUTPUT.PUT_LINE('');
        SELECT RPAD('Actividad',20) || RPAD('Fecha actividad',25) || RPAD('Coste',10) INTO vListado FROM DUAL;
        DBMS_OUTPUT.PUT_LINE(vListado);
        SELECT RPAD('-', 55,'-') INTO vListado FROM DUAL;
        DBMS_OUTPUT.PUT_LINE(vListado);
              
        -- Muestro el listado de actividades del cliente deseado
        LOOP

            -- Intento recuperar del cursor una fila de datos de la actividad
            FETCH cActividades INTO vActividad, vFecha_Actividad, vCoste_Actividad;

            -- Genero fila con los datos de la actividad del cliente deseado
            SELECT RPAD(vActividad,20) || RPAD(TO_CHAR(vFecha_Actividad,'DD/MM/YYYY HH24:MI:SS'),25) 
                || RPAD(TO_CHAR(vCoste_Actividad,'fmU999D00'),10) INTO vListado FROM DUAL;
                                
            -- Salgo de bucle si NO hay datos que mostrar
            IF cActividades%NOTFOUND AND cActividades%ROWCOUNT=0 THEN
                DBMS_OUTPUT.PUT_LINE('Sin actividades reservadas.');
                EXIT;
            -- Salgo del bucle cuando NO se encontró más datos en el cursor
            ELSIF cActividades%NOTFOUND THEN
                EXIT;
            ELSE
                -- Muestro la fila con los datos de la actividad del cliente deseado
                DBMS_OUTPUT.PUT_LINE(vListado);
                -- Calculo el coste total de las actividades del cliente
                vCoste_total:=vCoste_total+vCoste_Actividad;
            END IF;

        END LOOP;
        
        -- Muestro el coste total del cliente deseado
        SELECT RPAD('-', 55,'-') INTO vListado FROM DUAL;
        DBMS_OUTPUT.PUT_LINE(vListado);
        DBMS_OUTPUT.PUT_LINE('Total: ' || TO_CHAR(vCoste_total, 'fmU990D00') || '€');
        DBMS_OUTPUT.PUT_LINE('');
        
        -- Cierro el cursor con las actividades del cliente deseado
        CLOSE cActividades;
        
    END IF;
    
EXCEPTION

    -- Controlo la excepcióncuando el DNI del cliente es inválido
    WHEN error_dni THEN
        DBMS_OUTPUT.PUT_LINE('Por favor, introduzca un DNI válido');
        
    -- Controlo la excepción cuando el DNI del cliente NO existe
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe un cliente con el dni ' || vDni);
    
    -- Controlo cualquier otro error inesperado del subprograma
    --WHEN OTHERS THEN
      --  DBMS_OUTPUT.PUT_LINE(SQLERRM || ' (' || SQLCODE || ')');

END;
/

-- Realizo llamadas a la función desarrollada para comprobar su funcionamiento
BEGIN

    -- 1º) Pruebo el procedimiento para un DNI cliente con datos completos
    info_cliente('50984975R');
    
    -- 2º) Pruebo el procedimiento para un DNI cliente sin actividades
    info_cliente('06349006V');
    
    -- 3º) Pruebo el procedimiento para un DNI cliente que NO existe
    info_cliente('12345678A');
    
    -- 4º) Pruebo el procedimiento para un DNI cliente incorrecto
    info_cliente('asdafaesfa35425335543');
    
END;

/* ACTIVIDAD4: DISPARADOR O TRIGGER

Crear un trigger o disparador llamado ​ insertar_inscripcion de forma que cuando 
se vaya a insertar​ una inscripción de un cliente en una sesión​, antes de grabarlo 
se hagan una serie de acciones que se detallan a continuación:

    • Comprobaremos que la inscripción que se va a insertar en estado "Reservado"
    • Comprobaremos que el cliente no estaba inscrito previamente en dicha sesión 
    o bien tenía alguna inscripción en estado "Cancelado"

Si se cumplen, se debe permitir la inscripción del cliente en la sesión, pero hay 
que tener en cuenta que si tenía una inscripción en estado "Cancelada", se debe 
eliminar previamente. Y si no se cumplen ambas condiciones no se debe insertar el 
registro. Debes lanzar diferentes excepciones con mensajes que detallen qué 
condiciones incumple para no poder insertar el registro.

*/

-- Defino el disparador solicitado
CREATE OR REPLACE TRIGGER insertar_inscripcion BEFORE INSERT ON inscripcion
FOR EACH ROW
DECLARE

    -- Defino variable para almacenar sesiones previas canceladas
    vSesion_Cancelada NUMBER;
    
    -- Defino variable para almacenar sesiones previas reservadas
    vSesion_Reservada NUMBER;

BEGIN

    -- Obtengo si el cliente tiene cancelada su inscripción para la sesion
    SELECT COUNT(*) INTO vSesion_Cancelada FROM inscripcion
        WHERE id_cliente=:NEW.id_cliente AND id_sesion=:NEW.id_sesion AND estado='Cancelado';
        
    -- Obtengo si el cliente tiene cancelada su inscripción para la sesion
    SELECT COUNT(*) INTO vSesion_Reservada FROM inscripcion
        WHERE id_cliente=:NEW.id_cliente AND id_sesion=:NEW.id_sesion AND estado='Reservado';

    -- Compruebo si el cliente tiene cancelada su inscripción para la sesion
    IF vSesion_Cancelada > 0 THEN
        -- Elimino la reserva anterior cancelada por el cliente
        DELETE FROM inscripcion
            WHERE id_cliente=:NEW.id_cliente AND id_sesion=:NEW.id_sesion;
        
        -- Muestro por pantalla el mensaje indicando que existe reserva previa cancelada y que se eliminará antes
        DBMS_OUTPUT.PUT_LINE('El cliente tenía una reserva en estado Cancelado. Se elimina la reserva anterior. Inscripción realizada.');
        
    ELSIF vSesion_Reservada > 0 THEN
    
        -- Lanzo una excepción de aplicación indicando que ya tiene el cliente una sesion reservada previa
        RAISE_APPLICATION_ERROR(-20000, 'El cliente ya tenía una reserva realizada para esa actividad"');
        
    ELSIF :NEW.estado = 'Cancelado' THEN
    
        -- Lanzo una excepción de la aplicación indicando que la nueva inscripción se inscribe como cancelado
        RAISE_APPLICATION_ERROR(-20001, 'La inscripción a insertar no se ha llevado a cabo ya que no está en estado Reservado');
    
    ELSE
    
        -- Muestro por pantalla el mensaje indicando que la inserción cumple todos los requisitos
        DBMS_OUTPUT.PUT_LINE('Inscripción insertada');
    
    END IF;
    
END;
/

-- Realizo varias pruebas de inserción para probar el disparador desarrollado
BEGIN

    -- 1º) Pruebo inserción nueva con su estado en "Cancelado"
    INSERT INTO inscripcion VALUES(46, 3, 7, SYSDATE,'Cancelado');

    -- 2º) Pruebo inserción nueva que cumple todos los requisitos
    INSERT INTO inscripcion VALUES(47, 3, 7, SYSDATE, 'Reservado');
    
    -- 3º) Pruebo inserción nueva cuando el cliente esta ya inscrito
    INSERT INTO inscripcion VALUES(48, 3, 7, SYSDATE, 'Reservado');
    
    -- 4º) Pruebo inserción nueva cuando ya existía previamente como cancelada
    INSERT INTO inscripcion VALUES(47, 1, 7, SYSDATE, 'Reservado');
    
END;

/* OBSERVACIONES A LA ACTIVIDAD4:

Durante las pruebas he comprobado que la inserción de test segunda y cuarta comparten el mismo identificador 
de inscripcion. Esto hacia lanzar una excepción de tipo DUP_VAL_ON_INDEX (Indice único violado) el disparador
realizaba la eliminación de la inscripción previa en estado cancelado, pero al surgir dicha excepción la
inserción de la nueva indicada en la cuarta inserción de test, no se producía dando al desarrollo inicial

Dado que desconozco si esa duplicidad comentada es un error tipográfico o no, he decidido tomarlo en consideracion
y añadir al código del disparador unas imnstrucciones que comprueba si el identificador nuevo está duplicado, y en 
caso afirmativo proceder automaticamente a actualizar el valor por el correcto.

*/

CREATE OR REPLACE TRIGGER insertar_inscripcion BEFORE INSERT ON inscripcion
FOR EACH ROW
DECLARE

    -- Defino variable para comprobar identificador inscripcion duplicado
    vId_Inscripcion NUMBER;

    -- Defino variable para almacenar sesiones previas canceladas
    vSesion_Cancelada NUMBER;
    
    -- Defino variable para almacenar sesiones previas reservadas
    vSesion_Reservada NUMBER;

BEGIN

    -- Compruebo si el nuevo identificador de inscripción está duplicado
    SELECT COUNT(*) INTO vId_Inscripcion FROM inscripcion WHERE id=:NEW.id;
    IF vId_Inscripcion > 0 THEN
    
        -- Obtengo el identificador de inscripción correcto
        SELECT MAX(id)+1 INTO vId_Inscripcion FROM inscripcion;
    
        -- Muestro mensaje indicando que el indetificador de inscripción de ha actualizado
        DBMS_OUTPUT.PUT_LINE('El identificador de inscripción ' || :NEW.id || ' está duplicado y se ha cambiado al ' || vId_Inscripcion);
    
        -- Actualizo el valor del identificador de inscrición por el correcto
        :NEW.id := vId_Inscripcion;
    
    END IF;

    -- Obtengo si el cliente tiene cancelada su inscripción para la sesion
    SELECT COUNT(*) INTO vSesion_Cancelada FROM inscripcion
        WHERE id_cliente=:NEW.id_cliente AND id_sesion=:NEW.id_sesion AND estado='Cancelado';
        
    -- Obtengo si el cliente tiene cancelada su inscripción para la sesion
    SELECT COUNT(*) INTO vSesion_Reservada FROM inscripcion
        WHERE id_cliente=:NEW.id_cliente AND id_sesion=:NEW.id_sesion AND estado='Reservado';

    -- Compruebo si el cliente tiene cancelada su inscripción para la sesion
    IF vSesion_Cancelada > 0 THEN
        -- Elimino la reserva anterior cancelada por el cliente
        DELETE FROM inscripcion
            WHERE id_cliente=:NEW.id_cliente AND id_sesion=:NEW.id_sesion;
        
        -- Muestro por pantalla el mensaje indicando que existe reserva previa cancelada y que se eliminará antes
        DBMS_OUTPUT.PUT_LINE('El cliente tenía una reserva en estado Cancelado. Se elimina la reserva anterior. Inscripción realizada.');
        
    ELSIF vSesion_Reservada > 0 THEN
    
        -- Lanzo una excepción de aplicación indicando que ya tiene el cliente una sesion reservada previa
        RAISE_APPLICATION_ERROR(-20000, 'El cliente ya tenía una reserva realizada para esa actividad"');
        
    ELSIF :NEW.estado = 'Cancelado' THEN
    
        -- Lanzo una excepción de la aplicación indicando que la nueva inscripción se inscribe como cancelado
        RAISE_APPLICATION_ERROR(-20001, 'La inscripción a insertar no se ha llevado a cabo ya que no está en estado Reservado');
    
    ELSE
    
        -- Muestro por pantalla el mensaje indicando que la inserción cumple todos los requisitos
        DBMS_OUTPUT.PUT_LINE('Inscripción insertada');
    
    END IF;
    
END;
/

-- Realizo varias pruebas de inserción para probar el disparador desarrollado
BEGIN

    -- 1º) Pruebo inserción nueva con su estado en "Cancelado"
    INSERT INTO inscripcion VALUES(46, 3, 7, SYSDATE,'Cancelado');

    -- 2º) Pruebo inserción nueva que cumple todos los requisitos
    INSERT INTO inscripcion VALUES(47, 3, 7, SYSDATE, 'Reservado');
    
    -- 3º) Pruebo inserción nueva cuando el cliente esta ya inscrito
    INSERT INTO inscripcion VALUES(48, 3, 7, SYSDATE, 'Reservado');
    
    -- 4º) Pruebo inserción nueva cuando ya existía previamente como cancelada
    INSERT INTO inscripcion VALUES(47, 1, 7, SYSDATE, 'Reservado');
    
END;
