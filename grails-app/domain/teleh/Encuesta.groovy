package teleh

class Encuesta {
    
    Examen examen
    Persona persona
    Date inicio
    Date fin
    int reconeccion=0

    static mapping = {
        table 'encu'
        cache usage:'read-write', include:'non-lazy'
        id column:'encu__id'
        id generator:'identity'
        version false
        columns {
            id column:'encu__id'
            examen column: 'exmn__id'
            persona column: 'prsp__id'
            inicio column: 'encufcin'
            fin column: 'encufcfn'
            reconeccion column: 'encurcnx'
        }
    }
    static constraints = {
        examen(nullable: false)
        persona(nullable: false)
        inicio(nullable: false)
        fin(nullable: false)
    }

    String toString(){
        "${this.persona} : ${this.examen} "
    }
}
