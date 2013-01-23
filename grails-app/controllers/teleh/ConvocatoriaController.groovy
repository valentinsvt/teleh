package teleh

import org.springframework.dao.DataIntegrityViolationException

class ConvocatoriaController extends teleh.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def dbConnectionService
    def mailService
    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        [convocatoriaInstanceList: Convocatoria.list(params), params: params]
    } //list

    //                        select i.insc__id,e.encu__id,i.inscnmbr,i.inscapel,p.provnmbr,c.cantnmbr,t.titldscr,count(d.dtle__id) from insc i,encu e,dtle d ,resp r,prov p ,cant c,titl t where i.insc__id=e.prsp__id and e.encu__id=d.encu__id and i.etdo__id!=3 and r.resp__id=d.resp__id and r.correcta=1 and i.prov__id=p.prov__id and i.cant__id=c.cant__id and i.titl__id=t.titl__id   group by 1,2   order by 1;
    def actualizaEstado(){
        def cn = dbConnectionService.getConnection()
        def sql = "select i.insc__id,e.encu__id,count(d.dtle__id) from insc i,encu e,dtle d where i.insc__id=e.prsp__id and e.encu__id=d.encu__id and i.etdo__id!=3 group by 1,2  having count(d.dtle__id)=20 order by 1"
        def updates = ""
        cn.eachRow(sql.toString()){r->
            if (updates.size()!=0)
                updates+=","
            if(r[2]==20)
                updates+=r[0]
        }
        println "updates !"+updates
        sql = "update insc set etdo__id=3 where insc__id in (${updates})"
        cn.execute(sql.toString())
        cn.close()
    }

    def enviarMailPrueba(){
        def calificados = Persona.findAllByEstado(Estado.get(2))
        println "calificados "+calificados.size()
        def conv = Convocatoria.list().pop()
        def cont = 0
        def tot = 0
        calificados.each {ca->
//            println "actual -> "+ca+"  "+ca.id+" "+ca.mailPrueba
            if (ca.mailPrueba!="E"){
//                println "paso if E"
                def encu = Encuesta.findByPersona(ca)
//                println "encuesta "+encu
                if (!encu){
                    tot++
                    println "enviar mail "+ca.email
                    try {
                        mailService.sendMail {
                            to ca.email
                            from "info@infa.gob.ec"
                            subject "Momento de rendir su exámen"
                            html g.render(template: "prueba", model: [prsn: ca,conv:conv])
                        }
                        ca.mailPrueba="E"
                        ca.save(flush: true)
                        cont++
                    } catch (e) {
                        println "error al mandar mail: mail prueba "+ca.email+" id:"+ca.id+"  e:"+e
                    }
                }
            }

        }
        render "Se enviaron ${cont} mails de un total de ${tot}"
    }

    def enviarMailPrueba2(){
        def calificados = Persona.findAllByEstado(Estado.get(2))
        println "calificados "+calificados.size()
        def conv = Convocatoria.list().pop()
        def cont = 0
        def tot = 0
        calificados.each {ca->
//            println "actual -> "+ca+"  "+ca.id+" "+ca.mailPrueba
            if (ca.mailPrueba!="E2"){
//                println "paso if E"
                def encu = Encuesta.findByPersona(ca)
//                println "encuesta "+encu
                if (!encu){
                    tot++
                    println "enviar mail "+ca.email
                    try {
                        mailService.sendMail {
                            to ca.email
                            from "info@infa.gob.ec"
                            subject "Momento de rendir su exámen"
                            html g.render(template: "prueba2", model: [prsn: ca,conv:conv])
                        }
                        ca.mailPrueba="E2"
                        ca.save(flush: true)
                        cont++
                    } catch (e) {
                        println "error al mandar mail: mail prueba "+ca.email+" id:"+ca.id+"  e:"+e
                    }
                }
            }

        }
        render "Se enviaron ${cont} mails de un total de ${tot}"
    }

    def enviarComunicado(){
        def calificados = Persona.findAllByEstado(Estado.get(3))
        println "calificados "+calificados.size()
        def conv = Convocatoria.list().pop()
        def cont = 0
        def tot = 0
        calificados.each {ca->
//            println "actual -> "+ca+"  "+ca.id+" "+ca.mailPrueba
            if (ca.mailPrueba!="C"){
//                println "paso if E"
                def encu = Encuesta.findByPersona(ca)
//                println "encuesta "+encu
                if (encu){
                    tot++
                    println "enviar mail entrevista "+ca.email
                    try {
                        mailService.sendMail {
                            to ca.email
                            from "info@infa.gob.ec"
                            subject "Comunicado"
                            html g.render(template: "comunicado", model: [prsn: ca,conv:conv])
                        }
                        ca.mailPrueba="C"
                        ca.save(flush: true)
                        cont++
                    } catch (e) {
                        println "error al mandar mail: mail comunicado entrevista "+ca.email+" id:"+ca.id+"  e:"+e
                    }
                }
            }

        }
        render "Se enviaron ${cont} mails de un total de ${tot}"
    }


    def pantallaComunicado(){

    }

    def enviarComunicadoGanadores(){
//        println "envar ganadores "+params
        def archivo = request.getFile("tituloArchivo")
        def conv = Convocatoria.list().pop()
        archivo.transferTo(new File("/tmp", "cedulas.csv"))
        def csv = new File("/tmp/cedulas.csv")
        def tot = 0
        def cont = 0

        csv.eachLine{
            tot++

            if (it.trim()!=""){
//                    println it
                def prsn = Persona.findByCedula(it.trim())
                if (prsn){
                    if (prsn.mailPrueba!="G"){

                        println "enviar mail ganadores "+prsn.email+" cedula "+prsn.cedula
                        try {
                            mailService.sendMail {
                                to prsn.email
                                from "info@infa.gob.ec"
                                subject "Felicitaciones"
                                html g.render(template: "ganadores", model: [prsn: prsn,conv:conv])
                            }
                            prsn.mailPrueba="G"
                            prsn.save(flush: true)
                            cont++
                        } catch (e) {
                            println "error al mandar mail: mail comunicado entrevista "+prsn.email+" id:"+prsn.id+"  e:"+e
                        }

                    }
                }
            }

        }
        render "Se enviaron ${cont} mails de un total de ${tot}"
    }

    def enviarComunicadoNoAceptados(){
        def calificados = Persona.findAllByEstado(Estado.get(5))
        println "calificados "+calificados.size()
        def conv = Convocatoria.list().pop()
        def cont = 0
        def tot = 0
        calificados.each {ca->
//            println "actual -> "+ca+"  "+ca.id+" "+ca.mailPrueba
            if (ca.mailPrueba!="C"){

                tot++
                println "enviar mail no aceptados "+ca.email
                try {
                    mailService.sendMail {
                        to ca.email
                        from "info@infa.gob.ec"
                        subject "Comunicado"
                        html g.render(template: "noAceptados", model: [prsn: ca,conv:conv])
                    }
                    ca.mailPrueba="C"
                    ca.save(flush: true)
                    cont++
                } catch (e) {
                    println "error al mandar mail: mail comunicado no aceptado "+ca.email+" id:"+ca.id+"  e:"+e
                }

            }

        }
        render "Se enviaron ${cont} mails de un total de ${tot}"
    }
    def enviarComunicadoPendientes(){
        /*TODO importante!! ver que estado va aqui o como sacar los pendientes*/
        def calificados = Persona.findAllByEstado(Estado.get(2))
        println "calificados "+calificados.size()
        def conv = Convocatoria.list().pop()
        def cont = 0
        def tot = 0
        calificados.each {ca->
//            println "actual -> "+ca+"  "+ca.id+" "+ca.mailPrueba
            if (ca.mailPrueba!="C"){
//
                tot++
                println "enviar mail pendientes "+ca.email
                try {
                    mailService.sendMail {
                        to ca.email
                        from "info@infa.gob.ec"
                        subject "Comunicado"
                        html g.render(template: "pendientes", model: [prsn: ca,conv:conv])
                    }
                    ca.mailPrueba="C"
                    ca.save(flush: true)
                    cont++
                } catch (e) {
                    println "error al mandar mail: mail comunicado pedientes "+ca.email+" id:"+ca.id+"  e:"+e
                }

            }

        }
        render "Se enviaron ${cont} mails de un total de ${tot}"
    }

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
