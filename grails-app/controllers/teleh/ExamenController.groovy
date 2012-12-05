package teleh

import org.springframework.dao.DataIntegrityViolationException

class ExamenController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [examenInstanceList: Examen.list(params), params: params]
    } //list

    def form_ajax() {
        def examenInstance = new Examen(params)
        if (params.id) {
            examenInstance = Examen.get(params.id)
            if (!examenInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Examen con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [examenInstance: examenInstance]
    } //form_ajax

    def save() {
        params.tipo = 0
        def examenInstance
        if (params.id) {
            examenInstance = Examen.get(params.id)
            if (!examenInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Examen con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            examenInstance.properties = params
        }//es edit
        else {
            examenInstance = new Examen(params)
        } //es create
        if (!examenInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Examen " + (examenInstance.id ? examenInstance.id : "") + "</h4>"

            str += "<ul>"
            examenInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex {  arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            redirect(action: 'list')
            return
        }

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Examen " + examenInstance.descripcion
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Examen " + examenInstance.descripcion
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def examenInstance = Examen.get(params.id)
        if (!examenInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Examen con id " + params.id
            redirect(action: "list")
            return
        }
        [examenInstance: examenInstance]
    } //show

    def delete() {
        def examenInstance = Examen.get(params.id)
        if (!examenInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Examen con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            examenInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Examen " + examenInstance.descripcion
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Examen " + (examenInstance.descripcion ? examenInstance.descripcion : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
