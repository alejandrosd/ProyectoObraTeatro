from distutils.log import info
import jinja2
import pdfkit

def crea_pdf(ruta_template, info, rutacss=''):
    nombre_template = ruta_template.split('/')[-1]
    ruta_template = ruta_template.replace(nombre_template,'')

    print(nombre_template)
    print(ruta_template)
    
    env = jinja2.Environment(loader = jinja2.FileSystemLoader(ruta_template))
    template = env.get_template(nombre_template)
    html = template.render(info)
    print(html)
    
    path_wkhtmltopdf = r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'
    config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)
    ruta_salida = 'C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/LIQUIDACION.pdf'
    pdfkit.from_string(html, ruta_salida,css= ,configuration = config )

if __name__ == "__main__":
    ruta_template = './pdf/pdf.html'
    ruta_template = 'C:/Users/luiso/OneDrive/Desktop/Proyecto_fina_bases/Modulo_bases_datos/ProyectoObraTeatro/src/templates/pdf/pdf.html'
    info = {}
    crea_pdf(ruta_template, info)