package teleh

class PersonaAdmController extends teleh.seguridad.Shield {

    def dbConnectionService

    def index() {}

    def fixCursos() {
        def sql = "select i.insc__id     id,\n" +
                "        (select count(c.crso__id) from crso c where i.insc__id = c.insc__id) cant\n" +
                "  from insc i\n" +
                "  where inscfec1 is not null\n" +
                "          or inscfec2 is not null\n" +
                "          or inscfec3 is not null\n" +
                "          or horas1 > 0\n" +
                "          or horas2 > 0\n" +
                "          or horas3 > 0\n" +
                "          or inscins1 is not null\n" +
                "          or inscins2 is not null\n" +
                "          or inscins3 is not null\n" +
                "          or insccur1 is not null\n" +
                "          or insccur2 is not null\n" +
                "          or insccur3 is not null\n" +
                "  having (select count(c.crso__id) from crso c where i.insc__id = c.insc__id) = 0"
        def res = []
        def cn = dbConnectionService.getConnection()
        cn.eachRow(sql) { row ->
            def persona = Persona.get(row.id)

            if (persona.fecha1 || persona.horas1 > 0 || persona.institucion1 || persona.nombreCurso1) {
                //println "CURSO 1: " + persona.fecha1 + "  " + persona.horas1 + "   " + persona.institucion1 + "   " + persona.nombreCurso1
                def curso1 = new CursoPersona()
                curso1.persona = persona
                curso1.fecha = persona.fecha1
                curso1.horas = persona.horas1
                curso1.institucion = persona.institucion1
                curso1.nombre = persona.nombreCurso1
                if (curso1.save(flush: true)) {
                    println "curso 1 saved ok"
                } else {
                    println "curso 1 not saved"
                    println curso1.errors
                }
            }
            if (persona.fecha2 || persona.horas2 > 0 || persona.institucion2 || persona.nombreCurso2) {
                println "CURSO 2: " + persona.fecha2 + "  " + persona.horas2 + "   " + persona.institucion2 + "   " + persona.nombreCurso2
                def curso2 = new CursoPersona()
                curso2.persona = persona
                curso2.fecha = persona.fecha2
                curso2.horas = persona.horas2
                curso2.institucion = persona.institucion2
                curso2.nombre = persona.nombreCurso2
                if (curso2.save(flush: true)) {
                    println "curso 2 saved ok"
                } else {
                    println "curso 2 not saved"
                    println curso2.errors
                }
            }
            if (persona.fecha3 || persona.horas3 > 0 || persona.institucion3 || persona.nombreCurso3) {
                //println "CURSO 3: " + persona.fecha3 + "  " + persona.horas3 + "   " + persona.institucion3 + "   " + persona.nombreCurso3
                def curso3 = new CursoPersona()
                curso3.persona = persona
                curso3.fecha = persona.fecha3
                curso3.horas = persona.horas3
                curso3.institucion = persona.institucion3
                curso3.nombre = persona.nombreCurso3
                if (curso3.save(flush: true)) {
                    println "curso 3 saved ok"
                } else {
                    println "curso 3 not saved"
                    println curso3.errors
                }
            }

            res.add(persona)
        }
        cn.close()
        return [res: res]
    }

    def list() {
//        println "params "+params
        def where = ""
        def est = null

        def strEstado = params.estado
        if (!params.id) {
            params.id = 1
        }
        where+=" and i.conv__id = ${params.id}"
        if (params.provincia && params.provincia != "") {
            where+=" and i.prov__id = ${params.provincia}"
        }
        if (!params.estado || params.estado == "-1") {
            strEstado = "is not null"
        }else{
            params.estado = params.estado
            est = Estado.get(params.estado.toLong())
            strEstado = "="+ params.estado
        }
        if (!params.max || params.max == 0) {
            params.max = 100
        } else {
            params.max = params.max.toInteger()
        }
        if (!params.offset) {
            params.offset = 0
        } else {
            params.offset = params.offset.toInteger()
        }
        if (!params.sort) {
            params.sort = "4"
        }
        if (!params.order) {
            params.order = "asc"
        }
        if (params.busqueda && params.busqueda!="") {
            where += " and (upper(i.inscnmbr) like '%${params.busqueda.toUpperCase()}%' or upper(i.inscapel) like '%${params.busqueda.toUpperCase()}%' or i.insccedu like '%${params.busqueda}%') "
        }

        if (params.datos == '1') {
            where+=" and inscnmbr IS NOT NULL and inscapel IS NOT NULL"
        } else if (params.datos == "0") {
            where+=" and inscnmbr IS NULL and inscapel IS NULL"
        }
//        println "where "+where

        def prov = null

        def conv = Convocatoria.get(params.id.toLong())
        def cn = dbConnectionService.getConnection()
        def total =0
        def sqlTotal =  "\n" +
                "SELECT\n" +
                "  count(*)\n" +
                "FROM insc i\n" +
                "  WHERE i.etdo__id ${strEstado}  ${where}"
        println "sqlTotal: " + sqlTotal
        cn.eachRow(sqlTotal.toString()){r->
            total=r[0]
            //println "r "+r
        }
        def subQuery ="(select count(r.resp__id) from encu e,dtle d,resp r where e.prsp__id= i.insc__id and e.encu__id=d.encu__id and d.resp__id = r.resp__id and r.correcta = 1)"
        def sql = "\n" +
                "SELECT\n" +
                "  i.insc__id,\n" +
                "  i.inscnmbr,\n" +
                "  i.inscapel,\n" +
                "  p.provnmbr,\n" +
                "  c.cantnmbr,\n" +
                "  t.titldscr,\n" +
                "  i.inscsexo,\n"+
                "  i.insccedu,\n"+
                "  e.etdodscr,\n"+
                "  i.inscpcnh,\n" +
                "  ${subQuery}\n" +
                "FROM insc i\n" +
                "  LEFT JOIN prov p ON i.prov__id = p.prov__id\n" +
                "  LEFT JOIN cant c ON i.cant__id = c.cant__id\n" +
                "  LEFT JOIN titl t ON i.titl__id = t.titl__id\n" +
                "  LEFT JOIN etdo e ON i.etdo__id = e.etdo__id\n" +
                "WHERE i.etdo__id  ${strEstado}  ${where} \n" +
                "ORDER BY ${params.sort} ${params.order} limit ${params.max} offset ${params.offset};"

        println "sql "+sql
//
        def res = []
//        println "sql "+sql
        cn.eachRow(sql.toString()){r->
            res.add(r.toRowResult())
//            println "r "+r
        }

//        println "paso sql"


        params.totalRows = total
        params.label = "Se encontr" + (params.totalRows == 1 ? "ó" : "aron") + " <b>${params.totalRows}</b> inscrito" + (params.totalRows == 1 ? "" : "s") + " a la <u>convocatoria <i>${conv.descripcion}</i></u>"
        if (params.provincia) {
            prov = Provincia.get(params.provincia)
            params.label += " en la <u>provincia de <i>${prov.nombre}</i></u>"
        } else {
            params.label += " en <u>todas las provincias</u>"
        }
        if (est) {
            params.label += " con <u>estado <i>${est.descripcion}</i></u>"
        } else {
            params.label += " con <u>cualquier estado</u>"
        }
        if (params.datos == '1') {
            params.label += " que <u>ya han ingresado sus datos</u>"
        } else if (params.datos == "0") {
            params.label += " que <u>aún no han ingresado sus datos</u>"
        }
        if (params.busqueda) {
            params.label += " y cuyo <u>nombre, apellido o cédula contenga <i>${params.busqueda}</i></u>"
        }
        def totalConv = 0
        def totalDatos = null
        def totalCalificados = 0
        def enc = null
        def sqlTotales = "select etdo__id,count(*),(select count(*) from insc where conv__id = ${params.id} and inscnmbr IS NOT NULL and inscapel IS NOT NULL),(select count(*) from encu)   from insc where conv__id = ${params.id} group by 1"
//        println "sql tot "+sqlTotales
        cn.eachRow(sqlTotales.toString()){r->
            if (!totalDatos)
                totalDatos=r[2]
            if (!enc)
                enc = r[3]
            if(r[0]==2)
                totalCalificados=r[1]
            totalConv+=r[1]

        }

        params.totales = "En la convocatoria <i>${conv.descripcion}</i> se encontraron <b>${totalConv}</b> inscritos, de los cuales <b>${totalDatos}</b> ya han ingresado sus datos"

        params.calificados = "Hay ${totalCalificados} postulante${totalCalificados == 1 ? '' : 's'} calificado${totalCalificados == 1 ? '' : 's'}"
        params.calificados += " y ${enc} ex${enc == 1 ? 'a' : 'á'}men${enc == 1 ? '' : 'es'} efectuado${enc == 1 ? '' : 's'}"
        cn.close()
        [res: res, params: params]
    }

    def cambiaConvocatoria() {
        def conv = Convocatoria.get(params.id)
        def personas = Persona.findAllByConvocatoria(conv)
        return [personaInstanceList: personas]
    }

    def show_ajax() {
        def personaInstance = Persona.get(params.id)
        if (!personaInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Persona con id " + params.id
            redirect(action: "list")
            return
        }
        [personaInstance: personaInstance]
    } //show


    def titulo_ajax() {
        def personaInstance = new Persona(params)
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Persona con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [personaInstance: personaInstance]
    } //form_ajax


    def uploadTitulo() {
        def archivo = request.getFile("tituloArchivo")
        // List of OK mime-types
        def okcontents = ['image/png', 'image/jpeg', 'image/gif', 'application/pdf']
        if (!okcontents.contains(archivo.getContentType())) {
            flash.clase = "alert-error"
            flash.message = "El archivo del titulo debe ser de tipo ${okcontents}"
            redirect(action: 'list')
            return;
        }
        params.tipoArchivo = archivo.getContentType()
        def titulo
        def persona = Persona.get(params.persona.id)
        def tituloExistente = TituloPersona.findAllByPersona(persona)
        if (tituloExistente.size() == 0) {
            titulo = new TituloPersona()
        } else if (tituloExistente.size() == 1) {
            titulo = tituloExistente[0]
        } else {
            flash.clase = "alert-error"
            flash.message = "Error grave"
        }
        titulo.properties = params
        if (titulo.save(flush: true)) {
            flash.clase = "alert-success"
            flash.message = "Se ha cargado correctamente el título de la Persona " + persona.nombre + " " + persona.apellido
        } else {
            flash.clase = "alert-error"
            def str = "<h4>No se pudo guardar el título de la Persona " + persona.nombre + " " + persona.apellido + "</h4>"

            str += "<ul>"
            titulo.errors.allErrors.each { err ->
                def msg = err.defaultMessage
                err.arguments.eachWithIndex { arg, i ->
                    msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                }
                str += "<li>" + msg + "</li>"
            }
            str += "</ul>"

            flash.message = str
        }
        redirect(action: 'list')
    }

    def verTitulo() {
        def persona = Persona.get(params.id)

        return [persona: persona]
    }

    def cambiarEstado() {
        def persona = Persona.get(params.id)
        if (params.estado == "S") {
            sendMail {
                to persona.email
                from "info@infa.gob.ec"
                subject "Archivo de título"
                html g.render(template: "subir_titulo", model: [prsn: persona])
            }
            render "OK_" + (persona.estado ? persona.estado.descripcion : "")
        } else {
            def estado = Estado.findByCodigo(params.estado)
            persona.estado = estado
            if (persona.save(flush: true)) {
                render "OK_" + estado.descripcion
            } else {
                render "NO"
            }
        }
    }

    def verArchivoTitulo() {
        def tituloPersona = TituloPersona.findByPersona(Persona.get(params.id))

        if (!tituloPersona || !tituloPersona.tituloArchivo || !tituloPersona.tipoArchivo) {
            response.sendError(404)
            return;
        }
        response.setContentType(tituloPersona.tipoArchivo)
        response.setContentLength(tituloPersona.tituloArchivo.size())
        OutputStream out = response.getOutputStream();
        out.write(tituloPersona.tituloArchivo);
        out.close();
    }


    def fix() {
        //para probar:
        /*
        select group_concat(insc__id), insccedu, count(insccedu) from insc group by insccedu having count(insccedu) >1;

        select insc__id, ttprtipo, count(insc__id) from ttpr group by insc__id order by 1;
         */
        def sql = "select insccedu, count(insccedu) from insc group by insccedu having count(insccedu) >1";
        def cn = dbConnectionService.getConnection()
        cn.eachRow(sql) { r ->

            def prsn = Persona.findAllByCedula(r[0], [sort: "id"])
            def noDelete
            def titulo
            def cursos
            def ultimo = prsn.pop()
            noDelete = prsn[0]
            prsn.remove(0)
            if (!noDelete.pin)
                println 'wtf'
            ultimo.properties.each {
                if (!it.key.endsWith("Id") && it.key != "id") {
                    if (it.value && noDelete.properties[it.key] != it.value) {
//                        println "cambio " + it + "   de " + noDelete.properties[it.key] + "   a " + it.value
                        noDelete.properties[it.key] = it.value
                    }
                } else {
//                    println ">>" + it.key
                }
            }
            titulo = TituloPersona.findByPersona(ultimo)
//            print "borraciones  "
            prsn.each { pr ->
                if (!titulo)
                    titulo = TituloPersona.findByPersona(pr)
//                print " " + pr.id
                pr.delete(flush: true)
            }

            if (titulo) {
                titulo.persona = noDelete
                titulo.save(flush: true)
            }
//            print " " + ultimo.id + "\n"
            ultimo.delete(flush: true)
//            println "save no delete " + noDelete.id
//            println "------------------------------------------------------"
            noDelete.save(flush: true)


        }


    }

}
