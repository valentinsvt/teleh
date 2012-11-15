package teleh

class Inscripcion {

  static classDescription = ["Registro de Inscripción","parvularias","*"]

  String    apellidos
  String    nombres
  String    cedula
  Date      fechaNacimiento
  Provincia provinciaNacimiento
  Canton    cantonNacimiento
  String    etnia
  String    sexo
  String    formacion
  String    titulo
  String    lenguaNativa
  String    lenguaExtrangera
  String    certificadoNativo
  String    certificadoExtrangero
  String    otraProvincia
  String    otraCanton
  Provincia queOtraProvincia
  Canton    queOtraCanton
  int       mesesEnNivelInicialPrimario
  String    trabajoComunitario
  Date      fecha1
  Date      fecha2
  Date      fecha3
  String    institucion1
  String    institucion2
  String    institucion3
  String    nombreCurso1
  String    nombreCurso2
  String    nombreCurso3
  int       horas1
  int       horas2
  int       horas3
  String    email
  Provincia provincia
  Canton    canton
  Parroquia parroquia
  String    direccion
  String    telefonoFijo
  String    telefonoCelular

  String sysuser
  String status
  Date dateCreated
  Date lastUpdated

  static constraints = {

    apellidos(blank:false,nullable:false,size:1..64,unique:false)
    nombres(blank:false,nullable:false,size:1..64,unique:false)
    cedula(blank:false,nullable:false,size:0..10,unique:true)
    fechaNacimiento(nullable:false,unique:false,default:new Date())
    fecha1(nullable:false,unique:false,default:new Date())
    fecha2(nullable:false,unique:false,default:new Date())
    fecha3(nullable:false,unique:false,default:new Date())
    institucion1(nullable:false,blank:true,default:'n/d',size:1..96,unique:false)
    institucion2(nullable:false,blank:true,default:'n/d',size:1..96,unique:false)
    institucion3(nullable:false,blank:true,default:'n/d',size:1..96,unique:false)
    nombreCurso1(nullable:false,blank:true,default:'n/d',size:1..96,unique:false)
    nombreCurso2(nullable:false,blank:true,default:'n/d',size:1..96,unique:false)
    nombreCurso3(nullable:false,blank:true,default:'n/d',size:1..96,unique:false)
    horas1(nullable:false,default:0)
    horas2(nullable:false,default:0)
    horas3(nullable:false,default:0)
    provinciaNacimiento(nullable:false,unique:false)
    cantonNacimiento(nullable:false,unique:false)
    etnia(nullable:false,size:1..16,inList:['Indígena','Mestizo','Blanco','Montubio','Afroecuatoriano'])
    sexo(nullable:false,size:1..10,inList:['femenino','masculino'])
    formacion(nullable:false,size:1..128,inList:[
           'Educación Parvularia (Título Universitario)',
           'Educación Inicial (Título Universitario)',
           'Educación Preescolar (Título Universitario)',
           'Psicopedagogía (Título Universitario)',
           'Educación Parvularia (Egresado)',
           'Educación Inicial (Egresado)',
           'Educación Preescolar (Egresado)',
           'Psicopedagogía (Egresado)',
           'Educación Parvularia (Título Técnico)',
           'Educación Inicial (Título Técnico)',
           'Educación Preescolar (Título Técnico)',
           'Psicopedagogía (Título Técnico)',
           'Otro (Título Universitario)',
           'Bachiller'])
    titulo(blank:true,nullable:true,size:1..128)
    lenguaNativa(blank:false,nullable:false,size:1..2,inList:['SI','NO'],default:'NO')
    lenguaExtrangera(blank:false,nullable:false,size:1..2,inList:['SI','NO'],default:'NO')
    certificadoNativo(blank:false,nullable:false,size:1..2,inList:['SI','NO'],default:'NO')
    certificadoExtrangero(blank:false,nullable:false,size:1..2,inList:['SI','NO'],default:'NO')
    otraProvincia(blank:false,nullable:false,size:1..2,inList:['SI','NO'],default:'NO')
    otraCanton(blank:false,nullable:false,size:1..2,inList:['SI','NO'],default:'NO')
    queOtraProvincia(nullable:true,unique:false)
    queOtraCanton(nullable:true,unique:false)
    mesesEnNivelInicialPrimario(blank:false,nullable:false,unique:false,default:0)
    trabajoComunitario(blank:false,nullable:false,size:1..32,inList:['SI','NO'],default:'NO')

    email(nullable:false,email:true)
    provincia(nullable:false)
    canton(nullable:false)
    parroquia(nullable:true)
    direccion(blank:false,nullable:false,size:1..128,unique:false)

    telefonoFijo(blank:true,nullable:true,size:1..24,unique:false)
    telefonoCelular(blank:true,nullable:true,size:1..24,unique:false)

    sysuser(nullable:true,size:0..24,default:"?")
    status(nullable:true,size:0..1,default:"1")
    dateCreated(nullable:true,default:new Date())
    lastUpdated(nullable:true,default:new Date())
  }

  static mapping = {
    table 'insc'

    id               column:'insc__id'

    apellidos        column:'inscapel'
    nombres          column:'inscnmbr'
    cedula           column:'insccedu'
    fechaNacimiento  column:'inscfecn'
    provinciaNacimiento column:'inscpnac'
    etnia               column:'inscetni'
    cantonNacimiento    column:'insccnac'
    sexo             column:'inscsexo'
    formacion        column:'inscform'
    lenguaNativa     column:'insclenn'
    lenguaExtrangera column:'insclene'
    certificadoNativo     column:'insccern'
    certificadoExtrangero column:'insccere'
  
    email            column:'inscmail'
    provincia        column:'prov__id'
    canton           column:'cant__id'
    parroquia        column:'parr__id'
    direccion        column:'inscdire'
    telefonoFijo     column:'insctelf'
    telefonoCelular  column:'insctelc'
    otraProvincia    column:'inscotrp'
    otraCanton       column:'inscotrc'
    queOtraProvincia column:'inscprov'
    queOtraCanton    column:'insccant'
    mesesEnNivelInicialPrimario column:'inscexpe'
    trabajoComunitario          column:'insccomu'
    fecha1          column:'inscfec1'
    fecha2          column:'inscfec2'
    fecha3          column:'inscfec3'
    institucion1    column:'inscins1'
    institucion2    column:'inscins2'
    institucion3    column:'inscins3'
    nombreCurso1    column:'insccur1'
    nombreCurso2    column:'insccur2'
    nombreCurso3    column:'insccur3'

    sysuser          column:'sysuser'
    dateCreated      column:'created'
    lastUpdated      column:'updated'
    status           column:'status'
    version          column:'version'
  }

  String toString() {
    return apellidos + "/" + nombres
  }

  String isDeleted() {
    return (status == "0")?"*":"" ;
  }

  static void fillData() {
  }

  boolean testTituloSubido() {
    String path2Titulo = "${File.separator}var${File.separator}mies${File.separator}parvularias${File.separator}${id}"
    File dir = new File(path2Titulo)
    if(dir.exists() && dir.isDirectory()) {
      if(dir.listFiles().size() > 0)
        return true
      else
        return false
    }
    else
      return false
  }

}

//int si = 0
//int no = 0
//registro.Inscripcion.list().each {
//  if(it.testTituloSubido())
//    si++
//  else
//    no++
//}
//println "Títulos Subidos SI = $si, NO = $no"
