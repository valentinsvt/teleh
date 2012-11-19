package teleh

class TituloPersona {

    Persona persona
    byte[] tituloArchivo
    String tipoArchivo

    static constraints = {
        // Limit upload file size to 2MB
        tituloArchivo maxSize: 1024 * 1024 * 2
    }

    static mapping = {
        table 'ttpr'

        id column: 'ttpr__id'
        persona column: 'insc__id'
        tituloArchivo column: 'ttprarch'
        tipoArchivo column: 'ttprtipo'
    }

}
