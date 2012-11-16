package teleh

class Convocatoria implements Serializable {
    String descripcion
    Date fechaInicio
    Date fechaFin
    static mapping = {
        table 'conv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'conv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'conv__id'
            descripcion column: 'convdscr'
            fechaInicio column: 'convfcin'
            fechaFin column: 'convfcfn'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
        fechaInicio(blank: false, nullable: false, attributes: [title: 'descripcion'])
        fechaFin(blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
