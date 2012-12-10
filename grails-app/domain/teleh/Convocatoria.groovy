package teleh

class Convocatoria implements Serializable {
    static auditable = [ignore: ['']]

    String descripcion
    Date fechaInicio
    Date fechaFin
    Date fechaRegistro
    String textoInicio
    String textoNota
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
            fechaRegistro column:'convfcrg'
            textoInicio column: 'auxltxin'
            textoNota column: 'auxltxnt'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
        fechaInicio(blank: false, nullable: false, attributes: [title: 'fecha inicio'])
        fechaFin(blank: false, nullable: false, attributes: [title: 'fecha fin'])
        fechaRegistro(blank: true, nullable: true, attributes: [title: 'fecha registro'])
        textoInicio(size: 1..1024)
        textoNota(size: 1..1024)
    }
}
