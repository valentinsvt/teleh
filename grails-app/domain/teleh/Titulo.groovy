package teleh

class Titulo implements Serializable {
    TipoTitulo tipoTitulo
    String tipo
    String descripcion
    Integer puntaje

    static mapping = {
        table 'tpcn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpcn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpcn__id'
            tipoTitulo column: 'tptt__id'
            tipo column: 'titltipo'
            descripcion column: 'tpcndscr'
            puntaje column: 'tpcndscr'
        }
    }
    static constraints = {
        tipoTitulo(blank: false, nullable: false, attributes: [title: 'tipo de titulo'])
        tipo(size: 1..1, blank: false, nullable: false, inList: ['S', 'N', 'A'], attributes: [title: 'tipo'])
        descripcion(size: 1..127, blank: false, nullable: false, attributes: [title: 'descripcion'])
        puntaje(blank: false, nullable: false, attributes: [title: 'puntaje'])
    }
}