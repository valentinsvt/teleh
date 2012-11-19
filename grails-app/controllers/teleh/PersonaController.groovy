package teleh

import org.springframework.dao.DataIntegrityViolationException

class PersonaController /*extends teleh.seguridad.Shield*/ {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [personaInstanceList: Persona.list(params), params: params]
    } //list

    def form_ajax() {
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

    def save() {
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
        def personaInstance
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Persona con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            personaInstance.properties = params
        }//es edit
        else {
            personaInstance = new Persona(params)
        } //es create
        if (!personaInstance.save(flush: true)) {
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
            redirect(action: 'list')
            return
        }

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Persona " + personaInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Persona " + personaInstance.id
        }
        redirect(action: 'list')
    } //save

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

    def delete() {
        def personaInstance = Persona.get(params.id)
        if (!personaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Persona con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            personaInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Persona " + personaInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Persona " + (personaInstance.id ? personaInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
