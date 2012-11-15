package teleh

class Auxiliar {
    
    String usuario
    String password
    String textoInicio
    String textoNota

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
            textoInicio column: 'auxltxin'
            textoNota column: 'auxltxnt'
        }
    }
    static constraints = {
        usuario(nullable: false,size: 5..10)
        password(nullable: false,size: 1..265)
        textoInicio(size: 1..1024)
        textoNota(size: 1..1024)
    }


}
