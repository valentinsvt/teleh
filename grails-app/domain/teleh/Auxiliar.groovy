package teleh

class Auxiliar {

    static auditable = [ignore: ['']]

    String usuario
    String descripcion
    String tipo
    String password
    static mapping = {
        table 'auxl'
        cache usage:'read-write', include:'non-lazy'
        id column:'auxl__id'
        id generator:'identity'
        version false
        columns {
            id column:'auxl__id'
            usuario column: 'auxlusro'
            descripcion column: 'auxldscr'
            tipo column: 'auxltpus'
            password column: 'auxlpssw'
        }
    }
    static constraints = {
        usuario(nullable: false,size: 5..20)
        descripcion(nullable: false,size: 1..63)
        tipo(nullable: false,size: 1..1)
        password(nullable: false,size: 1..63)
    }
}
