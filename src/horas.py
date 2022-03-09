import datetime

hoy = datetime.date.today()

fecha_cita = hoy + datetime.timedelta(1)


hora = 480
hora = hora + (3)*25
horas = hora // 60
minutos = (hora / 60) - horas
minutos = int(minutos * 60)
print(" horas ", horas," minutos ",minutos," de ", fecha_cita.strftime('%d/%m/%Y'))