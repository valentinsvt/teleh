package teleh.seguridad

import teleh.Auxiliar
import teleh.Convocatoria
import teleh.Persona

class LoginController {

    def mail

    def index() {
        redirect(action: 'login')
    }

    def postulante() {
        def fecha = new Date()
        session.convocatoria = null
/*        def conv = Convocatoria.findByFechaInicioLessThanEqualsAndFechaFinGreaterThanEquals(fecha, fecha)
        if (conv)
            session.convocatoria = conv
        def mensaje = params.msn
        params.msn = null
*/
        def conv = Convocatoria.findByFechaInicioLessThanEqualsAndFechaFinGreaterThanEquals(fecha,fecha)
        if (conv) { /*** Se trata de manejar el mensaje de inscripciones, pruebas o entrevistas **/
            /* No hace falta fecha de inicio de entrevistas porque postulante no necesita ingresar solo el usuario tipo e
             * hace la entrevista y la registra */
            params.esInsc = (conv.fechaEvaluacion > fecha)
            params.esPrba = (conv.fechaEvaluacion <= fecha)
            session.convocatoria = conv
            params.convocatoria = true
        }
        def mensaje = params.msn
        params.msn = null
    }

    def olvidoPass() {
        def mail = params.email
        def ci = params.ci
        def personas = Persona.findAllByEmailAndCedula(mail, ci)

        def msg
        if (personas.size() == 0) {
            msg = "NO*No se encontró un usuario con ese email y cédula"
        } else if (personas.size() > 1) {
            msg = "NO*Ha ocurrido un error grave"
        } else {
            def persona = personas[0]

            def random = new Random()
            def chars = []
            ['A'..'Z', 'a'..'z', '0'..'9', ('!@$%^&*' as String[]).toList()].each { chars += it }
            def newPass = (1..8).collect { chars[random.nextInt(chars.size())] }.join()

            persona.pin = newPass.encodeAsMD5()
            if (persona.save(flush: true)) {
                sendMail {
                    to mail
                    from "info@infa.gob.ec"
                    subject "Recuperación de contraseña"
                    body "Su nueva contraseña es: " + newPass + ""
                }
                msg = "OK*Se ha enviado un email a la dirección " + mail + " con una nueva contraseña."
            } else {
                msg = "NO*Ha ocurrido un error al crear la nueva contraseña. Por favor vuelva a intentar."
            }
        }
        render msg
    }

    def login() {

    }

    def validarAux() {
        def user = Auxiliar.withCriteria {
            eq("usuario", params.login)
            eq("password", params.pass.encodeAsMD5())
        }

        if (user.size() == 0) {
            flash.message = "No se encuentra registrado en el sistema o su contraseña esta incorrecta"
        } else if (user.size() > 1) {
            flash.message = "Ha ocurrido un error grave"
        } else {
            user = user[0]
            session.usuario = user
            session.perfil = "admin"
            if (user.tipo == "e") {
                redirect(action: "list", controller: "entrevista")
            } else {
                redirect(action: "list", controller: "personaAdm")
            }
            return
        }
        redirect(controller: 'login', action: "login")
    }

    def validar() {

        if (!session.convocatoria)
            redirect(action: "postulante")
        else {
            def user = Persona.withCriteria {
                eq("cedula", params.cedula)
                eq("pin", params.pin.encodeAsMD5())
                eq("activo", 1)
                //eq("convocatoria", session.convocatoria) //solo esta convocatoria
            }

            if (user.size() == 0) {
                flash.message = "No se encuentra registrado en el sistema, su contraseña está incorrecta o no ha sido calificado para rendir la prueba"
                redirect(controller: 'login', action: "postulante")
            } else if (user.size() > 1) {
                flash.message = "Ha ocurrido un error grave"
            } else {
                user = user[0]
                if (user.login == 0) {
                    user.login = 1
                    user.save(flush: true)
                }

                session.usuario = user
                session.perfil = "postulante"
                def ahora = new Date()
                if (session.convocatoria.fechaEvaluacion > ahora) {
                    redirect(action: "datos", controller: "persona")
                } else {
                    if (user.estado?.id?.toInteger() == 2) {
                        redirect(action: "inicio", controller: "evaluacion")
                    } else {
                        session.finalize()
                        flash.message = "Usted no ha si calificado para rendir la evaluación"
                        redirect(action: "postulante")
                    }
                }
                return
            }
        }


    }

//    def savePer() {
////        println params
//
//        def sesn = Sesn.get(params.perfiles)
//        def perf = sesn.perfil
////        println perf
//
//        if (perf) {
//            session.perfil = perf
//            if (session.an && session.cn) {
//                if (session.an.toString().contains("ajax")) {
//                    redirect(controller: "inicio", action: "index")
//                } else {
//                    redirect(controller: session.cn, action: session.an, params: session.pr)
//                }
//            } else {
//                redirect(controller: "inicio", action: "index")
//            }
//        }
//        else {
//            redirect(action: "login")
//        }
//    }


    def logout() {
        if (session.usuario) {
            session.usuario = null
            session.persona = null
            session.perfil = null
            session.permisos = null
            session.menu = null
            session.an = null
            session.cn = null
            session.invalidate()
            redirect(controller: 'login', action: 'postulante')
        } else {
            redirect(controller: 'login', action: 'postulante')
        }
    }


}
