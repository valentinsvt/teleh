package teleh

class Canton {
  
  static classDescription = ["Cantón","DPA"]

  String codigo
  String nombre
  Provincia provincia

  String sysuser
  String status
  Date dateCreated
  Date lastUpdated

  static constraints = {
    codigo(blank:false,nullable:false,size:0..4)
    nombre(blank:false,nullable:false,size:0..64)
    provincia(blank:false,nullable:false)

    sysuser(nullable:true,size:0..24,default:"?")
    status(nullable:true,size:0..1,default:"1")
    dateCreated(nullable:true,default:new Date())
    lastUpdated(nullable:true,default:new Date())
  }

  static mapping = {
    table 'cant'

    id        column:'cant__id'

    codigo    column:'cantcdgo'
    nombre    column:'cantnmbr'
    provincia column:'prov__id'

    sysuser   column:'sysuser'
    dateCreated   column:'created'
    lastUpdated   column:'updated'
    status   column:'status'
    version   column:'version'
  }

  String toString() {
    return nombre
  }

  def isDeleted = {->
    return (status == "0") ? "*" : "";
  }
    
  static void fillData() {
  }

}
