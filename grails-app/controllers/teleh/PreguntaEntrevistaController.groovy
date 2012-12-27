package teleh

import org.springframework.dao.DataIntegrityViolationException

class PreguntaEntrevistaController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        if (!params.id) {
            params.id = 1
        }
        def conv = Convocatoria.get(params.id)
        [preguntaEntrevistaInstanceList: PreguntaEntrevista.findAllByConvocatoria(conv, params), params: params]
    } //list

    def copy_ajax() {
        def conv = Convocatoria.get(params.conv)
        def convs = Convocatoria.list([sort: 'descripcion']) - conv
        return [conv: conv, convs: convs]
    }

    def copy() {
        def source = Convocatoria.get(params.convocatoria)
        def target = Convocatoria.get(params.id)

        def ok = true

        PreguntaEntrevista.findAllByConvocatoria(target).each { preg ->
            preg.delete(flush: true)
        }

        PreguntaEntrevista.findAllByConvocatoria(source).each { preg ->
            def np = new PreguntaEntrevista()
            np.properties = preg.properties
            np.convocatoria = target
            if (!np.save(flush: true)) {
                ok = false
                println "error: " + np.errors
            }
        }
        if (ok) {
            flash.clase = "alert-success"
            flash.message = "Se ha copiado correctamente la entrevista de la convocatoria " + source.descripcion + " a la convocatoria " + target.descripcion
        } else {
            flash.clase = "alert-error"
            flash.message = "Ha ocurrido un error al copiar la entrevista de la convocatoria " + source.descripcion + " a la convocatoria " + target.descripcion
        }
        redirect(action: 'list', id: target.id)
    }

    def form_ajax() {
        def preguntaEntrevistaInstance = new PreguntaEntrevista(params)
        if (params.id) {
            preguntaEntrevistaInstance = PreguntaEntrevista.get(params.id)
            if (!preguntaEntrevistaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Pregunta Entrevista con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        else {
            if (params.conv) {
                def order = PreguntaEntrevista.withCriteria {
                    eq("convocatoria", Convocatoria.get(params.conv))
                    projections {
                        max("orden")
                    }
                }
                order = order[0]
                if (!order) {
                    order = 0
                }
                def num = PreguntaEntrevista.withCriteria {
                    eq("convocatoria", Convocatoria.get(params.conv))
                    projections {
                        max("numero")
                    }
                }
                num = num[0]
                if (!num) {
                    num = 0
                }
                preguntaEntrevistaInstance.orden = order + 1
                preguntaEntrevistaInstance.numero = num + 1
            }
        }
        if (params.conv) {
            preguntaEntrevistaInstance.convocatoria = Convocatoria.get(params.conv)
        }
        return [preguntaEntrevistaInstance: preguntaEntrevistaInstance]
    } //form_ajax

    def save() {
        def preguntaEntrevistaInstance
        if (params.id) {
            preguntaEntrevistaInstance = PreguntaEntrevista.get(params.id)
            if (!preguntaEntrevistaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Pregunta Entrevista con id " + params.id
                redirect(action: 'list')
                return
            }//no existe el objeto
            preguntaEntrevistaInstance.properties = params
        }//es edit
        else {
            preguntaEntrevistaInstance = new PreguntaEntrevista(params)
        } //es create
        if (!preguntaEntrevistaInstance.save(flush: true)) {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar Pregunta Entrevista " + (preguntaEntrevistaInstance.id ? preguntaEntrevistaInstance.id : "") + "</h4>"

            str += "<ul>"
            preguntaEntrevistaInstance.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex { arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
            redirect(action: 'list', id: preguntaEntrevistaInstance.convocatoriaId)
            return
        }

        if (params.id) {
            flash.clase = "alert-success"
            flash.message = "Se ha actualizado correctamente Pregunta Entrevista " + preguntaEntrevistaInstance.id
        } else {
            flash.clase = "alert-success"
            flash.message = "Se ha creado correctamente Pregunta Entrevista " + preguntaEntrevistaInstance.id
        }
        redirect(action: 'list', id: preguntaEntrevistaInstance.convocatoriaId)
    } //save

    def show_ajax() {
        def preguntaEntrevistaInstance = PreguntaEntrevista.get(params.id)
        if (!preguntaEntrevistaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Pregunta Entrevista con id " + params.id
            redirect(action: "list")
            return
        }
        [preguntaEntrevistaInstance: preguntaEntrevistaInstance]
    } //show

    def delete() {
        def preguntaEntrevistaInstance = PreguntaEntrevista.get(params.id)
        if (!preguntaEntrevistaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Pregunta Entrevista con id " + params.id
            redirect(action: "list")
            return
        }

        try {
            preguntaEntrevistaInstance.delete(flush: true)
            flash.clase = "alert-success"
            flash.message = "Se ha eliminado correctamente Pregunta Entrevista " + preguntaEntrevistaInstance.id
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.clase = "alert-error"
            flash.message = "No se pudo eliminar Pregunta Entrevista " + (preguntaEntrevistaInstance.id ? preguntaEntrevistaInstance.id : "")
            redirect(action: "list")
        }
    } //delete
} //fin controller
