package teleh

class PersonaAdmController extends teleh.seguridad.Shield {

    def index() { }

    def list() {
        if (!params.convocatoria) {
            params.convocatoria = 1
        }
        [personaInstanceList: Persona.findAllByConvocatoria(Convocatoria.get(params.convocatoria), params), params: params]
    }

    def cambiaConvocatoria() {
        def conv = Convocatoria.get(params.id)
        def personas = Persona.findAllByConvocatoria(conv)
        return [personaInstanceList: personas]
    }

    def show_ajax() {
        def personaInstance = Persona.get(params.id)
        if (!personaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Persona con id " + params.id
            redirect(action: "list")
            return
        }
        [personaInstance: personaInstance]
    } //show

    def verTitulo() {
        def persona = Persona.get(params.id)

        return [persona: persona]
    }

    def cambiarEstado() {
        def persona = Persona.get(params.id)
        if (params.estado == "S") {
            sendMail {
                to persona.email
                from "info@infa.gob.ec"
                subject "Archivo de título"
                html g.render(template: "subir_titulo", model: [prsn: persona])
            }
            render "OK_" + (persona.estado ? persona.estado.descripcion : "")
        } else {
            def estado = Estado.findByCodigo(params.estado)
            persona.estado = estado
            if (persona.save(flush: true)) {
                render "OK_" + estado.descripcion
            } else {
                render "NO"
            }
        }
    }

    def verArchivoTitulo() {
        def tituloPersona = TituloPersona.findByPersona(Persona.get(params.id))

        if (!tituloPersona || !tituloPersona.tituloArchivo || !tituloPersona.tipoArchivo) {
            response.sendError(404)
            return;
        }
        response.setContentType(tituloPersona.tipoArchivo)
        response.setContentLength(tituloPersona.tituloArchivo.size())
        OutputStream out = response.getOutputStream();
        out.write(tituloPersona.tituloArchivo);
        out.close();
    }

}
