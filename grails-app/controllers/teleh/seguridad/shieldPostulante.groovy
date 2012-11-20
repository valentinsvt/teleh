package teleh.seguridad

class ShieldPostulante {
    def beforeInterceptor = [action: this.&auth, except: 'login']
    /**
     * Verifica si se ha iniciado una sesión
     * Verifica si el usuario actual tiene los permisos para ejecutar una acción
     */
    def auth() {

        if (!session.usuario || !session.perfil) {
            redirect(controller: 'login', action: 'postulante')
            session.finalize()
            return false
        } else {
            return true
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
 
