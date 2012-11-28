package teleh

class CursoPersona {
    static auditable = [ignore: ['']]

    Persona persona

    Date fecha
    String institucion
    String nombre
    Integer horas

    static mapping = {
        table 'crso'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crso__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'crso__id'
            persona column: 'insc__id'
            fecha column: 'crsofcha'
            institucion column: 'crsoinst'
            nombre column: 'crsonmbr'
            horas column: 'crsohras'
        }
    }
    static constraints = {
        persona(blank: false, nullable: false)
        fecha(nullable: false, default: new Date())
        institucion(nullable: false, blank: false, default: 'n/d', size: 1..96, unique: false)
        nombre(nullable: false, blank: false, default: 'n/d', size: 1..96, unique: false)
        horas(nullable: false, default: 0)
    }
}
