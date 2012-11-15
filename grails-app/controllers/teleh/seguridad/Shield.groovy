package teleh.seguridad

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
            //            println "1"
            redirect(controller: 'login', action: 'login')
            session.finalize()
            return false
        } else {
            //            println "2"
            //verificacion de permisos
            if (!session.unidad) {
                try {
                    //                        println "3"
                    def usuario = session.usuario
                    if (this.isAllowed())
                        return true
                    response.sendError(403)
                    return false
                } catch (e) {
                    //                        println "4"
                    redirect(controller: 'login', action: 'login')
                    session.finalize()
                    return false
                }
            } else {
                if (this.isAllowed())
                    return true

                response.sendError(403)
                return false
            }
        }
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
 
