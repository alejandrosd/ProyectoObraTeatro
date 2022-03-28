from urllib import request
import cx_Oracle
from numpy import full, size
import config
from flask import Flask, render_template, request, redirect, url_for, flash
import datetime

import smtplib


app = Flask(__name__)



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
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM estudiante")
    data = cursor.fetchall()
    
    cursor.execute("SELECT * FROM carrera")
    data2 = cursor.fetchall()

    cursor.execute("SELECT * FROM documento")
    data3 = cursor.fetchall()

    print("tamanio ", size(data))
    return render_template('index.html', estudiantes = data, carreras = data2, tiposdocumentos = data3)


@app.route('/inicio')
def inicio():
    cursor = connection.cursor()
    cursor.execute("SELECT titulo FROM obra WHERE estado like 1")
    #cursor.execute("SELECT * FROM obra")
    data = cursor.fetchall()
    print("OBRA: ", data)
    data2 = fecha()
    return render_template('layout.html', obras = data, fechas = data2)

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
    #print("ESTUDIANTES: ",len(data3))
    #print(data3)

    return render_template('asistencia.html', obras = data, fechas = data2,  estudiantes = data3 )

def fecha():
    ahora = datetime.datetime.now()
    ahora = ahora.strftime('%d/%m/%Y')
    arreglo=[]

    #Fecha real para HOY
    #arreglo.append((ahora,"hoy"))
    
    #Fecha de pruebas 
    arreglo.append(('31/03/2022', 'prueba'))
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

    #Obtener el idcalendario con la fecha actual en una consulta anidada con la tabla horafecha 
    fecha_actual = fecha()[0][0]
    print("fecha actualllll: ",fecha_actual)
    cursor.execute("""SELECT C.idcalendario 
                      FROM calendario C, horafecha HF, horafecha HF2
                      WHERE HF.idhorafecha = C.idhorainicio and
                      HF2.idhorafecha = C.idhorafin and
                      HF.idhorafecha in (SELECT idhorafecha 
                                         FROM horafecha 
                                         WHERE TO_CHAR(fecha, 'DD/MM/YYYY') like :fecha_actual)""",{'fecha_actual':fecha_actual})
        #cursor.execute('DELETE FROM usuario WHERE id = {0}.format(id))
    data2 = cursor.fetchall()
    print("idcalendario: ", data2)
    idcalendario = data2[0][0]
    print("inicio",data2[0][0])
    print("fin",data2[0][1])
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
        flash('ERROR')
        print(error)
    return redirect(url_for('asistencia'))

@app.route('/viaticos')
def viaticos():
    cursor = connection.cursor()
    # Datos para layout.html
    cursor.execute("SELECT titulo FROM obra WHERE estado like 1")
    data = cursor.fetchall()
    
    print("OBRA: ", data)
    data2 = fecha()

    #Datos para asistencia.html
    cursor.execute("""SELECT E.idestudiante, E.nombre, E.apellido, E.correo, O.titulo, P.nombre personaje, (PE.horafin - PE.horainicio)*24 horas
                      FROM estudiante E, unidad U, personaje P, PersonajeEstudiante PE, obra O
                      WHERE U.idunidad = E.idunidad and
                            E.idestudiante = PE.idestudiante and
                            P.idpersonaje = PE.idpersonaje and
                            O.idobra =  P.idobra and
                            (PE.idobra) = (SELECT idobra 
                                           FROM obra
                                           WHERE estado like 1)""")
    data3 = cursor.fetchall()
    print("ESTUDIANTES: VIATICOS ",len(data3))
    #print(data3)
    return render_template('viaticos.html', obras = data, fechas = data2,  estudiantes = data3 )


@app.route('/viaticos/<string:id>')
def viaticos_estudiantes(id):
    idestudiante = id

    cursor= connection.cursor()
    cursor.execute('SELECT * FROM asistenciaEstudiante')
    data = cursor.fetchall()

    return redirect(url_for('viaticos'))



@app.route('/certificados')
def certificados():
    cursor = connection.cursor()
    # Datos para layout.html
    cursor.execute("SELECT titulo FROM obra WHERE estado like 1")
    data = cursor.fetchall()
    print("OBRA: ", data)

    data2 = fecha()

    #Datos para asistencia.html
    cursor.execute("""SELECT TRIM(O.titulo), NVL2(PART.empleado,'Participó', 'No participó')
                      FROM obra O, (SELECT O.titulo titulo, O.estado estado, LPO.idempleado empleado
                                  FROM obra O, calendario C, LaborPersonalObra LPO
                                  WHERE O.idobra = C.idobra and
                                          C.idcalendario = LPO.idcalendario and
                                          C.idobra = LPO.idobra and
                                          LPO.idempleado like 1) PART
                    WHERE O.titulo = PART.titulo(+)""")

    data3 = cursor.fetchall()
    print("DOCENTES ",len(data3))
    #print(data3)
    return render_template('certificados.html', obras = data, fechas = data2,  estudiantes = data3 )

@app.route('/certificados/<string:id>')
def certificados_estudiantes(id):
    idestudiante = id

    cursor= connection.cursor()
    cursor.execute('SELECT * FROM ')
    data = cursor.fetchall()

    return redirect(url_for('certificados'))


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