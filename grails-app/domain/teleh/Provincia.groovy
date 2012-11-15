package teleh

class Provincia {
    static classDescription = ["Provincia","DPA"]
    String codigo                // Código INEC de la Provincia
    String nombre                // Nombre de la Provincia

    String sysuser               // información de control, usuario que crea el objeto
    String status                // información de control, estatus del objeto
    Date dateCreated             // información de control, Fecha de creacíón del objeto
    Date lastUpdated             // información de control, Fecha de última actualización

    static constraints = {
        codigo(blank:false,nullable:false,size:0..2,unique:true)
        nombre(blank:false,nullable:false,size:0..64)

        sysuser(nullable:true,size:0..24,default:"?")
        status(nullable:true,size:0..1,default:"1")
        dateCreated(nullable:true,default:new Date())
        lastUpdated(nullable:true,default:new Date())
    }

    static mapping = {
        table 'prov'

        id            column:'prov__id'

        codigo        column:'provcdgo'
        nombre        column:'provnmbr'

        sysuser       column:'sysuser'
        dateCreated   column:'created'
        lastUpdated   column:'updated'
        status        column:'status'
        version       column:'version'
    }

    String toString() {
        return nombre.toUpperCase()
    }

    String isDeleted() {
        return (status == "0")?"*":"" ;
    }

    static void fillData() {
      if(!teleh.Provincia.get(1)) {new teleh.Provincia(id:1,codigo:'01',nombre:'AZUAY').save(flush:true)}
      if(!teleh.Provincia.get(2)) {new teleh.Provincia(id:2,codigo:'02',nombre:'BOLIVAR').save(flush:true)}
      if(!teleh.Provincia.get(3)) {new teleh.Provincia(id:3,codigo:'03',nombre:'CAÑAR').save(flush:true)}
      if(!teleh.Provincia.get(4)) {new teleh.Provincia(id:4,codigo:'04',nombre:'CARCHI').save(flush:true)}
      if(!teleh.Provincia.get(5)) {new teleh.Provincia(id:5,codigo:'05',nombre:'COTOPAXI').save(flush:true)}
      if(!teleh.Provincia.get(6)) {new teleh.Provincia(id:6,codigo:'06',nombre:'CHIMBORAZO').save(flush:true)}
      if(!teleh.Provincia.get(7)) {new teleh.Provincia(id:7,codigo:'07',nombre:'EL ORO').save(flush:true)}
      if(!teleh.Provincia.get(8)) {new teleh.Provincia(id:8,codigo:'08',nombre:'ESMERALDAS').save(flush:true)}
      if(!teleh.Provincia.get(9)) {new teleh.Provincia(id:9,codigo:'09',nombre:'GUAYAS').save(flush:true)}
      if(!teleh.Provincia.get(10)) {new teleh.Provincia(id:10,codigo:'10',nombre:'IMBABURA').save(flush:true)}
      if(!teleh.Provincia.get(11)) {new teleh.Provincia(id:11,codigo:'11',nombre:'LOJA').save(flush:true)}
      if(!teleh.Provincia.get(12)) {new teleh.Provincia(id:12,codigo:'12',nombre:'LOS RIOS').save(flush:true)}
      if(!teleh.Provincia.get(13)) {new teleh.Provincia(id:13,codigo:'13',nombre:'MANABI').save(flush:true)}
      if(!teleh.Provincia.get(14)) {new teleh.Provincia(id:14,codigo:'14',nombre:'MORONA SANTIAGO').save(flush:true)}
      if(!teleh.Provincia.get(15)) {new teleh.Provincia(id:15,codigo:'15',nombre:'NAPO').save(flush:true)}
      if(!teleh.Provincia.get(16)) {new teleh.Provincia(id:16,codigo:'16',nombre:'PASTAZA').save(flush:true)}
      if(!teleh.Provincia.get(17)) {new teleh.Provincia(id:17,codigo:'17',nombre:'PICHINCHA').save(flush:true)}
      if(!teleh.Provincia.get(18)) {new teleh.Provincia(id:18,codigo:'18',nombre:'TUNGURAHUA').save(flush:true)}
      if(!teleh.Provincia.get(19)) {new teleh.Provincia(id:19,codigo:'19',nombre:'ZAMORA CHINCHIPE').save(flush:true)}
      if(!teleh.Provincia.get(20)) {new teleh.Provincia(id:20,codigo:'20',nombre:'GALAPAGOS').save(flush:true)}
      if(!teleh.Provincia.get(21)) {new teleh.Provincia(id:21,codigo:'21',nombre:'SUCUMBIOS').save(flush:true)}
      if(!teleh.Provincia.get(22)) {new teleh.Provincia(id:22,codigo:'22',nombre:'ORELLANA').save(flush:true)}
      if(!teleh.Provincia.get(23)) {new teleh.Provincia(id:23,codigo:'23',nombre:'SANTO DOMINGO DE LOS TSACHILAS').save(flush:true)}
      if(!teleh.Provincia.get(24)) {new teleh.Provincia(id:24,codigo:'24',nombre:'SANTA ELENA').save(flush:true)}
      if(!teleh.Provincia.get(25)) {new teleh.Provincia(id:25,codigo:'90',nombre:'ZONAS NO DELIMITADAS').save(flush:true)}
    }

}
