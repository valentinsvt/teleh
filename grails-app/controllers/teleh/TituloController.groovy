package teleh

import org.springframework.dao.DataIntegrityViolationException

class TituloController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [tituloInstanceList: Titulo.list(params), params: params]
    } //list

    def form_ajax() {
        def tituloInstance = new Titulo(params)
        if (params.id) {
            tituloInstance = Titulo.get(params.id)
            if (!tituloInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Titulo con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tituloInstance: tituloInstance]
    } //form_ajax

    def save() {
        def tituloInstance
        if (params.id) {
            tituloInstance = Titulo.get(params.id)
            if (!tituloInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Titulo con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            tituloInstance.properties = params
        }//es edit
        else {
            tituloInstance = new Titulo(params)
        } //es create
        if (!tituloInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Titulo " + (tituloInstance.id ? tituloInstance.id : "") + "</h4>"

            str += "<ul>"
            tituloInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Titulo " + tituloInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Titulo " + tituloInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def tituloInstance = Titulo.get(params.id)
        if (!tituloInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Titulo con id " + params.id
            redirect(action: "list")
            return
        }
        [tituloInstance: tituloInstance]
    } //show

    def delete() {
        def tituloInstance = Titulo.get(params.id)
        if (!tituloInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Titulo con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            tituloInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Titulo " + tituloInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Titulo " + (tituloInstance.id ? tituloInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
