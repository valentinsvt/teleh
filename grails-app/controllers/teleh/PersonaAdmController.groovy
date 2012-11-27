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
        if (!params.datos) {
            params.datos = "-1"
        }

        def conv, prov, est

        conv = Convocatoria.get(params.id.toLong())
        if (params.provincia) {
            prov = Provincia.get(params.provincia.toLong())
        }
        if (params.estado) {
            est = Estado.get(params.estado.toLong())
        }

//        println params
        def c = Persona.createCriteria()
        def results = c.list(max: params.max, offset: params.offset) {
            and {
                eq("convocatoria", conv)
                if (params.provincia) {
                    eq("provincia", prov)
                }
                if (params.estado) {
                    eq("estado", est)
                }
                if (params.busqueda) {
                    or {
                        ilike("cedula", "%" + params.busqueda + "%")
                        ilike("nombre", "%" + params.busqueda + "%")
                        ilike("apellido", "%" + params.busqueda + "%")
                    }
                }
                if (params.datos == "0") { //sin datos: no nombre ni apellido
                    isNull("nombre")
                    isNull("apellido")
                } else if (params.datos == "1") { //con datos: con nombre y apellido
                    isNotNull("nombre")
                    isNotNull("apellido")
                }
                order(params.sort, params.order)
            }
        }

        params.totalRows = results.totalCount

        params.label = "Se encontr" + (params.totalRows == 1 ? "ó" : "aron") + " <b>${params.totalRows}</b> inscrito" + (params.totalRows == 1 ? "" : "s") + " a la <u>convocatoria <i>${conv.descripcion}</i></u>"
        if (params.provincia) {
            params.label += " en la <u>provincia de <i>${prov.nombre}</i></u>"
        } else {
            params.label += " en <u>todas las provincias</u>"
        }
        if (params.estado) {
            params.label += " con <u>estado <i>${est.descripcion}</i></u>"
        } else {
            params.label += " con <u>cualquier estado</u>"
        }
        if (params.datos == '1') {
            params.label += " que <u>ya han ingresado sus datos</u>"
        } else if (params.datos == "0") {
            params.label += " que <u>aún no han ingresado sus datos</u>"
        }
        if (params.busqueda) {
            params.label += " y cuyo <u>nombre, apellido o cédula contenga <i>${params.busqueda}</i></u>"
        }

        def totalConv = Persona.findAllByConvocatoria(conv)
        def totalDatos = totalConv.findAll { it.nombre && it.apellido }

        params.totales = "En la convocatoria <i>${conv.descripcion}</i> se encontraron <b>${totalConv.size()}</b> inscritos, de los cuales <b>${totalDatos.size()}</b> ya han ingresado sus datos"

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
