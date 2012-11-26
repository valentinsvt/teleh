package teleh

class Estado implements Serializable {
    static auditable = [ignore: ['']]

    String codigo
    String descripcion
    static mapping = {
        table 'etdo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'etdo__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'etdo__id'
            codigo column: 'etdocdgo'
            descripcion column: 'etdodscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, attributes: [title: 'numero'])
        descripcion(size: 1..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}