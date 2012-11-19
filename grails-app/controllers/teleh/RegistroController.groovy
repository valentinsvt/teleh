package teleh

class RegistroController {

    def mailService

    def index() {

    }

    def registrar(){
        def prsn = Persona.findByCedula(params.cedula)
        def msn
        if (!prsn) {
            prsn = new Persona(params)
            def pin = prsn.email.encodeAsMD5().substring(0, 3) + prsn.cedula.encodeAsMD5().substring(0, 3)
            prsn.pin = pin.encodeAsMD5()

            if (prsn.save(flush: true)) {
                try {
                    mailService.sendMail {
                        to prsn.email
                        subject "Registro Senplades"
                        html g.render(template: "enviar_pin", model: [prsn: prsn, pin: pin])
                    }
                } catch (e) {
                    println "error al mandar mail: RegistroController, registrar, l.128"
                }
                redirect(action: "enviado")
            } else {
                println "errores " + prsn.errors
                msn = "Existe un error con los datos ingresados. Recuerde que los campos nombre y apellidos tienen un m&aacute;ximo de 31 caracteres y el email es &uacute;nico"
                redirect(action: "index", params: [msn: msn])
            }
        } else {
            if (prsn.login == 0) {
                prsn.properties = params
                def pin = prsn.email.encodeAsMD5().substring(0, 3) + prsn.cedula.encodeAsMD5().substring(0, 3)
                prsn.pin = pin.encodeAsMD5()
                if (prsn.save(flush: true)) {
                    try {
                        mailService.sendMail {
                            to prsn.email
                            subject "Registro Senplades"
                            html g.render(template: "enviar_pin", model: [prsn: prsn, pin: pin])
                        }
                    } catch (e) {
                        println "error al mandar mail: RegistroController, registrar "+e
                    }
                    redirect(action: "enviado")
                } else {
                    println "errores " + prsn.errors
                    msn = "Existe un error con los datos ingresados. Recuerde que los campos nombre y apellidos tienen un m&aacute;ximo de 31 caracteres y el email es &uacute;nico"
                    redirect(action: "index", params: [msn: msn])
                }
            } else {
                msn = "Usted ya est&aacute; registrado"
                redirect(action: "index", params: [msn: msn])
            }
        }
    }

    def enviado = {

    }
}
