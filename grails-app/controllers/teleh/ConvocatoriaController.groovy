package teleh

import org.springframework.dao.DataIntegrityViolationException

class ConvocatoriaController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [convocatoriaInstanceList: Convocatoria.list(params), params: params]
    } //list

    def form_ajax() {
        def convocatoriaInstance = new Convocatoria(params)
        if (params.id) {
            convocatoriaInstance = Convocatoria.get(params.id)
            if (!convocatoriaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Convocatoria con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [convocatoriaInstance: convocatoriaInstance]
    } //form_ajax

    def save() {
        println "params "+params
        if (params.fechaInicio) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }
        if (params.fechaFin) {
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }
        if (params.fechaRegistro) {
            params.fechaRegistro = new Date().parse("dd-MM-yyyy", params.fechaRegistro)
        }
        if (params.fechaEvaluacion) {
            params.fechaEvaluacion = new Date().parse("dd-MM-yyyy", params.fechaEvaluacion)
            println "fec ev "+params.fechaEvaluacion
        }

        def convocatoriaInstance
        if (params.id) {
            convocatoriaInstance = Convocatoria.get(params.id)
            if (!convocatoriaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Convocatoria con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            convocatoriaInstance.properties = params
        }//es edit
        else {
            convocatoriaInstance = new Convocatoria(params)
        } //es create
        if (!convocatoriaInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Convocatoria " + (convocatoriaInstance.id ? convocatoriaInstance.id : "") + "</h4>"

            str += "<ul>"
            convocatoriaInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex { arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            redirect(action: 'list')
            return
        }
        println "fecha con "+convocatoriaInstance.fechaEvaluacion

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Convocatoria " + convocatoriaInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Convocatoria " + convocatoriaInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def convocatoriaInstance = Convocatoria.get(params.id)
        if (!convocatoriaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Convocatoria con id " + params.id
            redirect(action: "list")
            return
        }
        [convocatoriaInstance: convocatoriaInstance]
    } //show

    def delete() {
        def convocatoriaInstance = Convocatoria.get(params.id)
        if (!convocatoriaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Convocatoria con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            convocatoriaInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Convocatoria " + convocatoriaInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Convocatoria " + (convocatoriaInstance.id ? convocatoriaInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
