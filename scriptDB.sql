-- Dramaturgos: 

INSERT INTO Dramaturgo VALUES (
 	   '1', 'William Shakespeare', '2'
);
INSERT INTO Dramaturgo VALUES (
    '2', 'Cristina Armada ', '4'
);

INSERT INTO Dramaturgo VALUES (
    '3', 'Joel Schumacher', '2'
);
INSERT INTO Dramaturgo VALUES (
    '4', 'Fernando de Rojas', '5'
);
INSERT INTO Dramaturgo VALUES (
    '5', 'José Zorrilla', '5'
);
	
-- Paises 
	
INSERT INTO Pais VALUES (
    '1', 'Colombia' 
);

INSERT INTO Pais VALUES (
    '2', 'Inglaterra' 
);

INSERT INTO Pais VALUES (
    '3', 'Italia' 
);

INSERT INTO Pais VALUES (
    '4', 'Argentina' 
);

INSERT INTO Pais VALUES (
    '5', 'España' 
);
-- Genero 
INSERT INTO TipoObra VALUES(
    '1', 'Tragedia/Drama'
);

INSERT INTO TipoObra VALUES(
    '2', 'Epopeya'
);

INSERT INTO TipoObra VALUES(
    '3', 'Musical'
);

-- Obra
	
INSERT INTO Obra VALUES (
    '1', 'Hamlet', '1', '01/01/1602', '2', '1', False 
);


INSERT INTO Obra VALUES (
    '2', 'La Divina Comedia', '2', '03/11/2008', '3', '2', True 
);

INSERT INTO Obra VALUES (
    '3', ' El sueño de una noche de verano ', '1', '1/11/1600', '2', '1', false 
);

INSERT INTO Obra VALUES (
    '4', 'Romeo y Julieta', '1', '5/3/1602', '2', '1', false 
);

INSERT INTO Obra VALUES (
    '5', ' El Fantasma de la Ópera', '3', '10/3/2004', '2', '3', false 
);

INSERT INTO Obra VALUES (
    '6', 'La celestina', '4', '1/1/1499', '5', '1', false 
);

INSERT INTO Obra VALUES (
    '7', 'Don Juan Tenorio', '5', '1/1/1844', '5', '1', false 
);

-- Personajes

INSERT INTO Personaje VALUES (
    '1', '1', 'Ofelia', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '2', '1', 'Principe Hamlet', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '3', '1', 'Claudious', 'Antagonista' 
);
INSERT INTO Personaje VALUES (
    '4', '1', 'rey Hamlet', 'Personaje Secundario' 
);
INSERT INTO Personaje VALUES (
    '5', '2', 'Dante', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '6', '2', 'Virgilio', 'Personaje Principal' 
);
INSERT INTO Personaje VALUES (
    '7', '2', 'Beatrice', ' Personaje Principal ' 
);
INSERT INTO Personaje VALUES (
    '8', '2', 'Ciacco', 'Personaje Secundario' 
);
INSERT INTO Personaje VALUES (
    '9', '3', 'Hermia', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '10', '3', 'Oberon', 'Personaje Principal' 
);
INSERT INTO Personaje VALUES (
    '11', '3', 'Puck', ' Personaje Principal ' 
);
INSERT INTO Personaje VALUES (
    '12', '3', 'Egeo', 'Personaje Secundario' 
);
INSERT INTO Personaje VALUES (
    '13', '4', 'Romeo', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '14', '4', 'Julieta', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '15', '4', 'Mercurio', ' Personaje Principal ' 
);
INSERT INTO Personaje VALUES (
    '16', '4', 'Benvolio', 'Personaje Secundario' 
);
INSERT INTO Personaje VALUES (
    '17', '5', 'Erik', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '18', '5', 'Christine daae', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '19', '5', 'Raoul de chagny', ' Personaje Principal ' 
);
INSERT INTO Personaje VALUES (
    '20', '5', 'Carlotta', 'Personaje Secundario' 
);
INSERT INTO Personaje VALUES (
    '21', '6', 'Melibea', 'Protagonista'
);
INSERT INTO Personaje VALUES (
    '22', '6', 'Sempronio', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '23', '6', 'Calisto', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '24', '6', 'Pleberio', ' Personaje Principal ' 
);
INSERT INTO Personaje VALUES (
    '25', '7', 'Don Juan Tenorio', 'Protagonista'
);
INSERT INTO Personaje VALUES (
    '26', '7', 'Don Luis Mejia', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '27', '7', 'Doña ines de Ulloa', 'Protagonista' 
);
INSERT INTO Personaje VALUES (
    '28', '7', 'Marcos Ciutti', ' Personaje Principal ' 
);

-- Teatros

INSERT INTO Teatro VALUES (
    '1', 'Teatro Colon de Bogota', ' Cl. 10 # 5-32' 
);
INSERT INTO Teatro VALUES (
    '2', ' Teatro Mayor Julio Mario Santo Domingo', 'Cl. 170 #67-51' 
);
INSERT INTO Teatro VALUES (
    '3', ' Teatro Municipal Jorge Eliécer Gaitán', ' Cra. 7 #22-47'
);
-- Tipo de calendario

INSERT INTO TipoCalendario VALUES (
    '1', 'Convocatoria'
);
INSERT INTO TipoCalendario VALUES (
    '2', 'Ensayo'
);
INSERT INTO TipoCalendario VALUES (
    '3', 'Función'
);


-- Calendario 

INSERT INTO Calendario VALUES (
    '1', '2', '1', '1', '2022-03-31 09:00:00', '2022-03-31 18:00:00'
);
INSERT INTO Calendario VALUES (
    '2', '2', '2', '2', '2022-04-03 09:00:00', '2022-04-03 13:00:00'
);

INSERT INTO Calendario VALUES (
    '3', '2', '2', '2', '2022-04-04 09:00:00', '2022-04-04 13:00:00'
);
INSERT INTO Calendario VALUES (
    '4', '2', '2', '2', '2022-04-08 09:00:00', '2022-04-08 13:00:00'
);
INSERT INTO Calendario VALUES (
    '5', '2', '2', '3', '2022-04-09 09:00:00', '2022-04-09 13:00:00'
);
INSERT INTO Calendario VALUES (
    '6', '2', '2', '2', '2022-04-14 09:00:00', '2022-04-14 13:00:00'
);
INSERT INTO Calendario VALUES (
    '7', '2', '2', '3', '2022-04-15 09:00:00', '2022-04-15 13:00:00'
);
INSERT INTO Calendario VALUES (
    '8', '2', '3', '1', '2022-04-20 19:00:00', '2022-04-20 20:00:00'
);
INSERT INTO Calendario VALUES (
    '9', '2', '3', '1', '2022-04-22 19:00:00', '2022-04-22 20:00:00'
);
 INSERT INTO Calendario VALUES (
    '10', '2', '3', '3', '2022-04-24 19:00:00', '2022-04-24 20:00:00'
);



--1.4. Incluir 3 períodos, que equivale al año y periodo, pues los valores estipulados por la
--universidad cambian año a año. -- YO

INSERT INTO Periodo VALUES(
    '1', '2022-1'
);

INSERT INTO Periodo VALUES(
    '2', '2022-2'
);

INSERT INTO Periodo VALUES(
    '3', '2023-1'
);


--1.5. Incluir la lista de actividades: Escenografía, vestuario, maquillaje, luces,
--sonorización, publicidad, auxiliar labores administrativas, coordinador artístico,
--administrador aplicación. -- YO

INSERT INTO ListaActividad VALUES(
    '1', '1', 'Escenografia', '20000'
);

INSERT INTO ListaActividad VALUES(
    '2', '1', 'Vestuario', '25000'
);

INSERT INTO ListaActividad VALUES(
    '3', '1', 'Maquillaje', '24000'
);

INSERT INTO ListaActividad VALUES(
    '4', '1', 'Luces', '21000'
);

INSERT INTO ListaActividad VALUES(
    '5', '1', 'Sonorizacion', '21000'
);

INSERT INTO ListaActividad VALUES(
    '6', '1', 'Publicidad', '24000'
);

INSERT INTO ListaActividad VALUES(
    '7', '1', 'Auxiliar Labores Administrativas', '20000'
);

INSERT INTO ListaActividad VALUES(
    '8', '1', 'Coordinador Artistico', '20000'
);

INSERT INTO ListaActividad VALUES(
    '9', '1', 'Administrador Aplicacion', '30000'
);

INSERT INTO ListaActividad VALUES(
    '10', '1', 'Director', '35000'
);

--1.6. Incluir el tipo de Calendario con: 1, Convocatoria; 2, Ensayo; 3, Función
--1.7. Incluir el calendario de la obra que quedo activa: incluir 1 convocatoria, 6 ensayos
--y 3 funciones
--1.8. Incluir 10 unidades de las cuales 8 son académicas y 2 administrativas. Ejemplo,
--Si se incluye un proyecto curricular, deben incluir toda su dependencia (Rectoria,
--vicerrectoría, Facultad, proyecto) -- YO

INSERT INTO TipoUnidad VALUES(
    '1', 'Academica'
);

INSERT INTO TipoUnidad VALUES(
    '2', 'Administrativa'
);

INSERT INTO Unidad VALUES (
    '1', '1', '1', 'Proyecto Curricular'
);


--1.9. Incluir 10 estudiantes de los cuales, 4 fueron asignados a los personajes de la 
--obra activa y 6 a otras obras 

--Estudiantes

INSERT INTO Estudiante VALUES (
    '20172020012', '','01/07/2017','11/02/1997' ,'psalcedo@gmail.com' ,'Pedro', 'Salcedo'
);

INSERT INTO Estudiante VALUES (
    '20172020024', '','01/07/2017','16/10/1999', 'jrodriguez@gmail.com' ,'Jose', 'Rodriguez'
);

INSERT INTO Estudiante VALUES (
    '20171015021', '','01/02/2017','20/01/1999', 'ccaicedo@gmail.com' ,'Cristian', 'Caicedo'
);

INSERT INTO Estudiante VALUES (
    '20191020072', '','01/02/2019','11/09/2001', 'agomez@gmail.com' ,'Andrea', 'Gomez'
);

INSERT INTO Estudiante VALUES (
    '20192020044', '','01/07/2019','01/07/1997', 'cgonzalez@gmail.com' ,'Cristina', 'Gonzalez'
);

INSERT INTO Estudiante VALUES (
    '20202020062', '','01/07/2020','30/03/2002', 'efernandez@gmail.com' ,'Esteban', 'Fernandez'
);

INSERT INTO Estudiante VALUES (
    '20161020051', '','01/02/2016','25/01/1992', 'equintero@gmail.com' ,'Radamel', 'Quintero'
);

INSERT INTO Estudiante VALUES (
    '20152020002', '','01/07/2015','06/12/1995', 'sgaviria@gmail.com' ,'Sofia', 'Gaviria'
);

INSERT INTO Estudiante VALUES (
    '20191020017', '','01/02/2019','29/05/2000', 'eduarte@gmail.com' ,'Elena', 'Duarte'
);

INSERT INTO Estudiante VALUES (
    '20112020112', '','01/07/2011','15/10/1990', 'jperez@gmail.com' ,'Juan', 'Perez'
);


--PersonajeEstudiante
--obra activa (La Divina Comedia)

INSERT INTO PersonajeEstudiante VALUES (
    '1', '5', '2', '20112020112', '14/05/2022 08:00', '14/05/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '2', '6', '2', '20161020051', '14/05/2022 08:00', '14/05/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '3', '7', '2', '20191020017', '14/05/2022 08:00', '14/05/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '4', '8', '2', '20202020062', '14/05/2022 08:00', '14/05/2022 16:00'
);

--obras inactivas

INSERT INTO PersonajeEstudiante VALUES (
    '5', '1', '1', '20152020002', '14/07/2022 08:00', '14/07/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '6', '2', '1', '20171015021', '14/07/2022 08:00', '14/07/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '7', '9', '3', '20192020044', '14/09/2022 08:00', '14/09/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '8', '14', '4', '20191020072', '14/11/2022 08:00', '14/11/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '9', '13', '4', '20172020024', '14/05/2022 08:00', '14/05/2022 16:00'
);

INSERT INTO PersonajeEstudiante VALUES (
    '10', '15', '4', '20172020012', '14/05/2022 08:00', '14/05/2022 16:00'
);


--1.10. Incluir 12 empleado de los cuales 5 trabajaran en la obra activa con los roles:
--2 docentes y 5 auxiliares y 5 pertenecen a las otras obras de los cuales 2 son docentes

--empleado en Obra Activa (La Divina Comedia)

INSERT INTO empleado VALUES (
    '1', '', 'Yimmy', 'Gonzalez', '98752059', '3134556922', 'ygonzalez@gmail.com'
);

INSERT INTO empleado VALUES (
    '2', '', 'Juan', 'Polo', '99752059', '3134556922', 'jpolo@gmail.com'
);

INSERT INTO empleado VALUES (
    '3', '', 'Alfredo', 'Gonzalez', '91752839', '3134556922', 'agonzalez@gmail.com'
);

INSERT INTO empleado VALUES (
    '4', '', 'Laura', 'Garcia', '95652059', '3134556922', 'lgarcia@gmail.com'
);

INSERT INTO empleado VALUES (
    '5', '', 'Cristo', 'Fernandez', '91752059', '3134556922', 'cfernandez@gmail.com'
);



INSERT INTO empleado VALUES (
    '6', '', 'Carmen', 'Manrique', '98752059', '3134556922', 'cmanrique@gmail.com'
);

INSERT INTO empleado VALUES (
    '7', '', 'Oswaldo', 'Rodriquez', '98752059', '3134556922', 'orodriquez@gmail.com'
);

INSERT INTO empleado VALUES (
    '8', '', 'Patricia', 'Gonzalez', '98752059', '3134556922', 'pgonzalez@gmail.com'
);

INSERT INTO empleado VALUES (
    '9', '', 'Ferney', 'Candela', '98752059', '3134556922', 'fcandela@gmail.com'
);

INSERT INTO empleado VALUES (
    '10', '', 'Karen', 'Lizarazo', '98752059', '3134556922', 'klizarazo@gmail.com'
);

INSERT INTO empleado VALUES (
    '11', '', 'Junifero', 'Primero', '98752059', '3134556922', 'jprimero@gmail.com'
);

INSERT INTO empleado VALUES (
    '12', '', 'Esteban', 'Galindo', '98752059', '3134556922', 'egalindo@gmail.com'
);


--Roles

INSERT INTO Rol VALUES (
    '1', 'Docente'
);

INSERT INTO Rol VALUES (
    '2', 'Auxiliar'
);


-- PersonalObra

  --  ObraActiva

INSERT INTO PersonalObra VALUES (
    '1', '1', '', '1', '2', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '2', '2', '', '1', '2', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '3', '3', '', '2', '2', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '4', '4', '', '2', '2', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '5', '5', '', '2', '2', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '6', '6', '', '2', '2', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '7', '7', '', '2', '2', '14/05/2022', '14/06/2022'
);

    
  --  Obras Inactivas

INSERT INTO PersonalObra VALUES (
    '8', '8', '', '1', '1', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '9', '9', '', '1', '4', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '10', '10', '', '2', '1', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '11', '11', '', '2', '1', '14/05/2022', '14/06/2022'
);

INSERT INTO PersonalObra VALUES (
    '12', '12', '', '2', '4', '14/05/2022', '14/06/2022'
);

