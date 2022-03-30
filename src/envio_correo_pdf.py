from email.mime.base import MIMEBase
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication
from os.path import basename
import email
import email.mime.application
from email import encoders
from email.message import EmailMessage
#import PyPDF2
#from pyPdf import PdfFileReader




    

def correo():   
    #MAIL BODY
    
    html = """
     
    Dear Student,<br><br>
     
    Please Find Attached.<br><br> 
     
     
    Best Regards,<br>
    LEARNTRICKS
    """
     
    # Creating message.
    #msg = MIMEMultipart('alternative')
    #msg = MIMEMultipart('application/pdf')
    #msg = EmailMessage()
    outer = MIMEMultipart()
    msg = EmailMessage()
    outer['Subject'] = "Result"
    outer['From'] = "correo.base.de.datos.uno@gmail.com" 
    outer['To'] = "luisocampo2001.o.g@gmail.com"
     
    # The MIME types for text/html
    HTML_Contents = MIMEText(html, 'html')
    
    filename = 'liquidacion.pdf'
    
    fo=open(filename,'rb')

    #fo = PdfFileReader(open("liquidacion.pdf", "rb"))

    #msg = MIMEBase('application', 'octet-stream')
    #msg.set_payload((fo.read()))
    #fo.close()
    #encoders.encode_base64(msg)
    #msg.add_header('Content-Disposition', 'attachment', filename='prueba.pdf')
    file_data = MIMEText(open("C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/liquidacion.pdf",encoding="utf-8", errors='ignore').read())
    #outer.attach(file_data)
    msg.add_attachment(file_data, subtype='octet-stream', filename=filename)
    msg.add_header('Content-Disposition', 'attachment', filename='prueba.pdf')
    outer.attach(msg)
    #attach = email.mime.application.MIMEApplication(fo.read(),_subtype="pdf")
    #fo.close()

    #with open(filename, 'wb') as fp:
    #    file_data = fp.read

    #print("filed ",file_data)


    #msg.add_attachment(file_data, maintype='application', subtype='pdf')

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    server.starttls()
    #server.connect()
    server.login('correo.base.de.datos.uno@gmail.com' , 'basededatosunoprueba123')  #EMAIL PASSOWRD HERE
    #server.sendmail()
    #server.sendmail(msg['From'], msg['To'], msg.as_string())
    server.sendmail(outer['From'], outer['To'], outer.as_string())
    server.quit()

def otro():
    attach = MIMEBase('application/pdf', 'octet-stream')

    

    #attach = MIMEApplication(open(filename, "rb").read())
    #print(attach)
    encoders.encode_base64(attach)

    attach.add_header('Content-Disposition','attachment',filename=filename)
     
    # Attachment and HTML to body message.
    msg.attach(attach)
    #msg.attach(HTML_Contents)
    
    # Your SMTP server information
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    server.starttls()
    server.login('correo.base.de.datos.uno@gmail.com' , 'basededatosunoprueba123')  #EMAIL PASSOWRD HERE
    server.sendmail(msg['From'], msg['To'], msg.as_string())
    server.quit()

correo()