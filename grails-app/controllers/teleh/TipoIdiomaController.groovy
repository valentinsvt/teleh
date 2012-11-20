package teleh

import org.springframework.dao.DataIntegrityViolationException

class TipoIdiomaController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [tipoIdiomaInstanceList: TipoIdioma.list(params), params: params]
    } //list

    def form_ajax() {
        def tipoIdiomaInstance = new TipoIdioma(params)
        if (params.id) {
            tipoIdiomaInstance = TipoIdioma.get(params.id)
            if (!tipoIdiomaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Tipo Idioma con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [tipoIdiomaInstance: tipoIdiomaInstance]
    } //form_ajax

    def save() {
        def tipoIdiomaInstance
        if (params.id) {
            tipoIdiomaInstance = TipoIdioma.get(params.id)
            if (!tipoIdiomaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Tipo Idioma con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            tipoIdiomaInstance.properties = params
        }//es edit
        else {
            tipoIdiomaInstance = new TipoIdioma(params)
        } //es create
        if (!tipoIdiomaInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Tipo Idioma " + (tipoIdiomaInstance.id ? tipoIdiomaInstance.id : "") + "</h4>"

            str += "<ul>"
            tipoIdiomaInstance.errors.allErrors.each { err ->
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
            flash.message = "Se ha actualizado correctamente Tipo Idioma " + tipoIdiomaInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Tipo Idioma " + tipoIdiomaInstance.id
        }
        redirect(action: 'list')
    } //save

    def show_ajax() {
        def tipoIdiomaInstance = TipoIdioma.get(params.id)
        if (!tipoIdiomaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Tipo Idioma con id " + params.id
            redirect(action: "list")
            return
        }
        [tipoIdiomaInstance: tipoIdiomaInstance]
    } //show

    def delete() {
        def tipoIdiomaInstance = TipoIdioma.get(params.id)
        if (!tipoIdiomaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Tipo Idioma con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            tipoIdiomaInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Tipo Idioma " + tipoIdiomaInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Tipo Idioma " + (tipoIdiomaInstance.id ? tipoIdiomaInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
