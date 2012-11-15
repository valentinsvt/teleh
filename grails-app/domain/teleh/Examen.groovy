package teleh

class Examen {
    
    String descripcion
    String proposito
    int tipo=0

    static mapping = {
        table 'exmn'
        cache usage:'read-write', include:'non-lazy'
        id column:'exmn__id'
        id generator:'identity'
        version false
        columns {
            id column:'exmn__id'
            descripcion column: 'exmndscr'
            proposito column: 'exmnprps'
            tipo column: 'exmntipo'
        }
    }
    static constraints = {
        descripcion(blank: false,nullable: false,size: 1..1024)
        proposito(blank: false,nullable: false,size: 1..250)

    }

    String toString(){
        "${this.descripcion}"
    }
}
