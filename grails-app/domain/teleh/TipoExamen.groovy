package teleh

class TipoExamen implements Serializable {
    String codigo
    String descripcion
    static mapping = {
        table 'tpex'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpex__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpex__id'
            codigo column: 'tpexcdgo'
            descripcion column: 'tpexdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, attributes: [title: 'numero'])
        descripcion(size: 1..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}