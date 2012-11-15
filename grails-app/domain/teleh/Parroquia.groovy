package teleh

class Parroquia {
    static classDescription = ["Parroquia","DPA"]
    String codigo
    String nombre
    String tipo
    Canton canton

    String sysuser
    String status
    Date dateCreated
    Date lastUpdated

    static constraints = {
        codigo(blank:false,nullable:false,size:0..6,default:"?")
        nombre(blank:false,nullable:false,size:0..128,default:"?")
        tipo(nullable:false,size:0..8,inList:['urbana','rural'])

        sysuser(nullable:true,size:0..24,default:"?")
        status(nullable:true,size:0..1,default:"1")
        dateCreated(nullable:true,default:new Date())
        lastUpdated(nullable:true,default:new Date())
    }

    static mapping = {
        table 'parr'

        id        column:'parr__id'

        codigo    column:'parrcdgo'
        nombre    column:'parrnmbr'
        tipo      column:'parrurru'
        canton    column:'cant__id'

        sysuser   column:'sysuser'
        dateCreated   column:'created'
        lastUpdated   column:'updated'
        status   column:'status'
        version   column:'version'
    }

    String toString() {
        return nombre
    }

    String isDeleted() {
        return (status == "0")?"*":"" ;
    }
    
  static void fillData() {

  }

}
