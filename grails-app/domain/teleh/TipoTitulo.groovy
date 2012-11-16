package teleh

class TipoTitulo implements Serializable {
    String descripcion
    static mapping = {
        table 'tptt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tptt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tptt__id'
            descripcion column: 'tpttdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
