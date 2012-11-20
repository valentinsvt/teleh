package teleh

class PersonaAdmController {

    def index() { }

    def list() {
        [personaInstanceList: Persona.list(params), params: params]
    }

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

    def verTitulo() {

    }

}
