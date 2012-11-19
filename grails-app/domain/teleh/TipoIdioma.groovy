package teleh

class TipoIdioma implements Serializable {
    String tipo //N Nativo, E Extranjero
    String descripcion
    static mapping = {
        table 'tpid'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpid__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpid__id'
            tipo column: 'tpidtipo'
            descripcion column: 'tpiddscr'
        }
    }
    static constraints = {
        tipo(size: 1..1, blank: false, nullable: false, attributes: [title: 'tipo'])
        descripcion(size: 1..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
