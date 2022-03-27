-- Obra activa
SELECT titulo FROM obra WHERE estado = 1;

--formato fecha
alter session set nls_date_format = 'dd/MON/yyyy hh24:mi:ss'


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
          HF.idhorafecha in (SELECT idhorafecha 
                             FROM horafecha 
                             where TO_CHAR(fecha, 'DD/MM/YYYY') like '31/03/2022');


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
        2, 1, '2', '2011202112'
    );
    INSERT INTO AsistenciaEstudiante VALUES (
        3, 1, '2', '2011202112'
    );

    --validar asistencia multiple el mismo dia (idcalendario) por el mismo estudiante
    SELECT idcalendario
    FROM AsistenciaEstudiante
    WHERE idestudiante = 2011202112;