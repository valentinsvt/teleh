package teleh.seguridad

import teleh.Auxiliar

class Shield {
    def beforeInterceptor = [action: this.&auth, except: 'login']
    /**
     * Verifica si se ha iniciado una sesión
     * Verifica si el usuario actual tiene los permisos para ejecutar una acción
     */
    def auth() {

//        println "an " + actionName + " cn " + controllerName + "  "

//        println session
        session.an = actionName
        session.cn = controllerName
        session.pr = params
//        return true
        /** **************************************************************************/
        if (!session.usuario || !session.perfil) {
//                        println "1"
            redirect(controller: 'login', action: 'login')
            session.finalize()
            return false
        } else {
            if (session.perfil == "admin") {
                def usu = Auxiliar.get(session.usuario.id)

//                println usu.tipo + "   " + controllerName + "   " + actionName

                def allowedControllers, allowedActions

                if (usu.tipo.equalsIgnoreCase("a")) {
                    return true
                } else if (usu.tipo.equalsIgnoreCase("e")) {
                    allowedControllers = ["entrevista"]
                    allowedActions = ["list", "show_ajax", "entrevista"]
                } else if (usu.tipo.equalsIgnoreCase("c")) {
                    allowedControllers = ["personaAdm", "persona", "reportes", "pdf"]
                    allowedActions = ["list", "verTitulo", "cambiarEstado", "show_ajax", "listaPersonasXls", 'pdfLink', 'listaPersonasPdf']
                }

                if (allowedControllers.contains(controllerName) && allowedActions.contains(actionName)) {
                    return true
                } else {
                    return false
                }

            } else {
//                println "3"
                redirect(controller: 'login', action: 'login')
                return false
            }
        }
        return false
        /*************************************************************************** */
    }

    boolean isAllowed() {

//        try {
//            if (session.permisos[actionName] == controllerName)
//                return true
//        } catch (e) {
//            println "Shield execption e: " + e
//            return true
//        }
//        return true
        return true
    }
}
 
