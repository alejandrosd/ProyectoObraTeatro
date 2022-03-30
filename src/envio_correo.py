#from email.mime.multipart import MIMEMultipart
#from email.mime.base import MIMEBase
from smtplib import SMTP


from mmap import PAGESIZE
import smtplib
import getpass 
import time
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from email.message import EmailMessage

'''

from_ = 'correo.base.de.datos.uno@gmail.com'

to = 'basededatosunoprueba123'
# put the email of the receiver here
receiver = 'luisocampo2001.o.g@gmail.com'
 
msg = MIMEMultipart()

with open('liquidacion.pdf', "rb") as binary_file:
    # Write bytes to file
    binary_file.read()
    print("HPTA ", binary_file)
    decoded_output = binary_file.stdout.decode('us-ascii')
    msg = MIMEText(decoded_output)
    msg.attach(MIMEText(binary_file))

mailer = smtplib.SMTP()
mailer.connect()
mailer.sendmail(from_, to, msg.as_string())
mailer.close()
'''


''''''

#mensaje = MIMEMultipart("plain")
mensaje = EmailMessage()
mensaje["From"] = "correo.base.de.datos.uno@gmail.com" #, 'basededatos'
mensaje["To"] = "luisocampo2001.o.g@gmail.com"
mensaje["Subject"] = "Correo de prueba desde python"

with open('liquidacion.pdf', 'rb') as f:
    file_data = f.read()
    file_name = f.name
mensaje.add_attachment(file_data, maintype='application', subtype='octet-stream', filename=file_name)

smtp = SMTP("smtp.gmail.com")
smtp.starttls()

smtp.login("correo.base.de.datos.uno@gmail.com" , "basededatosunoprueba123")
smtp.sendmail("correo.base.de.datos.uno@gmail.com" ,"luisocampo2001.o.g@gmail.com", mensaje.as_string())
smtp.quit() 