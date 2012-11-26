package teleh

class Pregunta {

    static auditable = [ignore: ['']]

    Examen examen
    int orden
    String pregunta

    static hasMany = [respuestas:Respuesta]


    static mapping = {
        table 'preg'
        cache usage:'read-write', include:'non-lazy'
        id column:'preg__id'
        id generator:'identity'
        version false
        columns {
            id column:'preg__id'
            examen column: 'exmn__id'
            orden column: 'pregordn'
            pregunta column: 'pregpreg'
        }
    }
    static constraints = {
        examen(nullable: false)
        orden(nullable:false)
        pregunta(nullable: false,blank: false,size: 1..1024)
    }

    String toString(){
        "${this.pregunta}"
    }
}
