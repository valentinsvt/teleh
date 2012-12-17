package teleh

import org.springframework.dao.DataIntegrityViolationException

class PreguntaController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        def examen = Examen.get(params.id)
        if (!examen) {
            flash.message = "<p>No hay un examen seleccionado.</p><p>Seleccione un examen para ver las preguntas.</p><p><a href='" + g.createLink(controller: 'examen', action: 'list') + "' class='btn btn-danger'><i class='icon-arrow-left'></i> Lista de Exámenes</a></p>"
            flash.clase = "alert-error"
            return [examen: false]
        } else {
            if (!params.sort) {
                params.sort = "orden"
            }
            [preguntaInstanceList: Pregunta.findAllByExamen(examen, params), params: params, examen: examen]
        }
    } //list

    def addRespuesta_ajax() {
        println "RESPUESTAS"
        println params
        def pregunta = Pregunta.get(params.pregunta)
        def respuestasOk = Respuesta.countByPreguntaAndCorrecta(pregunta, 1)
        def respuesta = new Respuesta()
        respuesta.pregunta = pregunta
        respuesta.respuesta = params.respuesta.trim()
        if (params.correcta == "true" && respuestasOk == 0) {
            respuesta.correcta = 1
        } else {
            respuesta.correcta = 0
        }
        if (respuesta.save(flush: true)) {
            render "OK_" + respuesta.id
        } else {
            println respuesta.errors
            render "NO"
        }

    }

    def respuestas_ajax() {
        def preguntaInstance = Pregunta.get(params.id)
        return [preguntaInstance: preguntaInstance]
    }

    def delRespuesta_ajax() {
        def respuesta = Respuesta.get(params.id)
        try {
            respuesta.delete(flush: true)
            render "OK"
        }
        catch (DataIntegrityViolationException e) {
            println e
            render "NO"
        }
    }

    def form_ajax() {
//        println params
        def examen = Examen.get(params.examen)
        def preguntaInstance = new Pregunta(params)
        if (params.id) {
            preguntaInstance = Pregunta.get(params.id)
            if (!preguntaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Pregunta con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        if (!params.id) {
            def orden = Pregunta.withCriteria {
                eq("examen", examen)
                projections {
                    max("orden")
                }
            }
            preguntaInstance.orden = orden[0] ? orden[0] + 1 : 1
        }
        preguntaInstance.examen = examen

        return [preguntaInstance: preguntaInstance]
    } //form_ajax

    def save() {
        def preguntaInstance
        if (params.id) {
            preguntaInstance = Pregunta.get(params.id)
            if (!preguntaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Pregunta con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            preguntaInstance.properties = params
        }//es edit
        else {
            preguntaInstance = new Pregunta(params)
        } //es create
        if (!preguntaInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Pregunta " + (preguntaInstance.id ? preguntaInstance.id : "") + "</h4>"

            str += "<ul>"
            preguntaInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex { arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            redirect(action: 'list', id: preguntaInstance.examenId)
            return
        }

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Pregunta " + preguntaInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Pregunta " + preguntaInstance.id
        }
        redirect(action: 'list', id: preguntaInstance.examenId)
    } //save

    def save_ajax() {
        println "SAVE !" + params
        def preguntaInstance
        if (params.id) {
            preguntaInstance = Pregunta.get(params.id)
            if (!preguntaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Pregunta con id " + params.id
                render "NO"
                return
            }//no existe el objeto
            preguntaInstance.properties = params
        }//es edit
        else {
            preguntaInstance = new Pregunta(params)
        } //es create
        if (!preguntaInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Pregunta " + (preguntaInstance.id ? preguntaInstance.id : "") + "</h4>"

            str += "<ul>"
            preguntaInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex { arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            render "NO"
            return
        }

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Pregunta " + preguntaInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Pregunta " + preguntaInstance.id
        }
        render "OK_" + preguntaInstance.id
    } //save

    def show_ajax() {
        def preguntaInstance = Pregunta.get(params.id)
        if (!preguntaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Pregunta con id " + params.id
            redirect(action: "list")
            return
        }
        [preguntaInstance: preguntaInstance]
    } //show

    def delete() {
        def preguntaInstance = Pregunta.get(params.id)
        if (!preguntaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Pregunta con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            preguntaInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Pregunta " + preguntaInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Pregunta " + (preguntaInstance.id ? preguntaInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
