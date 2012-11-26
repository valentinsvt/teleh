package teleh

class PersonaAdmController extends teleh.seguridad.Shield {

    def index() { }

    def list() {
        if (!params.id) {
            params.id = 1
        }
        if (!params.provincia || params.provincia == "") {
            params.provincia = null
        }
        if (!params.estado || params.estado == "") {
            params.estado = null
        }
        if (!params.max || params.max == 0) {
            params.max = 100
        } else {
            params.max = params.max.toInteger()
        }
        if (!params.offset) {
            params.offset = 0
        } else {
            params.offset = params.offset.toInteger()
        }
        if (!params.sort) {
            params.sort = "apellido"
        }
        if (!params.order) {
            params.order = "asc"
        }

//        println params
        def c = Persona.createCriteria()
        def results = c.list(max: params.max, offset: params.offset) {
            and {
                eq("convocatoria", Convocatoria.get(params.id.toLong()))
                if (params.provincia) {
                    eq("provincia", Provincia.get(params.provincia.toLong()))
                }
                if (params.estado) {
                    eq("estado", Estado.get(params.estado.toLong()))
                }
                if (params.busqueda) {
                    or {
                        ilike("cedula", "%" + params.busqueda + "%")
                        ilike("nombre", "%" + params.busqueda + "%")
                        ilike("apellido", "%" + params.busqueda + "%")
                    }
                }
                order(params.sort, params.order)
            }
        }

        params.totalRows = results.totalCount
//        params.totalPags = Math.ceil(params.totalRows / params.max).toInteger()

//        if (!params.pag) {
////            params.pag = 1;
//        } else {
//            params.pag = params.pag.toInteger()
//        }
//
//        if (params.totalPags <= 10) {
//            params.first = 1
//            params.last = params.last = params.totalPags
//        } else {
//            params.first = Math.max(1, params.pag.toInteger() - 5)
//            params.last = Math.min(params.totalPags, params.pag + 5)
//
//            def ts = params.last - params.first
//            if (ts < 9) {
//                def r = 10 - ts
//                params.last = Math.min(params.totalPags, params.last + r).toInteger()
//            }
//        }

        [personaInstanceList: results, params: params]
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


    def titulo_ajax() {
        def personaInstance = new Persona(params)
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Persona con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [personaInstance: personaInstance]
    } //form_ajax


    def uploadTitulo() {
        def archivo = request.getFile("tituloArchivo")
        // List of OK mime-types
        def okcontents = ['image/png', 'image/jpeg', 'image/gif', 'application/pdf']
        if (!okcontents.contains(archivo.getContentType())) {
            flash.clase = "alert-error"
            flash.message = "El archivo del titulo debe ser de tipo ${okcontents}"
            redirect(action: 'list')
            return;
        }
        params.tipoArchivo = archivo.getContentType()
        def titulo
        def persona = Persona.get(params.persona.id)
        def tituloExistente = TituloPersona.findAllByPersona(persona)
        if (tituloExistente.size() == 0) {
            titulo = new TituloPersona()
        } else if (tituloExistente.size() == 1) {
            titulo = tituloExistente[0]
        } else {
            flash.clase = "alert-error"
            flash.message = "Error grave"
        }
        titulo.properties = params
        if (titulo.save(flush: true)) {
            flash.clase = "alert-success"
            flash.message = "Se ha cargado correctamente el título de la Persona " + persona.nombre + " " + persona.apellido
        } else {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar el título de la Persona " + persona.nombre + " " + persona.apellido + "</h4>"

            str += "<ul>"
            titulo.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex {  arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
        }
        redirect(action: 'list')
    }

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
