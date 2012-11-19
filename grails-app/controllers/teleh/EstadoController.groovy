package teleh

import org.springframework.dao.DataIntegrityViolationException

class EstadoController /*extends teleh.seguridad.Shield*/ {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [estadoInstanceList: Estado.list(params), params: params]
    } //list

    def form_ajax() {
        def estadoInstance = new Estado(params)
        if(params.id) {
            estadoInstance = Estado.get(params.id)
            if(!estadoInstance) {
                flash.clase = "alert-error"
                flash.message =  "No se encontró Estado con id " + params.id
                redirect(action:  "list")
                return
            } //no existe el objeto
        } //es edit
        return [estadoInstance: estadoInstance]
    } //form_ajax

    def save() {
        def estadoInstance
        if(params.id) {
            estadoInstance = Estado.get(params.id)
            if(!estadoInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Estado con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            estadoInstance.properties = params
        }//es edit
        else {
            estadoInstance = new Estado(params)
        } //es create
        if (!estadoInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Estado " + (estadoInstance.id ? estadoInstance.id : "") + "</h4>"

            str += "<ul>"
            estadoInstance.errors.allErrors.each { err ->
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

        if(params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Estado " + estadoInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Estado " + estadoInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def estadoInstance = Estado.get(params.id)
        if (!estadoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Estado con id " + params.id
            redirect(action: "list")
            return
        }
        [estadoInstance: estadoInstance]
    } //show

    def delete() {
        def estadoInstance = Estado.get(params.id)
        if (!estadoInstance) {
            flash.clase = "alert-error"
            flash.message =  "No se encontró Estado con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            estadoInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message =  "Se ha eliminado correctamente Estado " + estadoInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message =  "No se pudo eliminar Estado " + (estadoInstance.id ? estadoInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
