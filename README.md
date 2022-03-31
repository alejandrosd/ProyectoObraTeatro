# ProyectoObraTeatro
Aplicacion web para gestion de obras de teatro, con modulo para registrar asistencia de los estudiantes, liquidar los viaticos de los mismos y generar un certificado para cada estudiante que participó en una obra de teatro


GUIA INSTALACION  
La plataforma fue construida en Python, implementando el framework FLASK y diferentes librearías para el manejo de PDF (creacion y envio).

1. Instalar versión de Oracle 11.g en adelante
2. Instalar Python (versión 3.7 en adelante)
3. Instalar herramienta PIP en el PATH de windows
4. Instalar librería Oracle para conexión a la base de datos:
        pip install cx_Oracle
5. Instalar entorno Flask
        pip install flask
6. Instalar entorno numpy
        pip install numpy
6. Instalar herramienta pdf_mail
        pip install pdf_mail
7. Instalar herramienta pdfkit
        pip install pdfkit
8.Instalar software de wkhtmltopdf  
        https://github.com/JazzCore/python-pdfkit/wiki/Installing-wkhtmltopdf
9. Instalar el Script de la estructura de la base de datos
	scriptTablas.sql
10. Instalar el Script con los datos Base para la plataforma
	scriptDB_temporal.sql
11. Crear un usuario en la base de datos de Oracle
	username = 'obra01'
        password = 'clave01'
12. Cargar el proyecto en algún IDE para Python (Visual Basic) y correr el archivo app.py
13. Abrir el localhost en el puerto 3000 del navegador




## Tecnologías
El proyecto fue creado con:
* Python==3.9.5
* Flask==2.0.3
* HTML
* CSS
* Oracle Database==11.2.0.2.0 (Oracle 11g)
* cx_Oracle
* wkHTMLtoPDF

___
## Recursos
