from pdf_mail import sendpdf

k = sendpdf("correo.base.de.datos.uno@gmail.com",
            "luisocampo2001.o.g@gmail.com",
            "basededatosunoprueba123",
            "Certificado Obra de Teatro",
            "Buenas, se le certifica la participacion en la obra de teatro con el siguiente documento",
            "certificado",
            "C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/",
            )

k.email_send()