package teleh

class EvaluacionController  extends teleh.seguridad.ShieldPostulante {

    def inicio = {
        if (session.persona) {
            def aux = Auxiliar.list([sort: 'id']).pop()
            def texto = ""
            if (aux)
                texto = aux.textoInicio
            [persona: session.persona, texto: texto]
        } else {
            redirect(action: "login", controller: "login")
        }
    }

    def index = {
        println "persona " + session.persona
        if (session.persona) {
            println "si persona"
            def encuesta = Encuesta.findByPersona(session.persona)
            def cal = Calendar.instance
            session.inicio = cal.time
            cal.add(Calendar.MINUTE, 30)
            session.fin = cal.time
//            println "cal inicio " + session.inicio
//            println "cal fin " + session.fin
            if (!encuesta) {
                println "no encuesta"
                def examen = Examen.get(seleccionExamen())
                encuesta = new Encuesta([examen: examen, persona: session.persona, inicio: session.inicio, fin: session.fin])
                if (encuesta.save(flush: true)) {
                    session.encuesta = encuesta
                    session.exa = examen
                    [exa: examen]
                } else {
                    println "no save " + encuesta.errors
                }
            } else {
                println "si encuesta reconexiones: $encuesta.reconeccion encuesta: $encuesta"
                def ahora = new Date()
                if (encuesta.reconeccion > 2){
                    session.exa = encuesta.examen
                    if(encuesta) session.encuesta=encuesta
                    redirect(action: "fin")
                }else{
                    def detalle = Detalle.findAllByEncuesta(encuesta,[sort: "id"])
                    println "detalle "+detalle //0602896441
                    def fecha
                    if (detalle){
                        detalle = detalle.pop()
                        println "detalle2 "+detalle
                        fecha =new Date().parse("MM/dd/yyyy h:mm:ss a",detalle.fecha.format("MM/dd/yyyy h:mm:ss a"))
                        def inicio = new Date().parse("MM/dd/yyyy h:mm:ss a",encuesta.inicio.format("MM/dd/yyyy h:mm:ss a"))
                        println "fecha "+fecha+" inicio "+inicio
                        def dif =fecha.getTime()-inicio.getTime()
                        dif=(dif/1000)
                        println "diferencia1!! "+dif
                        def sobrante = (encuesta.fin.getTime()-encuesta.inicio.getTime())/1000
                        println " encu inicio "+encuesta.inicio+" fin "+encuesta.fin
                        println "sobrante "+sobrante
                        dif=sobrante-dif
                        println "diferencia2!! "+dif
                        encuesta.inicio = new Date()
                        def calen = new Date().toCalendar()
                        detalle.fecha=calen.time
                        calen.add(Calendar.SECOND, dif.toInteger())
                        println "caln add "+calen.time
                        encuesta.fin = calen.time

                        detalle.save(flush: true)


                    }else{

                        def calen = Calendar.instance
                        encuesta.inicio = calen.time
                        calen.add(Calendar.MINUTE, 30)
                        encuesta.fin = calen.time
                        println "inicio "+encuesta.inicio+" fin "+encuesta.fin
                    }
                    encuesta.reconeccion++
                    if (encuesta.save(flush: true)){
                        session.exa = encuesta.examen
                        session.encuesta=encuesta
                        session.incio=encuesta.inicio
                        session.fin=encuesta.fin
                        [exa: encuesta.examen]
                    }
                }

                /*antes del cambio*/
//                session.encuesta = encuesta
//                session.fin = encuesta.fin
//                session.inicio = encuesta.inicio
//                if (ahora.before(encuesta.fin)) {
//                    println "si es antes"
//                    session.exa = encuesta.examen
//                    [exa: examen]
//                } else {
//                    session.exa = encuesta.examen
//                    redirect(action: "fin")
//                }
            }
        } else {
            redirect(action: "login", controller: "login")
        }
    }

    def examen = {
        if (session.persona) {

            if (session.exa && session.encuesta) {

                def preguntas = Pregunta.findAllByExamen(session.exa, [sort: "orden", order: "desc"])
                def pregunta
                def detalle = Detalle.findAllByEncuesta(session.encuesta, [sort: "id"])

                detalle.each {
                    if (preguntas.contains(it.pregunta)) {
                        preguntas.pop()
                    }
                }
                if (preguntas.size() == 0) {
                    pregunta = null
                    redirect(action: "fin")
                } else {
                    pregunta = preguntas.pop()
                    [pregunta: pregunta, exa: session.exa]
                }
            } else {
                redirect(action: "fin")
            }
        } else {
            redirect(action: "login", controller: "login")

        }

    }

    def siguiente = {
        if (session.persona) {
            if (session.exa && session.encuesta) {
                def pregunta = Pregunta.get(params.preg)
                def detalle = Detalle.findByEncuestaAndPregunta(session.encuesta, pregunta)
                if (!detalle) {
                    def ahora = new Date()
                    if (ahora.before(session.encuesta.fin)) {
                        println "si es antes"
                        detalle = new Detalle([encuesta: session.encuesta, pregunta: pregunta, respuesta: Respuesta.get(params.resp)])
                        detalle.save(flush: true)

                    } else {
                        redirect(action: "fin")
                    }

                }
                redirect(action: "examen")
            } else {
                redirect(action: "fin")
            }
        } else {
            redirect(action: "login", controller: "login")
        }
    }

    def fin = {
        println "session.encuesta $session"
        if (session.encuesta) {
            def detalle = Detalle.findAllByEncuesta(session.encuesta)
            def nota = 0
            def preguntas = Pregunta.findAllByExamen(session.exa).size()
            detalle.each {
                if (it.respuesta.correcta == 1)
                    nota++
            }

            //nota = "" + nota + "/" + preguntas
            nota = "Ha contestado ${detalle.size()} preguntas de un total de 20"
            session.persona = null
            session.exa = null
            session.encuesta = null
            def aux = Auxiliar.list([sort: 'id']).pop()
            def texto = ""
            if (aux)
                texto = aux.textoNota
            [nota: nota, texto: texto]
        } else {
            session.persona = null
            redirect(controller: "login", action: "login")
        }
    }

    def seleccionExamen() {
        def num = Math.random()
        if (num < 0.2) {
            return 1
        }
        if (num < 0.4) {
            return 2
        }
        if (num < 0.6) {
            return 3
        }
        if (num < 0.8) {
            return 4
        }
        if (num < 1) {
            return 5
        }
    }
}
