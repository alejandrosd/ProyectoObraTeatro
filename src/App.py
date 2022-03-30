from urllib import request
import cx_Oracle
from numpy import full, size
import config
from flask import Flask, render_template, request, redirect, url_for, flash
import datetime

#librerias para pdf
from distutils.log import info
import jinja2
import pdfkit

import smtplib


app = Flask(__name__)
#, static_folder='/src/templates/pdf/static'

id_empleado = 0

#conexion con oracle
connection = None
try:
    connection = cx_Oracle.connect(
        config.username,
        config.password,
        config.dsn,
        encoding=config.encoding)

    # imprime la version de la base de datos
    print("conectado",connection.version)
    cursor= connection.cursor()
    sentencia=cursor.execute("SELECT * FROM test")
    rows = cursor.fetchall()
    print(rows)

    #oracle = oracle(app)
    for row in rows:
        print(row)
except cx_Oracle.Error as error:
    print(error)

finally:
    # release the connection
    if connection:
        print("cerrar conexion")
        #connection.close()

# configuracion de session
app.secret_key = 'mysecretkey'

@app.route('/')
def index():
    global id_empleado
    if (id_empleado) == 0:
        page = 'login'
    else:
        page = 'inicio' 
    return redirect(url_for(page))


@app.route('/login', methods=['GET','POST'])
def login():
            
    if request.method == 'POST':
        cedula = request.form['cedula']
        nombre = request.form['nombre']
                       
        try:          
            cursor= connection.cursor()
            cursor.execute("""SELECT * FROM empleado where cedula = :cedula and nombre = :nombre""",cedula = cedula ,nombre = nombre ) 
            data = cursor.fetchall()
            
            cursor.execute("""SELECT R.nombre 
                              FROM empleado E, PersonalObra PO, rol R, unidad U
                              WHERE E.idempleado = PO.idempleado and
                                    U.idunidad = E.idunidad and
                                    E.idunidad = PO.idpersonalobra and
                                    R.idrol = PO.idrol and
                                    E.cedula = :cedula and
                                    E.nombre = :nombre and
                                    R.nombre like 'Docente%'""",cedula = cedula ,nombre = nombre ) 
            data2 = cursor.fetchall()
            
            if (data):
                #if data2:
                print(data[0][0])
                global id_empleado
                id_empleado = data[0][0]
                return redirect(url_for('inicio'))  
                #else:
                    #flash('NO es DOCENTE')  
                return redirect(url_for('login'))      
            else:
                flash('CREDENCIALES INVALIDAS')  
                return redirect(url_for('login'))          
        except cx_Oracle.Error as error:
            flash('ERROR EN EL SISTEMA')
            print(error)
        
    return render_template('login.html')


@app.route('/inicio' , methods=['GET','POST'])
def inicio():
    global id_empleado # means: in this scope, use the global name
    print(id_empleado)
    cursor = connection.cursor()

    # Datos para layout.html

    cursor.execute("""SELECT * FROM empleado where idEmpleado = :id_empleado """,id_empleado = id_empleado)           
    
    data = cursor.fetchall()
    print("DOCENTE ",data)
    data2 = fecha()

    #Descarga todas las obras e indica en cual participo el docente
    cursor.execute("""SELECT idObra, TRIM(O.titulo), NVL2(PART.empleado,'Participó', 'No participó') , O.estado
                      FROM obra O, (SELECT O.titulo titulo, O.estado estado, LPO.idempleado empleado
                                  FROM obra O, calendario C, LaborPersonalObra LPO
                                  WHERE O.idobra = C.idobra and
                                          C.idcalendario = LPO.idcalendario and
                                          C.idobra = LPO.idobra and
                                          LPO.idempleado like 1) PART
                    WHERE O.titulo = PART.titulo(+)""")

    data3 = cursor.fetchall()

    #Recorrera todas las obras buscando que botones habilitar
    data4=[]
    for x in data3:
        print ("OBRA ",x)
        if x[2] == "Participó":
            #Verificar si se puede agregar asistencia           
            cursor.execute("""SELECT O.titulo, C.* 
                FROM calendario C, horafecha HF, horafecha HF2, obra O
                WHERE HF.idhorafecha = C.idhorainicio and
                    HF2.idhorafecha = C.idhorafin and
                    O.idobra = C.idobra and
                    O.idobra = :id_obra and
                    HF.fecha < TO_DATE(:fecha_actual,'DD/MM/YYYY HH24:MI:SS')  and
                    HF2.fecha > TO_DATE(:fecha_actual,'DD/MM/YYYY HH24:MI:SS')""",id_obra = int(x[0]) , fecha_actual = data2[0][0] ) 
            aux = cursor.fetchall()
            
            if aux:  
                print("ASISTENCIA",aux)
                aux_2 = ["si","no","no"] 
                 
            else:
                aux_2 = "No hay horario para asistencia"
                #verifica si se puede emitir viaticos (Descarga el ultimo calendario de si la obra esta activa)
                cursor.execute("""SELECT O.titulo, TO_CHAR(HF.FECHA,'DD/MM/YYYY HH24:MI:SS')  as fechaInicio, TO_CHAR(HF2.FECHA,'DD/MM/YYYY HH24:MI:SS')  
                    FROM calendario C, horafecha HF, horafecha HF2, obra O
                    WHERE HF.idhorafecha = C.idhorainicio and
                    HF2.idhorafecha = C.idhorafin and
                    O.idobra = C.idobra and
                    O.idobra = :id_obra and
                    O.estado = 1 and
                    HF2.fecha > TO_DATE(:fecha_actual,'DD/MM/YYYY HH24:MI:SS')
                    order by C.idhorafin desc""",id_obra = int(x[0]), fecha_actual = data2[0][0]) 
                
                aux = cursor.fetchall()
                print ("VIATICOS  ",aux)
                if not aux and x[3] == 1:  
                    print ("VIATICOS  ",aux)
                    aux_2 = ["no","si","no"]  
                else:
                    #Verifica si se pueden sacar certificados
                    if x[3] == 0:  
                        aux_2 = ["no","no","si"] 
                     
        else:
            aux_2 = ""

        data4.append(aux_2)
    print(data4)

    data5 = []

    if request.method == 'POST':
        codigo = request.form['codigo']
        obra = request.form['obra']
        print(codigo)
        #descargar opciones 
        if obra == "none":
        #descargar opciones segun el estudiante
            try:          
                cursor.execute("""SELECT * FROM estudiante where idestudiante = :codigo""", codigo = codigo) 
                aux = cursor.fetchall()
                    
                if aux:
                    cursor.execute("""SELECT O.idobra , O.titulo
                        FROM estudiante E, personaje P, PersonajeEstudiante PE, obra O
                        WHERE   E.idestudiante = PE.idestudiante and
                                P.idpersonaje = PE.idpersonaje and
                                O.idobra =  P.idobra and
                                E.idestudiante = :idestudiante
                               """, idestudiante = codigo)  
                    data5 = cursor.fetchall()  
                                      
                else:
                    flash('No participa en ninguna obra el estudiante')  
                    return redirect(url_for('inicio'))          
            except cx_Oracle.Error as error:
                flash('ERROR EN EL SISTEMA')
                print(error)
        else:
            #descargar certificado            
            return redirect(url_for('certi' , idobra = obra , idEstudiante = codigo ))

    return render_template('inicio.html', Docente = data, fechas = data2,  estudiantes = data3 , botones = data4 , opciones = data5 )

@app.route('/asistencia')
def asistencia():
    cursor = connection.cursor()
    # Datos para layout.html
    #titulo de la obra activa (estado=1)
    cursor.execute("SELECT titulo FROM obra WHERE estado like 1")
    data = cursor.fetchall()
    
    #fecha actual
    #print("OBRA: ", data)
    data2 = fecha()

    #Datos para asistencia.html
    #datos de todos los estudiantes que pertenecen a la obra activa (O.estado = 1)
    cursor.execute("""SELECT E.idestudiante, E.idunidad, TO_CHAR(E.fechainscripcion, 'DD/MM/YYYY') insc, TO_CHAR(E.fechanacimiento, 'DD/MM/YYYY') nac, E.correo, E.nombre, E.apellido, O.titulo 
                      FROM estudiante E, PersonajeEstudiante PE, personaje P, obra O
                      WHERE E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            P.idobra = PE.idobra and
                            O.idobra = PE.idobra and
                            (PE.idobra) = (SELECT idobra 
                                           FROM obra
                                           WHERE estado like 1)""")
    data3 = cursor.fetchall()
    print("ESTUDIANTES: ",data3)
    #print(data3)
    global id_empleado
    cursor.execute("""SELECT * FROM empleado where idEmpleado = :id_empleado """,id_empleado = id_empleado)   

    data4 = cursor.fetchall()
    
    return render_template('asistencia.html', obras = data, fechas = data2,  estudiantes = data3, Docente = data4)

def fecha():
    ahora = datetime.datetime.now()
    ahora = ahora.strftime('%d/%m/%Y %H:%M:%S')
    arreglo=[]

    #Fecha real para HOY
    #arreglo.append((ahora,"hoy"))
    
    #Fecha de pruebas 
    arreglo.append(('30/04/2022 09:30:00', 'prueba'))

    print("ACTUAL: ",ahora)
    print("PRUEBA: ", arreglo[0][0])
    return arreglo

@app.route('/asist/<string:id>')
def asistencia_estudiante(id):
    idestudiante = id
    #print("condigo est ",id)
    cursor= connection.cursor()

    #Numero deregistros en tabla asistenciaEstudiante para definir su llave primaria
    cursor.execute('SELECT * FROM asistenciaEstudiante')
    data = cursor.fetchall()
    print("registros: ", len(data))
    idasistencia = len(data) + 1
    
    fecha_actual = fecha()[0][0]
    #Obtener el idcalendario con la fecha actual en una consulta anidada con la tabla horafecha 
    '''
    print("fecha actualllll: ",fecha_actual)
    cursor.execute("""SELECT C.idcalendario 
                      FROM calendario C, horafecha HF, horafecha HF2
                      WHERE HF.idhorafecha = C.idhorainicio and
                      HF2.idhorafecha = C.idhorafin and
                      HF.idhorafecha in (SELECT idhorafecha 
                                         FROM horafecha 
                                         WHERE TO_CHAR(fecha, 'DD/MM/YYYY') like :fecha_actual)""",{'fecha_actual':fecha_actual})
    '''

    cursor.execute("""SELECT C.idcalendario
                      FROM calendario C, horafecha HF, horafecha HF2, obra O, (SELECT idobra FROM obra WHERE estado = 1) T
                      WHERE HF.idhorafecha = C.idhorainicio and
                            HF2.idhorafecha = C.idhorafin and
                            O.idobra = C.idobra and
                            O.idobra = T.idobra and
                            HF.fecha < TO_DATE(:fecha_actual,'DD/MM/YYYY HH24:MI:SS')  and
                            HF2.fecha > TO_DATE(:fecha_actual,'DD/MM/YYYY HH24:MI:SS')""", {'fecha_actual':fecha_actual})   
        #cursor.execute('DELETE FROM usuario WHERE id = {0}.format(id))
    data2 = cursor.fetchall()
    print("idcalendario: ", data2)
    if(len(data2) == 0 ):
        data2 = 'hora invalida'
    idcalendario = data2[0][0]
    #Obtener el idObra con el idestudiante
    print(idestudiante)
    cursor.execute("""SELECT PE.idobra
                      FROM estudiante E, PersonajeEstudiante PE
                      WHERE E.idestudiante = PE.idestudiante and
                            E.idestudiante like :codigo""", {'codigo':idestudiante})
    data3 = cursor.fetchall()
    print("IDE OBRA: ",data3)
    idobra = data3[0][0]

    #registro de asistencia del estudiante 
    try:
        cursor= connection.cursor()
        #cursor.execute("""DELETE FROM asistenciaestudiante""")
        cursor.execute("""SELECT * FROM asistenciaEstudiante""")
        consulta = cursor.fetchall()
        print(len(consulta))
        print(consulta)
        #consulta para verificar la existencia de un idcalendario y un idestudiante en la tabla de asistencia, 
        #para evitar registros repetidos 
        cursor.execute("""SELECT idcalendario
                          FROM AsistenciaEstudiante
                          WHERE idestudiante like :codigo""", {'codigo':idestudiante})
        comprobacion = cursor.fetchall()
        print("comprobacion ",comprobacion)
        print("idcalendario", idcalendario)
        
        if(len(comprobacion) == 0):
            cursor.execute('INSERT INTO asistenciaEstudiante (idAsistenciaEstudiante, idCalendario, idObra, idEstudiante) VALUES (:idAsistenciaEstudiante, :idCalendario, :idObra, :idEstudiante)', 
            (idasistencia, idcalendario, idobra, idestudiante))
            connection.commit()
            flash('Asistencia guardada para el estudiante de codigo '+idestudiante)
        else:
            if(comprobacion[0][0] == idcalendario):
                print("YA EXISTE")
                flash('El estudiante de codigo '+idestudiante+' ya ha sido registrado el dia de hoy')
            else:
                cursor.execute('INSERT INTO asistenciaEstudiante (idAsistenciaEstudiante, idCalendario, idObra, idEstudiante) VALUES (:idAsistenciaEstudiante, :idCalendario, :idObra, :idEstudiante)', 
                (idasistencia, idcalendario, idobra, idestudiante))
                connection.commit() 
                flash('Asistencia guardada para el estudiante de codigo '+idestudiante)
    except cx_Oracle.Error as error:
        flash('ERROR hora o fecha invalida para registro')
        print(error)
    return redirect(url_for('asistencia'))

@app.route('/viaticos')
def viaticos():
    cursor = connection.cursor()
    # Datos para encabezado pdf
    cursor.execute("SELECT titulo FROM obra WHERE estado like 1")
    data = cursor.fetchall()
    data_fecha = fecha()
    # Datos para tabla estudiantes en el pdf
    # Todos los estudiantes de la obra activa
    cursor.execute("""SELECT E.nombre, E.apellido , E.correo, E.idestudiante
                      FROM estudiante E, personaje P, PersonajeEstudiante PE, obra O
                      WHERE E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            O.idobra =  P.idobra and
                            (PE.idobra) = (SELECT idobra 
                                           FROM obra
                                           WHERE estado like 1)
                      ORDER BY E.idestudiante""")
    data2 = cursor.fetchall()
    #print("DATOS ESTUDIANTE: ",data2)

    
    # Todos las asistencias de los estudiantes (numero de sesiones)
    cursor.execute("""SELECT E.idestudiante, count(AE.idestudiante)
                      FROM estudiante E, AsistenciaEstudiante AE, PersonajeEstudiante PE, personaje P, obra O
                      WHERE E.idestudiante = AE.idestudiante and
                            E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            P.idobra = PE.idobra and
                            O.idobra = P.idobra and
                            O.estado = 1
                      GROUP BY E.idestudiante
                      ORDER BY E.idestudiante""")
    data3 = cursor.fetchall()

    data_table = []
    
    # Todoas las horas que participo cada estudiantes (por asistencia)
    cursor.execute("""SELECT AE.idestudiante, sum((HFf.fecha - HFi.fecha)*24) horas
                      FROM AsistenciaEstudiante AE, calendario C, horafecha HFi, horafecha HFf, obra o
                      WHERE C.idcalendario = AE.idcalendario and
                            HFi.idhorafecha = C.idhorainicio and
                            HFf.idhorafecha = C.idhorafin and
                            O.idobra = C.idobra and
                            O.estado = 1
                      GROUP BY AE.idestudiante
                      ORDER BY AE.idestudiante""")
    data4 = cursor.fetchall()

    # Todos los periodos academicos de cada estudiante en los que participo en la obra
    cursor.execute("""SELECT DISTINCT E.idestudiante, P.descperiodo
                      FROM estudiante E, AsistenciaEstudiante AE, calendario C, LaborPersonalObra LPO, ListaActividad LA, periodo P, obra O
                      WHERE E.idestudiante = AE.idestudiante and
                            C.idcalendario = AE.idcalendario and
                            O.idobra = C.idobra and
                            O.estado = 1 and
                            C.idcalendario = LPO.idcalendario and
                            LA.idlistaactividad = LPO.idlistaactividad and
                            P.idperiodo = LA.idperiodo 
                      ORDER BY E.idestudiante""")
    data5 = cursor.fetchall()
    
    for i in range(len(data2)):
        datos_estudiantes = list(data2[i])
        datos_sesiones = list(data3[i])
        datos_horas = list(data4[i])
        #datos_periodo = list(data5[i])

        datos_estudiantes.append(datos_sesiones[1])
        datos_estudiantes.append(datos_horas[1])
        #datos_estudiantes.append(datos_periodo[1])

        data_table.append(tuple(datos_estudiantes))
    print(data_table)
    global id_empleado
    cursor.execute("""SELECT * FROM empleado where idEmpleado = :id_empleado """,id_empleado = id_empleado)   

    data4 = cursor.fetchall()
    return render_template('viaticos.html', obras = data, fechas = data_fecha,Docente = data4,  estudiantes = data_table )


@app.route('/viaticos/<string:id>')
def viaticos_estudiantes(id):
    idestudiante = id

    cursor= connection.cursor()
    cursor.execute('SELECT * FROM asistenciaEstudiante')
    data = cursor.fetchall()

    return redirect(url_for('viaticos'))



@app.route('/certificados/<string:id>')
def certificados(id):
    cursor = connection.cursor()
    # Datos para layout.html
    cursor.execute("""SELECT titulo , idObra  FROM obra WHERE idObra = :idobra""",idobra = id)
    data = cursor.fetchall()
    print("OBRA ",data)

    global id_empleado
    cursor.execute("""SELECT * FROM empleado where idEmpleado = :id_empleado """,id_empleado = id_empleado)   
    data5 = cursor.fetchall() 

    data2 = fecha()

    
    cursor.execute("""SELECT E.idestudiante, E.nombre || ' ' || E.apellido, E.correo, P.nombre personaje
                      FROM estudiante E, unidad U, personaje P, PersonajeEstudiante PE, obra O
                      WHERE U.idunidad = E.idunidad and
                            E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            O.idobra =  P.idobra and
                            (PE.idobra) = (SELECT idobra 
                                           FROM obra
                                           WHERE idobra = :idobra)
                                           ORDER BY E.idestudiante""",idobra = id)

    data3 = cursor.fetchall()

        # Todoas las horas que participo cada estudiantes (por asistencia)
    cursor.execute("""SELECT AE.idestudiante, sum((HFf.fecha - HFi.fecha)*24) horas
                      FROM AsistenciaEstudiante AE, calendario C, horafecha HFi, horafecha HFf, obra o
                      WHERE C.idcalendario = AE.idcalendario and
                            HFi.idhorafecha = C.idhorainicio and
                            HFf.idhorafecha = C.idhorafin and
                            O.idobra = C.idobra and
                            O.idobra = :idobra                                          
                      GROUP BY AE.idestudiante
                      ORDER BY AE.idestudiante""", idobra = id)
    data4 = cursor.fetchall()

    data_table = []
    
    for i in range(len(data3)):
        datos_estudiantes = list(data3[i])
        datos_horas = list(data4[i])

        datos_estudiantes.append(datos_horas[1])

        data_table.append(tuple(datos_estudiantes))
    print(data_table)
    print("ESTUDIANTES ",len(data3))
    #print(data3)

    

    return render_template('certificados.html', obras = data, fechas = data2,  estudiantes = data_table , Docente = data5 )

@app.route('/certi/<string:idobra>/<string:idEstudiante>')
def certi(idobra , idEstudiante):
    cursor = connection.cursor()
    # Datos para encabezado pdf
    cursor.execute("""SELECT titulo FROM obra WHERE idObra = :idobra""",idobra = idobra)
    data = cursor.fetchall()

    # Datos para tabla estudiantes en el pdf
    # Todos los estudiantes de la obra activa
    cursor.execute("""SELECT E.nombre, E.apellido , E.correo, E.idestudiante , P.nombre 
                      FROM estudiante E, personaje P, PersonajeEstudiante PE, obra O
                      WHERE E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            O.idobra =  P.idobra and
                            E.idestudiante = :idEstudiante and 
                            (PE.idobra) = (SELECT idobra 
                                           FROM obra
                                           WHERE idObra = :idobra)
                      ORDER BY E.idestudiante""", idobra = idobra , idEstudiante = idEstudiante)
    data2 = cursor.fetchall()
    print("DATOS ESTUDIANTE: ",data2)

    
    # Todos las asistencias de los estudiantes (numero de sesiones)
    cursor.execute("""SELECT E.idestudiante, count(AE.idestudiante)
                      FROM estudiante E, AsistenciaEstudiante AE, PersonajeEstudiante PE, personaje P, obra O
                      WHERE E.idestudiante = AE.idestudiante and
                            E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            P.idobra = PE.idobra and
                            O.idobra = P.idobra and
                            E.idestudiante = :idEstudiante and
                            O.idObra = :idobra
                      GROUP BY E.idestudiante
                      """, idobra = idobra , idEstudiante = idEstudiante)
    data3 = cursor.fetchall()
    print("DATOS cantidad: ",data3)
    data_table = []
    
    # Todoas las horas que participo cada estudiantes (por asistencia)
    cursor.execute("""SELECT AE.idestudiante, sum((HFf.fecha - HFi.fecha)*24) horas
                      FROM AsistenciaEstudiante AE, calendario C, horafecha HFi, horafecha HFf, obra o
                      WHERE C.idcalendario = AE.idcalendario and
                            HFi.idhorafecha = C.idhorainicio and
                            HFf.idhorafecha = C.idhorafin and
                            O.idobra = C.idobra and
                            AE.idestudiante = :idEstudiante and
                            O.idObra = :idobra
                      GROUP BY AE.idestudiante
                      ORDER BY AE.idestudiante""",idobra = idobra , idEstudiante = idEstudiante)
    data4 = cursor.fetchall()

    print("DATOS horas: ",data4)

    # Todos los periodos academicos de cada estudiante en los que participo en la obra
    cursor.execute("""SELECT DISTINCT E.idestudiante, P.descperiodo
                      FROM estudiante E, AsistenciaEstudiante AE, calendario C, LaborPersonalObra LPO, ListaActividad LA, periodo P, obra O
                      WHERE E.idestudiante = AE.idestudiante and
                            C.idcalendario = AE.idcalendario and
                            O.idobra = C.idobra and
                            O.idObra = :idobra and
                            E.idestudiante = :idEstudiante and
                            C.idcalendario = LPO.idcalendario and
                            LA.idlistaactividad = LPO.idlistaactividad and
                            P.idperiodo = LA.idperiodo 
                      ORDER BY E.idestudiante""",idobra = idobra , idEstudiante = idEstudiante)
    data5 = cursor.fetchall()

    print("DATOS periodos: ",data5)
    
    for i in range(len(data2)):
        datos_estudiantes = list(data2[i])
        if data3:
            datos_sesiones = list(data3[i])
            datos_horas = list(data4[i])
            datos_periodo = list(data5[i])
        else:
            datos_sesiones = ["0","0"]
            datos_horas = ["0","0"]
            datos_periodo = ["-","-"]
        

        datos_estudiantes.append(datos_sesiones[1])
        datos_estudiantes.append(datos_horas[1])
        datos_estudiantes.append(datos_periodo[1])

        data_table.append(tuple(datos_estudiantes))

    #datos para el encabezado
    cursor.execute("""SELECT O.titulo, TO_CHAR(min(HFi.fecha),'DD/MM/YYYY'), TO_CHAR(max(HFf.fecha),'DD/MM/YYYY') , E.nombre ||' ' || E.apellido
                      FROM obra O, calendario C, horafecha HFi, horafecha HFf, ListaActividad LA , LaborPersonalObra LP , PersonalObra PO , empleado E
                      WHERE O.idobra = C.idobra and
                            HFi.idhorafecha = C.idhorainicio and
                            HFf.idhorafecha = C.idhorafin and
                            LA.idListaActividad = 10 and
                            LP.idListaActividad = LA.idListaActividad and
                            LP.idPersonalObra = PO.idPersonalObra and
                            E.idempleado = PO.idempleado and
                            O.idObra = :idobra
                      GROUP BY O.titulo, E.nombre ||' ' || E.apellido""",idobra = idobra)
    data_header = cursor.fetchall()
    
    #datos para el pie de pagina
    global id_empleado
   
    cursor.execute("""SELECT E.nombre, E.apellido, E.cedula, U3.nombre
                      FROM empleado E, unidad U, unidad U2, unidad U3
                      WHERE U.idunidad = E.idunidad and
                            U2.idunidad = U.uni_idunidad and
                            U3.idunidad = U2.uni_idunidad and
                            E.idempleado = :cedula""", {'cedula':id_empleado})
    data_footer = cursor.fetchall()

    #data_table = data2[0]+data3[0][1]+data4[0][1]+data5[0][1]
    print("DATOS DE LA TABLA PDF: ", data_footer)
    ruta_template = 'C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/templates/pdf/pdf_certi.html'
    info = {}
    rutacss = 'C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/templates/pdf/css/style.css'
    crea_pdf(ruta_template, info, data_header, data_table, data_footer, 'certificado.pdf', rutacss)

    return redirect(url_for('inicio'))


@app.route('/viaticos_pdf')
def viaticos_pdf():
    cursor = connection.cursor()
    # Datos para encabezado pdf
    cursor.execute("SELECT titulo FROM obra WHERE estado like 1")
    data = cursor.fetchall()

    # Datos para tabla estudiantes en el pdf
    # Todos los estudiantes de la obra activa
    cursor.execute("""SELECT E.nombre, E.apellido , E.correo, E.idestudiante
                      FROM estudiante E, personaje P, PersonajeEstudiante PE, obra O
                      WHERE E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            O.idobra =  P.idobra and
                            (PE.idobra) = (SELECT idobra 
                                           FROM obra
                                           WHERE estado like 1)
                      ORDER BY E.idestudiante""")
    data2 = cursor.fetchall()
    #print("DATOS ESTUDIANTE: ",data2)

    
    # Todos las asistencias de los estudiantes (numero de sesiones)
    cursor.execute("""SELECT E.idestudiante, count(AE.idestudiante)
                      FROM estudiante E, AsistenciaEstudiante AE, PersonajeEstudiante PE, personaje P, obra O
                      WHERE E.idestudiante = AE.idestudiante and
                            E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            P.idobra = PE.idobra and
                            O.idobra = P.idobra and
                            O.estado = 1
                      GROUP BY E.idestudiante
                      ORDER BY E.idestudiante""")
    data3 = cursor.fetchall()

    data_table = []
    
    # Todoas las horas que participo cada estudiantes (por asistencia)
    cursor.execute("""SELECT AE.idestudiante, sum((HFf.fecha - HFi.fecha)*24) horas
                      FROM AsistenciaEstudiante AE, calendario C, horafecha HFi, horafecha HFf, obra o
                      WHERE C.idcalendario = AE.idcalendario and
                            HFi.idhorafecha = C.idhorainicio and
                            HFf.idhorafecha = C.idhorafin and
                            O.idobra = C.idobra and
                            O.estado = 1
                      GROUP BY AE.idestudiante
                      ORDER BY AE.idestudiante""")
    data4 = cursor.fetchall()

    # Todos los periodos academicos de cada estudiante en los que participo en la obra
    cursor.execute("""SELECT DISTINCT E.idestudiante, P.descperiodo, C.idcalendario
                      FROM estudiante E, AsistenciaEstudiante AE, calendario C, LaborPersonalObra LPO, ListaActividad LA, periodo P, obra O
                      WHERE E.idestudiante = AE.idestudiante and
                            C.idcalendario = AE.idcalendario and
                            O.idobra = C.idobra and
                            O.estado = 1 and
                            C.idcalendario = LPO.idcalendario and
                            LA.idlistaactividad = LPO.idlistaactividad and
                            P.idperiodo = LA.idperiodo 
                      ORDER BY E.idestudiante""")
    data5 = cursor.fetchall()
    
    for i in range(len(data2)):
        datos_estudiantes = list(data2[i])
        datos_sesiones = list(data3[i])
        datos_horas = list(data4[i])
        #datos_periodo = list(data5[i])

        datos_estudiantes.append(datos_sesiones[1])
        datos_estudiantes.append(datos_horas[1])
        datos_estudiantes.append('1')

        data_table.append(tuple(datos_estudiantes))

    #datos para el encabezado
    cursor.execute("""SELECT O.titulo, TO_CHAR(min(HFi.fecha),'DD/MM/YYYY'), TO_CHAR(max(HFf.fecha),'DD/MM/YYYY')
                      FROM obra O, calendario C, horafecha HFi, horafecha HFf
                      WHERE O.idobra = C.idobra and
                            HFi.idhorafecha = C.idhorainicio and
                            HFf.idhorafecha = C.idhorafin and
                            O.estado = 1
                      GROUP BY O.titulo""")
    data_header = cursor.fetchall()
    
    #datos para el pie de pagina
    global id_empleado
    print("Docente: ", id_empleado)
    cursor.execute("""SELECT E.nombre, E.apellido, E.cedula, U3.nombre
                      FROM empleado E, unidad U, unidad U2, unidad U3
                      WHERE U.idunidad = E.idunidad and
                            U2.idunidad = U.uni_idunidad and
                            U3.idunidad = U2.uni_idunidad and
                            E.idempleado = :cedula""", {'cedula':id_empleado})
    data_footer = cursor.fetchall()

    #data_table = data2[0]+data3[0][1]+data4[0][1]+data5[0][1]
    print("DATOS DE LA TABLA PDF: ", data_footer)
    ruta_template = 'C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/templates/pdf/pdf.html'
    info = {}
    rutacss = 'C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/templates/pdf/css/style.css'
    crea_pdf(ruta_template, info, data_header, data_table, data_footer, 'liquidacion.pdf', rutacss)

    
    cursor.execute("""UPDATE obra set estado='0' where idobra = '2'""")
    #update = cursor.fetchall()
    connection.commit()
    

    return redirect(url_for('login'))



def crea_pdf(ruta_template, info, data_header, data_table, data_footer, file_name, rutacss=''):
    nombre_template = ruta_template.split('/')[-1]
    ruta_template = ruta_template.replace(nombre_template,'')
   
    env = jinja2.Environment(loader = jinja2.FileSystemLoader(ruta_template))
    template = env.get_template(nombre_template)
    html = template.render(obras = data_header, estudiantes = data_table, docentes = data_footer)
    #open(file_name,'wb')
    path_wkhtmltopdf = r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'
    config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)
    #ruta_salida = 'C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/LIQUIDACION.pdf'
    pdfkit.from_string(html, file_name, css=rutacss, configuration = config)
    
    
    #sin estilos
    #pdfkit.from_string(html, 'liquidacionn.pdf', configuration = config)

    #pdf = pdfkit.from_file('templates\pdf\pdf.html', 'micro.pdf', configuration=config)
    #print(type(pdf))


@app.route('/add_contact', methods=['POST'])
def add_contact():
    if request.method == 'POST':
        codigo = request.form['codigo']
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        tipoDoc = request.form['tipoDoc']
        numeroDoc = request.form['numeroDoc']
        correo = request.form['correo']
        #carrera = request.form['carrera']

        carrera = request.form['carrera']
        print("PRUEBA  : "+carrera)

        hora = 480

        cursor = connection.cursor()
        cursor.execute("SELECT * FROM estudiante")
        data = cursor.fetchall()
        
        print("tamanio ", size(data))
        hora = hora + (size(data)/7)*20
        horas = hora // 60
        minutos = (hora / 60) - horas
        minutos = int(minutos * 60)
        enviar_correo(nombre,codigo,correo,horas,minutos)

        try:
            #carrera = '20'
            #tipoDoc= '1'
            codigo = int(codigo)
            cursor= connection.cursor()
            cursor.execute('INSERT INTO estudiante (codigo, nombre, apellido, idTipoDocumento, numeroDocumento, idCarrera, correo) VALUES (:codigo, :nombre, :apellido, :tipoDoc, :numeroDoc, :carrera, :correo)', 
            (codigo, nombre, apellido, tipoDoc, numeroDoc, carrera, correo))
            #sqlInsPerson = "insert into person (idnumber, names, surname, idtype, email, birth) values (:_number_id ,:_names, :_surnames, :_type_doc, :_email, TO_DATE(:_birth_date,'YYYY/MM/DD'));"
            connection.commit()
            flash('Contacto Agregado')
        except cx_Oracle.Error as error:
            flash('ERROR: Codigo ya existente')
            print(error)
        
    return redirect(url_for('index'))

@app.route('/edit/<id>')
def get_contact(id):
    cursor = connection.cursor()
    print("NUMERO "+id)
    id = id+" "
    cursor.execute('SELECT * FROM estudiante WHERE codigo = :codigo',{'codigo':id})
    data = cursor.fetchall()

    return render_template('edit-contact.html', estudiante = data[0])

@app.route('/update/<id>', methods= ['POST'])
def update_contact(id):
    if request.method == 'POST':
        fullname = request.form['fullname']
        phone = request.form['phone']
        email = request.form['email']
        cursor = connection.cursor()
        cursor.execute('UPDATE usuario SET fullname = %s, phone = %s, email = %s WHERE phone = %s', (fullname, email, phone, id))
        
        
        connection.commit()
        flash('Contacto actualizado')
    return redirect(url_for('index'))




@app.route('/delete/<string:id>')
def delete_contact(id):
    cursor= connection.cursor()
    cursor.execute('DELETE FROM estudiante WHERE codigo = :codigo',{'codigo':id})
    #cursor.execute('DELETE FROM usuario WHERE id = {0}.format(id))
    connection.commit()
    flash('Usuario removido')
    return redirect(url_for('index'))


def enviar_correo(nombre, codigo, correo, horas, minutos):
    print("MINUTOS ",minutos)
    if minutos < 10:
        minutos = "0"+str(minutos)
    horario=str(int(horas))+":"+str(minutos)
    print(horario)
    hoy = datetime.date.today()

    fecha_cita = hoy + datetime.timedelta(1)
    mensaje = ('Buen dia, se le informa al estudiante '+nombre+' de codigo '+codigo+' que su cita para la audicion esta agendada para la fecha '+ fecha_cita.strftime('%d/%m/%Y') +' a las '+horario)
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login('correo.base.de.datos.uno@gmail.com', 'basededatos')  
    msg = 'Subject: {}\n\n{}'.format("Obra de teatro", mensaje)  
    server.sendmail('correo.base.de.datos.uno@gmail.com', correo, msg) 
    server.quit()


if __name__=='__main__':
    app.run(port = 3000, debug = True)