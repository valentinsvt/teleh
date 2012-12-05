package teleh

class Respuesta {

    static auditable = [ignore: ['']]

    Pregunta pregunta
    String respuesta
    int correcta=0 //0->incorrecta, 1-> correcta

    static mapping = {
        table 'resp'
        cache usage:'read-write', include:'non-lazy'
        id column:'resp__id'
        id generator:'identity'
        version false
        columns {
            id column:'resp__id'
            pregunta column: 'preg__id'
            respuesta column: 'respresp'
        }
    }
    static constraints = {
        pregunta(nullable: false)
        respuesta(nullable: false,blank:false,size:1..1024)
    }

    String toString(){
        "${this.respuesta}"
    }
}
