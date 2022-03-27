-- Obra activa
SELECT titulo FROM obra WHERE estado = 1;


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