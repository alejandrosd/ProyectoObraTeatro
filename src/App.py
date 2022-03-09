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

if __name__=='__main__':
    app.run(port = 3000, debug = True)