package teleh

class RespuestaEntrevista {

    Persona persona
    PreguntaEntrevista preguntaEntrevista
    Double valor

    static constraints = {
        persona(blank: false, nullable: false)
        preguntaEntrevista(blank: false, nullable: false)
        valor(blank: false, nullable: false, default: 0)
    }

    static mapping = {
        table 'rsen'

        id column: 'rsen__id'

        persona column: 'insc__id'
        preguntaEntrevista column: 'pren__id'
        valor column: 'rsenvlor'
    }
}
