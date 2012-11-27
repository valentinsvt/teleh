package teleh

import org.springframework.dao.DataIntegrityViolationException

class TipoTituloController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [tipoTituloInstanceList: TipoTitulo.list(params), params: params]
    } //list

    def form_ajax() {
        def tipoTituloInstance = new TipoTitulo(params)
        if (params.id) {
            tipoTituloInstance = TipoTitulo.get(params.id)
            if (!tipoTituloInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Tipo Titulo con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoTituloInstance: tipoTituloInstance]
    } //form_ajax

    def save() {
        def tipoTituloInstance
        if (params.id) {
            tipoTituloInstance = TipoTitulo.get(params.id)
            if (!tipoTituloInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Tipo Titulo con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            tipoTituloInstance.properties = params
        }//es edit
        else {
            tipoTituloInstance = new TipoTitulo(params)
        } //es create
        if (!tipoTituloInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Tipo Titulo " + (tipoTituloInstance.id ? tipoTituloInstance.id : "") + "</h4>"

            str += "<ul>"
            tipoTituloInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Tipo Titulo " + tipoTituloInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Tipo Titulo " + tipoTituloInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def tipoTituloInstance = TipoTitulo.get(params.id)
        if (!tipoTituloInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Tipo Titulo con id " + params.id
            redirect(action: "list")
            return
        }
        [tipoTituloInstance: tipoTituloInstance]
    } //show

    def delete() {
        def tipoTituloInstance = TipoTitulo.get(params.id)
        if (!tipoTituloInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Tipo Titulo con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            tipoTituloInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Tipo Titulo " + tipoTituloInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Tipo Titulo " + (tipoTituloInstance.id ? tipoTituloInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
