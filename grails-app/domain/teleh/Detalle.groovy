package teleh

class Detalle {

    Encuesta encuesta
    Pregunta pregunta
    Respuesta respuesta
    Date fecha = new Date()

    static mapping = {
        table 'dtle'
        cache usage:'read-write', include:'non-lazy'
        id column:'dtle__id'
        id generator:'identity'
        version false
        columns {
            id column:'dtle__id'
            encuesta column: 'encu__id'
            pregunta column: 'preg__id'
            respuesta column: 'resp__id'
            fecha column: 'dtlefcha'
        }
    }
    static constraints = {
        encuesta(nullable: false)
        pregunta(nullable: false)
        respuesta(nullable: false)
    }

    String toString(){
        "${this.pregunta} -> ${this.respuesta}"
    }
}
