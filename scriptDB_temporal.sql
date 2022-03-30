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
    '1', 'Hamlet', '1', TO_DATE('01/01/1602', 'DD/MM/YYYY'), '2', '1', '0' 
);


INSERT INTO Obra VALUES (
    '2', 'La Divina Comedia', '2', TO_DATE('03/11/2008', 'DD/MM/YYYY'), '3', '2', '1' 
);

INSERT INTO Obra VALUES (
    '3', 'El sueno de noche de verano ', '1', TO_DATE('1/11/1600', 'DD/MM/YYYY'), '2', '1', '0' 
);

INSERT INTO Obra VALUES (
    '4', 'Romeo y Julieta', '1', TO_DATE('5/3/1602', 'DD/MM/YYYY'), '2', '1', '0' 
);

INSERT INTO Obra VALUES (
    '5', ' El Fantasma de la Ópera', '3', TO_DATE('10/3/2004', 'DD/MM/YYYY'), '2', '3', '0' 
);

INSERT INTO Obra VALUES (
    '6', 'La celestina', '4', TO_DATE('1/1/1499', 'DD/MM/YYYY'), '5', '1', '0' 
);

INSERT INTO Obra VALUES (
    '7', 'Don Juan Tenorio', '5', TO_DATE('1/1/1844', 'DD/MM/YYYY'), '5', '1', '0 '
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
    '1', 'Teatro Colon Bogota', ' Cl. 10 # 5-32' 
);
INSERT INTO Teatro VALUES (
    '2', ' J. M. Santo Domingo', 'Cl. 170 #67-51' 
);
INSERT INTO Teatro VALUES (
    '3', 'J. Eliécer Gaitán', ' Cra. 7 #22-47'
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



-- para visualizar la HORA dentro del campo de horafecha
alter session set nls_date_format = 'dd/MON/yyyy hh24:mi:ss'


INSERT INTO HORAFECHA VALUES (
   '1', TO_DATE('31/03/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);

INSERT INTO HORAFECHA VALUES (
   '2', TO_DATE('31/03/2022 18:00:00', 'DD-MM-YY HH24:MI:SS')
);

INSERT INTO HORAFECHA VALUES (
   '3', TO_DATE('03/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '4', TO_DATE('03/04/2022 13:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '5', TO_DATE('04/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '6', TO_DATE('04/04/2022 13:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '7', TO_DATE('08/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '8', TO_DATE('08/04/2022 13:00:00', 'DD-MM-YY HH24:MI:SS')
);

INSERT INTO HORAFECHA VALUES (
   '9', TO_DATE('09/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '10', TO_DATE('09/04/2022 13:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '11', TO_DATE('14/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '12', TO_DATE('14/04/2022 13:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '13', TO_DATE('15/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '14', TO_DATE('15/04/2022 13:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '15', TO_DATE('20/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '16', TO_DATE('20/04/2022 20:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '17', TO_DATE('22/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '18', TO_DATE('22/04/2022 20:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '19', TO_DATE('24/04/2022 09:00:00', 'DD-MM-YY HH24:MI:SS')
);
INSERT INTO HORAFECHA VALUES (
   '20', TO_DATE('24/04/2022 20:00:00', 'DD-MM-YY HH24:MI:SS')
);
-- Calendario 

INSERT INTO Calendario VALUES (
    '1', '2', '1', '1', 1, 2
);

INSERT INTO Calendario VALUES (
    '2', '2', '2', '2', 3, 4
);

INSERT INTO Calendario VALUES (
    '3', '2', '2', '2', 5, 6
);
INSERT INTO Calendario VALUES (
    '4', '2', '2', '2', 7, 8
);
INSERT INTO Calendario VALUES (
    '5', '2', '2', '3', 9, 10
);
INSERT INTO Calendario VALUES (
    '6', '2', '2', '2', 11, 12
);
INSERT INTO Calendario VALUES (
    '7', '2', '2', '3', 13, 14
);
INSERT INTO Calendario VALUES (
    '8', '2', '3', '1', 15, 16
);
INSERT INTO Calendario VALUES (
    '9', '2', '3', '1', 17, 18
);
 INSERT INTO Calendario VALUES (
    '10', '2', '3', '3', 19, 20
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
    '1', '1', 'Escenografia', '20'
);

INSERT INTO ListaActividad VALUES(
    '2', '1', 'Vestuario', '25'
);

INSERT INTO ListaActividad VALUES(
    '3', '1', 'Maquillaje', '24'
);

INSERT INTO ListaActividad VALUES(
    '4', '1', 'Luces', '21'
);

INSERT INTO ListaActividad VALUES(
    '5', '1', 'Sonorizacion', '21'
);

INSERT INTO ListaActividad VALUES(
    '6', '1', 'Publicidad', '24'
);

INSERT INTO ListaActividad VALUES(
    '7', '1', 'Auxiliar Labores Administrativas', '20'
);

INSERT INTO ListaActividad VALUES(
    '8', '1', 'Coordinador Artistico', '20'
);

INSERT INTO ListaActividad VALUES(
    '9', '1', 'Administrador Aplicacion', '30'
);

INSERT INTO ListaActividad VALUES(
    '10', '1', 'Director', '35'
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
    '10', '2', '', 'Rectoria'
);
INSERT INTO Unidad VALUES (
    '11', '2', '10', 'Vicerrectoria'
);


INSERT INTO Unidad VALUES (
    '5', '1', '11', 'Facultad de Artes'
);

INSERT INTO Unidad VALUES (
    '6', '1', '5', 'Proyecto de Artes Escenicas'
);
INSERT INTO Unidad VALUES (
    '7', '1', '5', 'Proyecto de Musica'
);
INSERT INTO Unidad VALUES (
    '8', '1', '5', 'Proyecto de Catastral'
);
INSERT INTO Unidad VALUES (
    '9', '1', '5', 'Proyecto de Electrica'
);


INSERT INTO Unidad VALUES (
    '1', '1', '6', 'Artes Escenicas'
);
INSERT INTO Unidad VALUES (
    '2', '1', '7', 'Musica'
);
INSERT INTO Unidad VALUES (
    '3', '1', '8', 'Ingenieria Catastral'
);

INSERT INTO Unidad VALUES (
    '4', '1', '9', 'Ingenieria Electrica'
);
--1.9. Incluir 10 estudiantes de los cuales, 4 fueron asignados a los personajes de la 
--obra activa y 6 a otras obras 

--Estudiantes

INSERT INTO Estudiante VALUES (
    '2017202012', '1', TO_DATE('01/07/2017', 'DD-MM-YY'),TO_DATE('11/02/1997', 'DD-MM-YY') ,'psalcedo@yopmail.com' ,'Pedro', 'Salcedo'
);

INSERT INTO Estudiante VALUES (
    '2017202024', '1', TO_DATE('01/07/2017', 'DD-MM-YY'),TO_DATE('16/10/1999', 'DD-MM-YY'), 'jrodriguez@yopmail.com' ,'Jose', 'Rodriguez'
);

INSERT INTO Estudiante VALUES (
    '2017102021', '1', TO_DATE('01/02/2017', 'DD-MM-YY'),TO_DATE('20/01/1999', 'DD-MM-YY'), 'ccaicedo@yopmail.com' ,'Cristian', 'Caicedo'
);

INSERT INTO Estudiante VALUES (
    '2019102072', '1', TO_DATE('01/02/2019', 'DD-MM-YY'),TO_DATE('11/09/2001', 'DD-MM-YY'), 'agomez@yopmail.com' ,'Andrea', 'Gomez'
);

INSERT INTO Estudiante VALUES (
    '2019202044', '1', TO_DATE('01/07/2019', 'DD-MM-YY'),TO_DATE('01/07/1997', 'DD-MM-YY'), 'cgonzalez@yopmail.com' ,'Cristina', 'Gonzalez'
);

INSERT INTO Estudiante VALUES (
    '2020202062', '1', TO_DATE('01/07/2020', 'DD-MM-YY'),TO_DATE('30/03/2002', 'DD-MM-YY'), 'efernandez@yopmail.com' ,'Esteban', 'Fernandez'
);

INSERT INTO Estudiante VALUES (
    '2016102051', '1', TO_DATE('01/02/2016', 'DD-MM-YY'),TO_DATE('25/01/1992', 'DD-MM-YY'), 'equintero@yopmail.com' ,'Radamel', 'Quintero'
);

INSERT INTO Estudiante VALUES (
    '2015202002', '1', TO_DATE('01/07/2015', 'DD-MM-YY'),TO_DATE('06/12/1995', 'DD-MM-YY'), 'sgaviria@yopmail.com' ,'Sofia', 'Gaviria'
);

INSERT INTO Estudiante VALUES (
    '2019102017', '1', TO_DATE('01/02/2019', 'DD-MM-YY'),TO_DATE('29/05/2000', 'DD-MM-YY'), 'eduarte@yopmail.com' ,'Elena', 'Duarte'
);

INSERT INTO Estudiante VALUES (
    '2011202112', '2', TO_DATE('01/07/2011', 'DD-MM-YY'),TO_DATE('15/10/1990', 'DD-MM-YY'), 'jperez@yopmail.com' ,'Juan', 'Perez'
);


--PersonajeEstudiante
--obra activa (La Divina Comedia)

INSERT INTO PersonajeEstudiante VALUES (
    '1', '5', '2', '2011202112', TO_DATE('31/03/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('24/04/2022 16:00', 'DD-MM-YY HH24:MI')
); 
-- Perez

INSERT INTO PersonajeEstudiante VALUES (
    '2', '6', '2', '2016102051', TO_DATE('04/04/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('24/04/2022 16:00', 'DD-MM-YY HH24:MI')
); 
-- Quintero

INSERT INTO PersonajeEstudiante VALUES (
    '3', '7', '2', '2019102017', TO_DATE('31/03/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('24/04/2022 16:00', 'DD-MM-YY HH24:MI')
); 
-- Duarte

INSERT INTO PersonajeEstudiante VALUES (
    '4', '8', '2', '2020202062', TO_DATE('08/04/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('22/04/2022 16:00', 'DD-MM-YY HH24:MI')
); 
-- Fernandez

--obras inactivas

INSERT INTO PersonajeEstudiante VALUES (
    '5', '1', '1', '2015202002', TO_DATE('14/05/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('14/06/2022 16:00', 'DD-MM-YY HH24:MI')
);

INSERT INTO PersonajeEstudiante VALUES (
    '6', '2', '1', '2017102021', TO_DATE('14/05/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('14/06/2022 16:00', 'DD-MM-YY HH24:MI')
);

INSERT INTO PersonajeEstudiante VALUES (
    '7', '9', '3', '2019202044', TO_DATE('14/09/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('14/10/2022 16:00', 'DD-MM-YY HH24:MI')
);

INSERT INTO PersonajeEstudiante VALUES (
    '8', '14', '4', '2019102072', TO_DATE('14/07/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('14/08/2022 16:00', 'DD-MM-YY HH24:MI')
);

INSERT INTO PersonajeEstudiante VALUES (
    '9', '13', '4', '2017202024', TO_DATE('14/07/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('14/08/2022 16:00', 'DD-MM-YY HH24:MI')
);

INSERT INTO PersonajeEstudiante VALUES (
    '10', '15', '4', '2017202012', TO_DATE('14/07/2022 08:00', 'DD-MM-YY HH24:MI'), TO_DATE('14/08/2022 16:00', 'DD-MM-YY HH24:MI')
);


--1.10. Incluir 12 empleado de los cuales 5 trabajaran en la obra activa con los roles:
--2 docentes y 5 auxiliares y 5 pertenecen a las otras obras de los cuales 2 son docentes

--empleado en Obra Activa (La Divina Comedia)

INSERT INTO empleado VALUES (
    '1', '5', 'Yimmy', 'Gonzalez', '98752059', '3134556922', 'ygonzalez@yopmail.com'
);

INSERT INTO empleado VALUES (
    '2', '5', 'Juan', 'Polo', '99752059', '3134556922', 'jpolo@yopmail.com'
);

INSERT INTO empleado VALUES (
    '3', '5', 'Alfredo', 'Gonzalez', '91752839', '3134556922', 'agonzalez@yopmail.com'
);

INSERT INTO empleado VALUES (
    '4', '5', 'Laura', 'Garcia', '95652059', '3134556922', 'lgarcia@yopmail.com'
);

INSERT INTO empleado VALUES (
    '5', '5', 'Cristo', 'Fernandez', '91752059', '3134556922', 'cfernandez@yopmail.com'
);



INSERT INTO empleado VALUES (
    '6', '5', 'Carmen', 'Manrique', '88888888', '3134556922', 'cmanrique@yopmail.com'
);

INSERT INTO empleado VALUES (
    '7', '5', 'Oswaldo', 'Rodriquez', '88888888', '3134556922', 'orodriquez@yopmail.com'
);

INSERT INTO empleado VALUES (
    '8', '5', 'Patricia', 'Gonzalez', '88888888', '3134556922', 'pgonzalez@yopmail.com'
);

INSERT INTO empleado VALUES (
    '9', '5', 'Ferney', 'Candela', '88888888', '3134556922', 'fcandela@yopmail.com'
);

INSERT INTO empleado VALUES (
    '10', '5', 'Karen', 'Lizarazo', '88888888', '3134556922', 'klizarazo@yopmail.com'
);

INSERT INTO empleado VALUES (
    '11', '5', 'Junifero', 'Primero', '88888888', '3134556922', 'jprimero@yopmail.com'
);

INSERT INTO empleado VALUES (
    '12', '5', 'Esteban', 'Galindo', '88888888', '3134556922', 'egalindo@yopmail.com'
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
    '1', '1', '5', '1', '2', TO_DATE('14/05/2022', 'DD-MM-YY'), TO_DATE('14/05/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '2', '2', '5', '1', '2', TO_DATE('14/05/2022', 'DD-MM-YY'), TO_DATE('14/06/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '3', '3', '5', '2', '2', TO_DATE('14/05/2022', 'DD-MM-YY'), TO_DATE('14/06/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '4', '4', '5', '2', '2', TO_DATE('14/05/2022', 'DD-MM-YY'), TO_DATE('14/06/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '5', '5', '5', '2', '2', TO_DATE('14/05/2022', 'DD-MM-YY'), TO_DATE('14/06/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '6', '6', '5', '2', '2', TO_DATE('14/05/2022', 'DD-MM-YY'), TO_DATE('14/06/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '7', '7', '5', '2', '2', TO_DATE('14/05/2022', 'DD-MM-YY'), TO_DATE('14/06/2022', 'DD-MM-YY')
);

    
  --  Obras Inactivas

INSERT INTO PersonalObra VALUES (
    '8', '8', '5', '1', '1', TO_DATE('14/06/2022', 'DD-MM-YY'), TO_DATE('14/07/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '9', '9', '5', '1', '4', TO_DATE('14/07/2022', 'DD-MM-YY'), TO_DATE('14/08/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '10', '10', '5', '2', '1', TO_DATE('14/06/2022', 'DD-MM-YY'), TO_DATE('14/07/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '11', '11', '5', '2', '1', TO_DATE('14/06/2022', 'DD-MM-YY'), TO_DATE('14/07/2022', 'DD-MM-YY')
);

INSERT INTO PersonalObra VALUES (
    '12', '12', '5', '2', '4', TO_DATE('14/07/2022', 'DD-MM-YY'), TO_DATE('14/08/2022', 'DD-MM-YY')
);



-- LaborPersonalObra


-- Obra Activa

INSERT INTO LaborPersonalObra VALUES (
    '1', '1', '1', '5', '10', '1', '1', '2'
);

INSERT INTO LaborPersonalObra VALUES (
    '2', '2', '2', '5', '7', '1', '1', '2'
);



--Obra inActiva

INSERT INTO LaborPersonalObra VALUES (
    '8', '8', '8', '5', '10', '1', '9', '1'
);

INSERT INTO LaborPersonalObra VALUES (
    '9', '9', '9', '5', '10', '1', '10', '4'
);