package teleh

class Persona {

    static auditable = [ignore: ['pin']]

    Convocatoria convocatoria
    Provincia provincia
    Canton canton
    Parroquia parroquia
    Titulo titulo
    Estado estado
    Date dateCreated
    String apellido
    String nombre
    String cedula
    Date fechaNacimiento
    String sexo
    String email
    String etnia
    String promotorCNH
    String lenguaNativa
    String lenguaExtrangera
    String certificadoNativo
    String certificadoExtrangero
    String habla50Nativa
    String habla50Extrangera
    TipoIdioma tipoIdiomaNativo
    String direccion
    String telefonoFijo
    String telefonoCelular
    String nombreComunidad
    Integer experienciaAnio
    Integer experienciaMes
    String trabajoComunitario
    Date fecha1
    Date fecha2
    Date fecha3
    String institucion1
    String institucion2
    String institucion3
    String nombreCurso1
    String nombreCurso2
    String nombreCurso3
    int horas1
    int horas2
    int horas3
//    byte[] tituloArchivo
    String pin
    Integer puntajeTitulo
    Integer puntajeCursos
    Integer puntajeExperiencia
    Integer puntajeTrabajoComunitario
    Integer puntajeBilingue
    Integer puntajePrueba
    Double puntajeEntrevista
    Integer login = 0
    int activo = 1
    String mailPrueba /*enviado si o no*/

    static constraints = {

        convocatoria(blank: true, nullable: true)
        provincia(nullable: true)
        canton(nullable: true)
        parroquia(nullable: true)
        titulo(blank: true, nullable: true)
        estado(blank: true, nullable: true)
        dateCreated(nullable: true, default: new Date())
        apellido(blank: true, nullable: true, size: 1..64, unique: false)
        nombre(blank: true, nullable: true, size: 1..64, unique: false)
        cedula(blank: false, nullable: false, size: 10..10, unique: false)
        fechaNacimiento(nullable: true, unique: false, default: new Date())
        sexo(nullable: true, size: 1..10, inList: ['femenino', 'masculino'])
        email(nullable: false, email: true, size: 1..55)
        etnia(nullable: true, size: 1..16, inList: ['Indígena', 'Mestizo', 'Blanco', 'Montubio', 'Afroecuatoriano'])
        promotorCNH(blank: true, nullable: true, size: 1..2, inList: ['SI', 'NO'], default: 'NO')
        lenguaNativa(blank: true, nullable: true, size: 1..2, inList: ['SI', 'NO'], default: 'NO')
        lenguaExtrangera(blank: true, nullable: true, size: 1..2, inList: ['SI', 'NO'], default: 'NO')
        certificadoNativo(blank: true, nullable: true, size: 1..2, inList: ['SI', 'NO'], default: 'NO')
        certificadoExtrangero(blank: true, nullable: true, size: 1..2, inList: ['SI', 'NO'], default: 'NO')
        habla50Nativa(blank: true, nullable: true, size: 1..2, inList: ['SI', 'NO'], default: 'NO')
        habla50Extrangera(blank: true, nullable: true, size: 1..2, inList: ['SI', 'NO'], default: 'NO')
        tipoIdiomaNativo(blank: true, nullable: true)
        direccion(blank: true, nullable: true, size: 1..128, unique: false)
        telefonoFijo(blank: true, nullable: true, size: 1..24, unique: false)
        telefonoCelular(blank: true, nullable: true, size: 1..24, unique: false)
        nombreComunidad(blank: true, nullable: true, size: 1..63)
        experienciaAnio(blank: true, nullable: true)
        experienciaMes(blank: true, nullable: true)
        trabajoComunitario(blank: true, nullable: true, size: 1..32, inList: ['SI', 'NO'], default: 'NO')
        fecha1(nullable: true, unique: false, default: new Date())
        fecha2(nullable: true, unique: false, default: new Date())
        fecha3(nullable: true, unique: false, default: new Date())
        institucion1(nullable: true, blank: true, default: 'n/d', size: 1..96, unique: false)
        institucion2(nullable: true, blank: true, default: 'n/d', size: 1..96, unique: false)
        institucion3(nullable: true, blank: true, default: 'n/d', size: 1..96, unique: false)
        nombreCurso1(nullable: true, blank: true, default: 'n/d', size: 1..96, unique: false)
        nombreCurso2(nullable: true, blank: true, default: 'n/d', size: 1..96, unique: false)
        nombreCurso3(nullable: true, blank: true, default: 'n/d', size: 1..96, unique: false)
        horas1(nullable: true, default: 0)
        horas2(nullable: true, default: 0)
        horas3(nullable: true, default: 0)
//        tituloArchivo(blank: true, nullable: true, maxSize: 2 * 1024 * 1024)  //max 2 mb
        pin(blank: true, nullable: true, size: 0..255)
        puntajeTitulo(nullable: true, default: 0)
        puntajeCursos(nullable: true, default: 0)
        puntajeExperiencia(nullable: true, default: 0)
        puntajeTrabajoComunitario(nullable: true, default: 0)
        puntajeBilingue(nullable: true, default: 0)
        puntajePrueba(nullable: true, default: 0)
        puntajeEntrevista(nullable: true, default: 0)
        mailPrueba(nullable: true,blank: true)

    }

    static mapping = {
        table 'insc'

        id column: 'insc__id'
        convocatoria column: 'conv__id'
        provincia column: 'prov__id'
        canton column: 'cant__id'
        parroquia column: 'parr__id'
        titulo column: 'titl__id'
        estado column: 'etdo__id'
        dateCreated column: 'created'
        version column: 'version'
        apellido column: 'inscapel'
        nombre column: 'inscnmbr'
        cedula column: 'insccedu'
        fechaNacimiento column: 'inscfecn'
        sexo column: 'inscsexo'
        email column: 'inscmail'
        etnia column: 'inscetni'
        promotorCNH column: 'inscpcnh'
        lenguaNativa column: 'insclenn'
        lenguaExtrangera column: 'insclene'
        certificadoNativo column: 'insccern'
        certificadoExtrangero column: 'insccere'
        habla50Nativa column: 'inscln50'
        habla50Extrangera column: 'inscle50'
        tipoIdiomaNativo column: 'tpididnt'
        direccion column: 'inscdire'
        telefonoFijo column: 'insctelf'
        telefonoCelular column: 'insctelc'
        nombreComunidad column: 'insccmnd'
        experienciaAnio column: 'inscexan'
        experienciaMes column: 'inscexms'
        trabajoComunitario column: 'insccomu'
        fecha1 column: 'inscfec1'
        fecha2 column: 'inscfec2'
        fecha3 column: 'inscfec3'
        institucion1 column: 'inscins1'
        institucion2 column: 'inscins2'
        institucion3 column: 'inscins3'
        nombreCurso1 column: 'insccur1'
        nombreCurso2 column: 'insccur2'
        nombreCurso3 column: 'insccur3'
        horas1 column: 'horas1'
        horas2 column: 'horas2'
        horas3 column: 'horas3'
//        tituloArchivo column: 'titulo', sqlType: "blob"
        pin column: 'insc_pin'
        puntajeTitulo column: 'inscpttt'
        puntajeCursos column: 'inscptcr'
        puntajeExperiencia column: 'inscptex'
        puntajeTrabajoComunitario column: 'inscpttc'
        puntajeBilingue column: 'inscptbl'
        puntajePrueba column: 'inscptpb'
        puntajeEntrevista column: 'inscptet'
        login column: 'insclgin'
        activo column: 'inscactv'
        mailPrueba column: 'inscmlpr'
    }

    String toString() {
        return apellido + " " + nombre
    }
}
