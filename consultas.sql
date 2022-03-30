-- Obra activa
SELECT titulo FROM obra WHERE estado = 1;

--formato fecha
alter session set nls_date_format = 'dd/MON/yyyy hh24:mi:ss';

-- formatos de salida
set linesize 120;
column "nombre_columna" format a15;


SELECT R.nombre 
FROM empleado E, PersonalObra PO, rol R, unidad U
WHERE E.idempleado = PO.idempleado and
      U.idunidad = E.idunidad and
      E.idunidad = PO.idpersonalobra and
      R.idrol = PO.idrol and
      E.cedula = 98752059 and
      R.nombre like 'Docente%'; 
------------------------------------------------------------------------------------------
-------------------------- MODULO ASISTENCIA ---------------------------------------------
------------------------------------------------------------------------------------------

-- Estudiantes que pertenecen a la obra activa

SELECT  O.titulo, E.apellido estudiant, PE.idobra 
FROM estudiante E, PersonajeEstudiante PE, personaje P, obra O
WHERE E.idestudiante = PE.idestudiante and
      P.idpersonaje = PE.idpersonaje and
      P.idobra = PE.idobra and
      O.idobra = PE.idobra and
      (PE.idobra) = (SELECT idobra 
                    FROM obra
                    WHERE estado like 1);

        --Estudiantes que pertenecen a la obra activa con listado para aplicacion
    SELECT E.idestudiante, E.idunidad, TO_CHAR(E.fechainscripcion, 'DD/MM/YYYY') insc, TO_CHAR(E.fechanacimiento, 'DD/MM/YYYY') nac, E.correo, E.nombre, E.apellido 
    FROM estudiante E, PersonajeEstudiante PE, personaje P, obra O
    WHERE E.idestudiante = PE.idestudiante and
        P.idpersonaje = PE.idpersonaje and
        P.idobra = PE.idobra and
        O.idobra = PE.idobra and
        (PE.idobra) = (SELECT idobra 
                        FROM obra
                        WHERE estado like 1);


-- Registro de asistencia de un estudiante con su idestudiante en la tabla AsistenciaEstudiante

    --obtener el idhorafecha de la fecha actual
    SELECT idhorafecha FROM horafecha where TO_CHAR(fecha, 'DD/MM/YYYY') like '31/03/2022';

    --obtener calendario con un idhorafecha
    SELECT C.idcalendario 
    FROM calendario C
    WHERE idhorainicio in (SELECT idhorafecha 
                           FROM horafecha 
                           where TO_CHAR(fecha, 'DD/MM/YYYY') like '31/03/2022');

    SELECT C.idcalendario 
    FROM calendario C, horafecha HF, horafecha HF2
    WHERE HF.idhorafecha = C.idhorainicio and
          HF2.idhorafecha = C.idhorafin and
          TO_CHAR(HF.fecha, 'DD/MM/YYYY') like '31/03/2022';


    #DEFINITIVA
    SELECT C.idcalendario 
    FROM calendario C, horafecha HF, horafecha HF2
    WHERE HF.idhorafecha = C.idhorainicio and
          HF2.idhorafecha = C.idhorafin and
          HF.idhorafecha > (SELECT idhorafecha 
                             FROM horafecha 
                             where TO_CHAR(fecha, 'DD/MM/YYYY HH24:MM:SS') like '31/03/2022 10:40:00') and
          HF2.idhorafecha < (SELECT idhorafecha 
                             FROM horafecha 
                             where TO_CHAR(fecha, 'DD/MM/YYYY HH24:MM:SS') like '31/03/2022 10:40:00')

    
    -- select para traer calendario de la obra activa PARA ASISTENCI
    SELECT O.titulo, C.*, T.idobra
    FROM calendario C, horafecha HF, horafecha HF2, obra O, (SELECT idobra FROM obra WHERE estado = 1) T
    WHERE HF.idhorafecha = C.idhorainicio and
          HF2.idhorafecha = C.idhorafin and
          O.idobra = C.idobra and
          O.idobra = T.idobra and
          HF.fecha < TO_DATE('31/03/2022 09:40:00','DD/MM/YYYY HH24:MI:SS')  and
          HF2.fecha > TO_DATE('31/03/2022 09:40:00','DD/MM/YYYY HH24:MI:SS') ;

-- PARA INICIO
SELECT O.titulo, C.*
    FROM calendario C, horafecha HF, horafecha HF2, obra O
    WHERE HF.idhorafecha = C.idhorainicio and
          HF2.idhorafecha = C.idhorafin and
          O.idobra = C.idobra and
          O.idobra = '2' and
          HF.fecha < TO_DATE('31/03/2022 08:40:00','DD/MM/YYYY HH24:MI:SS')  and
          HF2.fecha > TO_DATE('31/03/2022 08:40:00','DD/MM/YYYY HH24:MI:SS') ;


    -- obtener idobra con idestudiante
    SELECT PE.idobra
    FROM estudiante E, PersonajeEstudiante PE
    WHERE E.idestudiante = PE.idestudiante and
          E.idestudiante like 2011202112; 

INSERT INTO AsistenciaEstudiante VALUES (
    idasistenciaestudiante, idcalendario, idobra, idestudiante
)

    -- test
    INSERT INTO AsistenciaEstudiante VALUES (
        1, 1, '2', '2011202112'
    );
    INSERT INTO AsistenciaEstudiante VALUES (
        4, 2, '2', '2011202112'
    );
    INSERT INTO AsistenciaEstudiante VALUES (
        5, 2, '2', '2019102017'
    );
    INSERT INTO AsistenciaEstudiante VALUES (
        6, 3, '2', '2019102017'
    );
    --validar asistencia multiple el mismo dia (idcalendario) por el mismo estudiante
    SELECT idcalendario
    FROM AsistenciaEstudiante
    WHERE idestudiante = 2011202112;


------------------------------------------------------------------------------------------
---------------------------- MODULO VIATICOS ---------------------------------------------
------------------------------------------------------------------------------------------

UPDATE estudiante set correo='equintero@yopmail.com' where correo = 'equintero@gmail.com';
UPDATE estudiante set correo='eduarte@yopmail.com' where correo = 'eduarte@gmail.com';
UPDATE estudiante set correo='efernandez@yopmail.com' where correo = 'efernandez@gmail.com';

-- Visualizar la lista de estudiantes con las secciones (personajes) y horas que participaron en la obra activa
SELECT E.idestudiante, E.nombre, E.apellido, E.correo, U.nombre, P.nombre personaje, (PE.horafin - PE.horainicio)*24 horas
FROM estudiante E, unidad U, personaje P, PersonajeEstudiante PE, obra O
WHERE U.idunidad = E.idunidad and
      E.idestudiante = PE.idestudiante and
      P.idpersonaje = PE.idpersonaje and
      O.idobra =  P.idobra and
      (PE.idobra) = (SELECT idobra 
                     FROM obra
                     WHERE estado like 1);


-- Liquidacion estudiantes

-- ENCABEZADO 

-- obra a liquidar
SELECT titulo FROM obra WHERE estado like 1;

-- fecha inicio y fecha fin de la obra
SELECT O.titulo, min(HFi.fecha), max(HFf.fecha) 
FROM obra O, calendario C, horafecha HFi, horafecha HFf
WHERE O.idobra = C.idobra and
      HFi.idhorafecha = C.idhorainicio and
      HFf.idhorafecha = C.idhorafin and
      O.estado = 1
GROUP BY O.titulo; 

-- PIE DE PAGINA
-- Firma, nombre, cedula y facultad

SELECT E.nombre, E.apellido, E.cedula, U3.nombre
FROM empleado E, unidad U, unidad U2, unidad U3
WHERE U.idunidad = E.idunidad and
      U2.idunidad = U.uni_idunidad and
      U3.idunidad = U2.uni_idunidad and
      E.cedula = 98752059;


-- Lista estudiantes (con nombres completos, cedulas, correos y codigos) con su correspondiente numero de sesiones
-- y horas en las que participo y el periodo de tiempo en que participo


-- Lista estudiantes
SELECT E.nombre||' '||E.apellido nombre, E.correo, E.idestudiante
FROM estudiante E, personaje P, PersonajeEstudiante PE, obra O
WHERE E.idestudiante = PE.idestudiante and
      P.idpersonaje = PE.idpersonaje and
      O.idobra =  P.idobra and
      (PE.idobra) = (SELECT idobra 
                     FROM obra
                     WHERE estado like 1)
ORDER BY E.idestudiante;

-- Numero de sesiones
SELECT E.idestudiante, count(AE.idestudiante)
FROM estudiante E, AsistenciaEstudiante AE
WHERE E.idestudiante = AE.idestudiante
GROUP BY E.idestudiante
ORDER BY E.idestudiante;

SELECT E.idestudiante, count(AE.idestudiante)
FROM estudiante E, AsistenciaEstudiante AE, PersonajeEstudiante PE, personaje P, obra O
WHERE E.idestudiante = AE.idestudiante and
      E.idestudiante = PE.idestudiante and
      P.idpersonaje = PE.idpersonaje and
      P.idobra = PE.idobra and
      O.idobra = P.idobra and
      O.estado = 1
GROUP BY E.idestudiante
ORDER BY E.idestudiante;


-- Horas que participo

SELECT AE.idestudiante, sum((HFf.fecha - HFi.fecha)*24) horas
FROM AsistenciaEstudiante AE, calendario C, horafecha HFi, horafecha HFf, obra o
WHERE C.idcalendario = AE.idcalendario and
      HFi.idhorafecha = C.idhorainicio and
      HFf.idhorafecha = C.idhorafin and
      O.idobra = C.idobra and
      O.estado = 1
GROUP BY AE.idestudiante
ORDER BY AE.idestudiante;



-- Periodo de tiempo en el que participo
SELECT DISTINCT E.idestudiante, P.descperiodo
FROM estudiante E, AsistenciaEstudiante AE, calendario C, LaborPersonalObra LPO, ListaActividad LA, periodo P, obra O
WHERE E.idestudiante = AE.idestudiante and
      C.idcalendario = AE.idcalendario and
      O.idobra = C.idobra and
      O.estado = 1 and
      C.idcalendario = LPO.idcalendario and
      LA.idlistaactividad = LPO.idlistaactividad and
      P.idperiodo = LA.idperiodo 
ORDER BY E.idestudiante;


-- Consulta definitiva
SELECT --E.nombre||' '||E.apellido nombre, E.correo, 
E.idestudiante,P.descperiodo, count(AE.idestudiante) sesiones, sum((HFf.fecha - HFi.fecha)*24) horas--, DISTINCT(P.descperiodo) periodo
FROM estudiante E, AsistenciaEstudiante AE, calendario C, LaborPersonalObra LPO, ListaActividad LA, periodo P, horafecha HFi, horafecha HFf
WHERE E.idestudiante = AE.idestudiante and
      C.idcalendario = AE.idcalendario and
      HFi.idhorafecha = C.idhorainicio and
      HFf.idhorafecha = C.idhorafin and
      C.idcalendario = LPO.idcalendario and
      LA.idlistaactividad = LPO.idlistaactividad and
      LA.idperiodo = LPO.idperiodo and
      P.idperiodo = LA.idperiodo --and
      --E.idestudiante = 2019102017
group by E.nombre||' '||E.apellido, E.correo, E.idestudiante, P.descperiodo;



UPDATE obra set estado='0' where estado = '1';
UPDATE obra set estado='1' where idobra = '2';

------------------------------------------------------------------------------------------
---------------------------- MODULO CERTIFICADOS ---------------------------------------------
------------------------------------------------------------------------------------------

-- todas las obras y en cuales participo como docente
SELECT O.titulo titulo, O.estado estado, LPO.idempleado empleado
FROM obra O, calendario C, LaborPersonalObra LPO
WHERE O.idobra = C.idobra and
      C.idcalendario = LPO.idcalendario and
      C.idobra = LPO.idobra and
      LPO.idempleado like 1;


SELECT TRIM(O.titulo), NVL2(PART.empleado,'Participó', 'No participó') "Participacion como docente"
FROM obra O, (SELECT O.titulo titulo, O.estado estado, LPO.idempleado empleado
             FROM obra O, calendario C, LaborPersonalObra LPO
             WHERE O.idobra = C.idobra and
                   C.idcalendario = LPO.idcalendario and
                   C.idobra = LPO.idobra and
                   LPO.idempleado like 1) PART
WHERE O.titulo = PART.titulo(+);

SELECT O.titulo, TO_CHAR(min(HFi.fecha),'DD/MM/YYYY'), TO_CHAR(max(HFf.fecha),'DD/MM/YYYY') , E.nombre ||' ' || E.apellido
                          FROM obra O, calendario C, horafecha HFi, horafecha HFf, ListaActividad LA , LaborPersonalObra LP , PersonalObra PO , empleado E
                          WHERE O.idobra = C.idobra and
                                HFi.idhorafecha = C.idhorainicio and
                                HFf.idhorafecha = C.idhorafin and
                                LA.idListaActividad = 10 and
                                LP.idListaActividad = LA.idListaActividad and
                                LP.idPersonalObra = PO.idPersonalObra and
                                E.idempleado = PO.idempleado and
                               O.idObra = '2' GROUP BY O.titulo, E.nombre ||' ' || E.apellido;

SELECT correo FROM estudiante WHERE idestudiante = 2011202112;

UPDATE estudiante set correo="luisocampo2001.o.g@gmail.com" where idestudiante ='luisocampo2001.o.g@gmail.com';