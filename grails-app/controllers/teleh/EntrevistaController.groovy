package teleh

class EntrevistaController {


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

    def entrevista() {
        def persona = Persona.get(params.id)

        return [persona: persona]
    }

    def list() {
        if (!params.id) {
            params.id = 1
        }
        if (!params.provincia || params.provincia == "") {
            params.provincia = null
        }
        if (!params.estado || params.estado == "") {
            params.estado = null
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
            params.sort = "apellido"
        }
        if (!params.order) {
            params.order = "asc"
        }
        if (!params.datos) {
            params.datos = "-1"
        }

//        println params

        def prov = null

        def conv = Convocatoria.get(params.id.toLong())
        if (params.provincia) {
            prov = Provincia.get(params.provincia.toLong())
        }
        def est = Estado.get(3)


        def sql = "\n" +
                "SELECT\n" +
                "  i.insc__id,\n" +
                "  e.encu__id,\n" +
                "  i.inscnmbr,\n" +
                "  i.inscapel,\n" +
                "  p.provnmbr,\n" +
                "  c.cantnmbr,\n" +
                "  t.titldscr,\n" +
                "  count(d.dtle__id)\n" +
                "FROM insc i\n" +
                "  INNER JOIN encu e ON i.insc__id = e.prsp__id\n" +
                "  INNER JOIN dtle d ON e.encu__id = d.encu__id\n" +
                "  INNER JOIN resp r ON d.resp__id = r.resp__id AND r.correcta = 1\n" +
                "  LEFT JOIN prov p ON i.prov__id = p.prov__id\n" +
                "  LEFT JOIN cant c ON i.cant__id = c.cant__id\n" +
                "  LEFT JOIN titl t ON i.titl__id = t.titl__id\n" +
                "WHERE i.etdo__id = 3\n" +
                "GROUP BY 1,2\n" +
                "ORDER BY 1;"



    }

    def list_() {
        if (!params.id) {
            params.id = 1
        }
        if (!params.provincia || params.provincia == "") {
            params.provincia = null
        }
        if (!params.estado || params.estado == "") {
            params.estado = null
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
            params.sort = "apellido"
        }
        if (!params.order) {
            params.order = "asc"
        }
        if (!params.datos) {
            params.datos = "-1"
        }

//        println params

        def conv = null, prov = null, est = null

        conv = Convocatoria.get(params.id.toLong())
        if (params.provincia) {
            prov = Provincia.get(params.provincia.toLong())
        }
        est = Estado.get(3)
//
//        println params
        def c = Persona.createCriteria()
        def results = c.list(max: params.max, offset: params.offset) {
            and {
                eq("convocatoria", conv)
                if (params.provincia) {
                    eq("provincia", prov)
                }
//                eq("estado", est)
                if (params.busqueda) {
                    or {
                        ilike("cedula", "%" + params.busqueda + "%")
                        ilike("nombre", "%" + params.busqueda + "%")
                        ilike("apellido", "%" + params.busqueda + "%")
                    }
                }
                isNotNull("nombre")
                isNotNull("apellido")
                order(params.sort, params.order)
            }
        }

        params.totalRows = results.totalCount

        params.label = "Se encontr" + (params.totalRows == 1 ? "ó" : "aron") + " <b>${params.totalRows}</b> inscrito" + (params.totalRows == 1 ? "" : "s") + " a la <u>convocatoria <i>${conv.descripcion}</i></u>"
        if (params.provincia) {
            params.label += " en la <u>provincia de <i>${prov.nombre}</i></u>"
        } else {
            params.label += " en <u>todas las provincias</u>"
        }
        if (params.busqueda) {
            params.label += " y cuyo <u>nombre, apellido o cédula contenga <i>${params.busqueda}</i></u>"
        }

        def totalConv = Persona.findAllByConvocatoria(conv)
        def totalDatos = totalConv.findAll { it.nombre && it.apellido }
        def totalCalificados = totalConv.findAll { it.estadoId == 2 }

        params.totales = "En la convocatoria <i>${conv.descripcion}</i> se encontraron <b>${totalConv.size()}</b> inscritos, de los cuales <b>${totalDatos.size()}</b> ya han ingresado sus datos"
        def enc = Encuesta.count()
        params.calificados = "Hay ${totalCalificados.size()} postulante${totalCalificados.size() == 1 ? '' : 's'} calificado${totalCalificados.size() == 1 ? '' : 's'}"
        params.calificados += " y ${enc} ex${enc == 1 ? 'a' : 'á'}men${enc == 1 ? '' : 'es'} efectuado${enc == 1 ? '' : 's'}"

        [personaInstanceList: results, params: params]
    }
}
