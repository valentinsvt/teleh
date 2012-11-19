package teleh.seguridad

import teleh.Persona

class LoginController {

    def mail

    def index() {
        redirect(action: 'login')
    }

    def postulante(){

    }

    def olvidoPass() {
        def mail = params.email
        def personas = Persona.findAllByEmail(mail)
        def msg
        if (personas.size() == 0) {
            msg = "NO*No se encontró un usuario con ese email"
        } else if (personas.size() > 1) {
            msg = "NO*Ha ocurrido un error grave"
        } else {
            def persona = personas[0]

            def random = new Random()
            def chars = []
            ['A'..'Z', 'a'..'z', '0'..'9', ('!@$%^&*' as String[]).toList()].each {chars += it}
            def newPass = (1..8).collect { chars[random.nextInt(chars.size())] }.join()

            persona.password = newPass.encodeAsMD5()
            if (persona.save(flush: true)) {
                sendMail {
                    to mail
                    subject "Recuperación de contraseña"
                    body 'Hola ' + persona.login + ", tu nueva contraseña es " + newPass + "."
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

    def validar() {
        def user = Persona.withCriteria {
            eq("cedula", params.cedula)
            eq("pin", params.pin.encodeAsMD5())
            eq("activo", 1)
        }

        if (user.size() == 0) {
            flash.message = "No se encuentra registrado en el sistema o su pin esta incorrecto"
        } else if (user.size() > 1) {
            flash.message = "Ha ocurrido un error grave"
        } else {
            user = user[0]
            session.usuario = user
            redirect(action: "datos",controller: "persona")
            return
        }
        redirect(controller: 'login', action: "postulante")
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
