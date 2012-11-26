package teleh

class Auxiliar {

    static auditable = [ignore: ['']]

    String usuario
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
            password column: 'auxlpssw'

        }
    }
    static constraints = {
        usuario(nullable: false,size: 5..20)
        password(nullable: false,size: 1..265)


    }


}
