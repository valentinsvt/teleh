package teleh

import org.springframework.dao.DataIntegrityViolationException

class PersonaController extends teleh.seguridad.ShieldPostulante {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

//    def list() {
//        [personaInstanceList: Persona.list(params), params: params]
//    } //list

    def cargarTitulos() {
        def promotor = params.promotor
        def tipos = ['A']
        switch (promotor) {
            case "SI":
                tipos.add('S')
                break;
            case "NO":
                tipos.add('N')
                break;
        }

        println tipos
        def titulos = Titulo.findAllByTipoInList(tipos, [sort: 'descripcion'])
        println titulos

        def sel = g.select(id: "titulo", name: "titulo.id", from: titulos, optionKey: "id", optionValue: {it.descripcion + ' (' + it.tipoTitulo.descripcion + ')'}, "class": "many-to-one", noSelection: ['null': ''])

        render sel
    }

    def datos() {
        def user = Persona.get(session.usuario.id)

        def tieneTitulo = TituloPersona.findAllByPersona(user).size() > 0
        def camposCompletos = true
        if (!user.apellido || !user.nombre) {
            camposCompletos = false
        }

        return [personaInstance: user, completo: tieneTitulo && camposCompletos]
    }

    def cursosPersona() {
//        println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
//        println params
//        println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        def personaInstance = Persona.get(session.usuario.id)
//        println personaInstance

        if (params.add == "true") {
//            println "ADD!!!"
            if (params.fecha) {
                params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
            }
            params.persona = personaInstance
            def curso = new CursoPersona(params)
            if (curso.save(flush: true)) {
//                println "OK"
            } else {
                println "NO guardo el curso de la persona " + personaInstance.id
                println curso.errors
            }
        }

        def cursos = CursoPersona.findAllByPersona(personaInstance)
//        println cursos
        return [personaInstance: personaInstance, cursos: cursos]
    }

    def deleteCursoPersona() {
        def curso = CursoPersona.get(params.id)
        if (curso) {
            try {
                curso.delete(flush: true)
                render "OK"
            }
            catch (DataIntegrityViolationException e) {
                render "NO"
                println e
            }
        } else {
            render "NO"
        }
    }

    def comboCanton() {
        def prov = Provincia.get(params.id)
        [prov: prov]
    }

    def comboParr() {
        def canton = Canton.get(params.id)
        [canton: canton]
    }

//    def form_ajax() {
//        def personaInstance = new Persona(params)
//        if (params.id) {
//            personaInstance = Persona.get(params.id)
//            if (!personaInstance) {
//                flash.clase = "alert-error"
//                flash.message = "No se encontró Persona con id " + params.id
//                redirect(action: "list")
//                return
//            } //no existe el objeto
//        } //es edit
//        return [personaInstance: personaInstance]
//    } //form_ajax
//
//    def titulo_ajax() {
//        def personaInstance = new Persona(params)
//        if (params.id) {
//            personaInstance = Persona.get(params.id)
//            if (!personaInstance) {
//                flash.clase = "alert-error"
//                flash.message = "No se encontró Persona con id " + params.id
//                redirect(action: "list")
//                return
//            } //no existe el objeto
//        } //es edit
//        return [personaInstance: personaInstance]
//    } //form_ajax
//
//    def uploadTitulo() {
//        def archivo = request.getFile("tituloArchivo")
//        // List of OK mime-types
//        def okcontents = ['image/png', 'image/jpeg', 'image/gif', 'application/pdf']
//        if (!okcontents.contains(archivo.getContentType())) {
//            flash.clase = "alert-error"
//            flash.message = "El archivo del titulo debe ser de tipo ${okcontents}"
//            redirect(action: 'list')
//            return;
//        }
//        params.tipoArchivo = archivo.getContentType()
//        def titulo
//        def persona = Persona.get(params.persona.id)
//        def tituloExistente = TituloPersona.findAllByPersona(persona)
//        if (tituloExistente.size() == 0) {
//            titulo = new TituloPersona()
//        } else if (tituloExistente.size() == 1) {
//            titulo = tituloExistente[0]
//        } else {
//            flash.clase = "alert-error"
//            flash.message = "Error grave"
//        }
//        titulo.properties = params
//        if (titulo.save(flush: true)) {
//            flash.clase = "alert-success"
//            flash.message = "Se ha cargado correctamente el título de la Persona " + persona.nombre + " " + persona.apellido
//        } else {
//            flash.clase = "alert-error"
//            def str = "<h4>No se pudo guardar el título de la Persona " + persona.nombre + " " + persona.apellido + "</h4>"
//
//            str += "<ul>"
//            titulo.errors.allErrors.each { err ->
//                def msg = err.defaultMessage
//                err.arguments.eachWithIndex {  arg, i ->
//                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
//                }
//                str += "<li>" + msg + "</li>"
//            }
//            str += "</ul>"
//
//            flash.message = str
//        }
//        redirect(action: 'list')
//    }

    def verTitulo() {
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

//    def save() {
//        if (params.fechaNacimiento) {
//            params.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.fechaNacimiento)
//        }
//        if (params.fecha1) {
//            params.fecha1 = new Date().parse("dd-MM-yyyy", params.fecha1)
//        }
//        if (params.fecha2) {
//            params.fecha2 = new Date().parse("dd-MM-yyyy", params.fecha2)
//        }
//        if (params.fecha3) {
//            params.fecha3 = new Date().parse("dd-MM-yyyy", params.fecha3)
//        }
//        def personaInstance
//        if (params.id) {
//            personaInstance = Persona.get(params.id)
//            if (!personaInstance) {
//                flash.clase = "alert-error"
//                flash.message = "No se encontró Persona con id " + params.id
//                redirect(action: 'list')
//                return
//            }//no existe el objeto
//            personaInstance.properties = params
//        }//es edit
//        else {
//            personaInstance = new Persona(params)
//        } //es create
//        if (!personaInstance.save(flush: true)) {
//            flash.clase = "alert-error"
//            def str = "<h4>No se pudo guardar Persona " + (personaInstance.id ? personaInstance.id : "") + "</h4>"
//
//            str += "<ul>"
//            personaInstance.errors.allErrors.each { err ->
//                def msg = err.defaultMessage
//                err.arguments.eachWithIndex {  arg, i ->
//                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
//                }
//                str += "<li>" + msg + "</li>"
//            }
//            str += "</ul>"
//
//            flash.message = str
//            redirect(action: 'list')
//            return
//        }
//
//        if (params.id) {
//            flash.clase = "alert-success"
//            flash.message = "Se ha actualizado correctamente Persona " + personaInstance.id
//        } else {
//            flash.clase = "alert-success"
//            flash.message = "Se ha creado correctamente Persona " + personaInstance.id
//        }
//        redirect(action: 'list')
//    } //save

    def savePersona() {
        println params
        if (params.fechaNacimiento) {
            params.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.fechaNacimiento)
        }
        if (params.fecha1) {
            params.fecha1 = new Date().parse("dd-MM-yyyy", params.fecha1)
        }
        if (params.fecha2) {
            params.fecha2 = new Date().parse("dd-MM-yyyy", params.fecha2)
        }
        if (params.fecha3) {
            params.fecha3 = new Date().parse("dd-MM-yyyy", params.fecha3)
        }
        params.estado = Estado.findByCodigo("I")
        def personaInstance
        /*
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Persona con id " + params.id
                redirect(action: 'datos')
                return
            }//no existe el objeto
//            personaInstance.properties = params
        }//es edit
        else {
//            personaInstance = new Persona(params)
        } //es create
        */
        personaInstance = Persona.get(session.usuario.id)
        personaInstance.properties = params
        if (!personaInstance.save(flush: true)) {
            println personaInstance.errors
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Persona " + (personaInstance.id ? personaInstance.id : "") + "</h4>"

            str += "<ul>"
            personaInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex {  arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            redirect(action: 'datos')
            return
        }

        flash.clase = "alert-success"
        flash.message = "Sus datos se han guardado correctamente"

        redirect(action: 'formTitulo', id: personaInstance.id)
    } //save

    def formTitulo() {
        def personaInstance = Persona.get(session.usuario.id)

        def tieneTitulo = TituloPersona.findAllByPersona(personaInstance).size() > 0
        def camposCompletos = true
        if (!personaInstance.apellido || !personaInstance.nombre) {
            camposCompletos = false
        }

        return [personaInstance: personaInstance, completo: tieneTitulo && camposCompletos]
    }

    def uploadArchivo() {
        def archivo = request.getFile("tituloArchivo")
        println "upload " + params
        // List of OK mime-types
        def okcontents = ['image/png', 'image/jpeg', 'image/gif', 'application/pdf']
        if (!okcontents.contains(archivo.getContentType())) {
            flash.clase = "alert-error"
            flash.message = "El archivo del titulo debe ser de tipo ${okcontents}"
            redirect(action: 'formTitulo')
            return;
        }
        def size = archivo.size
        if (size > 1024 * 500) {
            flash.clase = "alert-error"
            flash.message = "El archivo del titulo debe tener un tamaño máximo de 500Kb"
            redirect(action: 'formTitulo')
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
            redirect(action: 'formTitulo')
            return;
        }
        titulo.properties = params
        if (titulo.save(flush: true)) {
            flash.clase = "alert-success"
            flash.message = "Se ha cargado correctamente el título"
            redirect(action: 'formTitulo')
            return;
        } else {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar el título"

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
            redirect(action: 'formTitulo')
            return;
        }
    }

//    def show_ajax() {
//        def personaInstance = Persona.get(params.id)
//        if (!personaInstance) {
//            flash.clase = "alert-error"
//            flash.message = "No se encontró Persona con id " + params.id
//            redirect(action: "list")
//            return
//        }
//        [personaInstance: personaInstance]
//    } //show

//    def delete() {
//        def personaInstance = Persona.get(params.id)
//        if (!personaInstance) {
//            flash.clase = "alert-error"
//            flash.message = "No se encontró Persona con id " + params.id
//            redirect(action: "list")
//            return
//        }
//
//        try {
//            personaInstance.delete(flush: true)
//            flash.clase = "alert-success"
//            flash.message = "Se ha eliminado correctamente Persona " + personaInstance.id
//            redirect(action: "list")
//        }
//        catch (DataIntegrityViolationException e) {
//            flash.clase = "alert-error"
//            flash.message = "No se pudo eliminar Persona " + (personaInstance.id ? personaInstance.id : "")
//            redirect(action: "list")
//        }
//    } //delete
} //fin controller
