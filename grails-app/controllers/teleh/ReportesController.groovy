package teleh

import com.itextpdf.text.BadElementException
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfWriter
import jxl.Workbook
import jxl.WorkbookSettings
import com.lowagie.text.*
import jxl.write.*

class ReportesController {

    def dbConnectionService

    def index() { }

    def buscadorService
    def reporteBuscador = {

        // //println "reporte buscador params !! "+params
        if (!session.dominio)
            response.sendError(403)
        else {
            def listaTitulos = params.listaTitulos
            def listaCampos = params.listaCampos
            def lista = buscadorService.buscar(session.dominio, params.tabla, "excluyente", params, true, params.extras)
            def funciones = session.funciones
            session.dominio = null
            session.funciones = null
            lista.pop()

            def baos = new ByteArrayOutputStream()
            def name = "reporte_de_" + params.titulo.replaceAll(" ", "_") + "_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
//            //println "name "+name
            Font catFont = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
            Font info = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
            Document document
            if (params.landscape)
                document = new Document(PageSize.A4.rotate());
            else
                document = new Document();

            def pdfw = PdfWriter.getInstance(document, baos);

            document.open();
            document.addTitle("Reporte de " + params.titulo + " " + new Date().format("dd_MM_yyyy"));
            document.addSubject("Generado por el sistema teleh");
            document.addKeywords("reporte, elyon," + params.titulo);
            document.addAuthor("teleh");
            document.addCreator("Tedein SA");
            Paragraph preface = new Paragraph();
            addEmptyLine(preface, 1);
            preface.add(new Paragraph("Reporte de " + params.titulo, catFont));
            preface.add(new Paragraph("Generado por el usuario: " + session.usuario + "   el: " + new Date().format("dd/MM/yyyy hh:mm"), info))
            addEmptyLine(preface, 1);
            document.add(preface);
//        Start a new page
//        document.newPage();
            //System.getProperty("user.name")
            addContent(document, catFont, listaCampos.size(), listaTitulos, params.anchos, listaCampos, funciones, lista);            // Los tamaños son porcentajes!!!!
            document.close();
            pdfw.close()
            byte[] b = baos.toByteArray();
            response.setContentType("application/pdf")
            response.setHeader("Content-disposition", "attachment; filename=" + name)
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        }
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }

    private static void addContent(Document document, catFont, columnas, headers, anchos, campos, funciones, datos) throws DocumentException {
        Font small = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);
        def parrafo = new Paragraph("")
        createTable(parrafo, columnas, headers, anchos, campos, funciones, datos);
        document.add(parrafo);


    }

    private static void createTable(Paragraph subCatPart, columnas, headers, anchos, campos, funciones, datos) throws BadElementException {
        PdfPTable table = new PdfPTable(columnas);
        table.setWidthPercentage(100);
        table.setWidths(arregloEnteros(anchos))
        Font small = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);
        headers.eachWithIndex {h, i ->
            PdfPCell c1 = new PdfPCell(new Phrase(h, small));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(c1);
        }
        table.setHeaderRows(1);
        def tagLib = new BuscadorTagLib()
        datos.each {d ->
            campos.eachWithIndex {c, j ->
                def campo
                if (funciones) {
                    if (funciones[j])
                        campo = tagLib.operacion([propiedad: c, funcion: funciones[j], registro: d]).toString()
                    else
                        campo = d.properties[c].toString()
                } else {
                    campo = d.properties[c].toString()
                }

                table.addCell(new Phrase(campo, small));

            }

        }

        subCatPart.add(table);

    }

    private static void createList(Section subCatPart) {
        List list = new List(true, false, 10);
        list.add(new ListItem("First point"));
        list.add(new ListItem("Second point"));
        list.add(new ListItem("Third point"));
        subCatPart.add(list);
    }

    static arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex {it, i ->
            ia[i] = it.toInteger()
        }

        return ia
    }

    def listaPersonasPdf() {
        if (!params.id) {
            params.id = 1
        }
        if (!params.provincia || params.provincia == "") {
            params.provincia = null
        }
        if (!params.estado || params.estado == "") {
            params.estado = null
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

        def filtroProv = "", filtroEst = "", tipoJoin = "", filtroDatos = "", filtroBusqueda = "", sort = ""

        switch (params.sort) {
            case "provincia":
                sort = "p.provnmbr"
                break;
            case "canton":
                sort = "c.cantnmbr"
                break;
            case "titulo":
                sort = "t.titldscr"
                break;
            case "cedula":
                sort = "i.insccedu"
                break;
            case "apellido":
                sort = "i.inscapel"
                break;
            case "sexo":
                sort = "i.inscsexo"
                break;
            case "estado":
                sort = "e.etdodscr"
                break;
        }

        if (params.provincia) {
            filtroProv = " and p.prov__id=" + params.provincia + "\n"
        }
        if (params.estado) {
            filtroEst = " and e.etdo__id=" + params.estado + "\n"
        }
        if (params.datos == '-1') { //todos
            tipoJoin = "left"
        } else if (params.datos == '0') { //sin datos
            tipoJoin = "left"
            filtroDatos = " and i.inscapel is not null and i.inscnmbr is not null" + "\n"
        } else if (params.datos == '1') { //con datos
            tipoJoin = "inner"
        }
        if (params.busqueda) {
            filtroBusqueda = " and (upper(i.inscapel) like '%upper(" + params.busqueda + ")%' or upper(i.inscnmbr) like '%upper(" + params.busqueda + ")%') or i.insccedu like '%" + params.busqueda + "%'" + "\n"
        }

        def baseSql = "select" + "\n"
        baseSql += "        p.provnmbr                           prov," + "\n"
        baseSql += "        c.cantnmbr                          cant," + "\n"
        baseSql += "        t.titldscr                          titulo," + "\n"
        baseSql += "        i.insccedu                          cedula," + "\n"
        baseSql += "        concat(i.inscapel,\", \", i.inscnmbr)  nombres," + "\n"
        baseSql += "        i.inscsexo                          genero," + "\n"
        baseSql += "        e.etdodscr                          estado" + "\n"
        baseSql += "  from insc i" + "\n"
        baseSql += "          " + tipoJoin + " join prov p on i.prov__id=p.prov__id" + "\n"
        baseSql += "          " + tipoJoin + " join cant c on i.cant__id=c.cant__id" + "\n"
        baseSql += "          " + tipoJoin + " join titl t on i.titl__id=t.titl__id" + "\n"
        baseSql += "          " + tipoJoin + " join etdo e on i.etdo__id=e.etdo__id" + "\n"
        baseSql += "  where i.conv__id=" + params.id + "\n"
        baseSql += filtroProv
        baseSql += filtroEst
        baseSql += filtroDatos
        baseSql += filtroBusqueda
        baseSql += " order by " + sort + " " + params.order

//        //println baseSql

        def cn = dbConnectionService.getConnection()

        def rows = 0
        def results = []

        cn.eachRow(baseSql) { row ->
//            //println row.titulo
            def m = [:]
            m.provincia = row.prov
            m.canton = row.cant
            m.titulo = row.titulo
            m.cedula = row.cedula
            m.nombres = row.nombres
            m.genero = row.genero
            m.estado = row.estado
            results.add(m)
            rows++
        }

        cn.close()

        params.totalRows = rows

//        params.label = "Se encontr" + (params.totalRows == 1 ? "ó" : "aron") + " <b>${params.totalRows}</b> inscrito" + (params.totalRows == 1 ? "" : "s") + " a la convocatoria ${conv.descripcion}"
        params.label = "Inscritos a la convocatoria ${Convocatoria.get(params.id).descripcion}"
        if (params.provincia) {
            params.label += " en la provincia de ${Provincia.get(params.provincia).nombre}"
        } else {
            params.label += " en todas las provincias"
        }
        if (params.estado) {
            params.label += " con estado ${Estado.get(params.estado).descripcion}"
        } else {
            params.label += " con cualquier estado"
        }
        if (params.datos == '1') {
            params.label += " que ya han ingresado sus datos"
        } else if (params.datos == "0") {
            params.label += " que aún no han ingresado sus datos"
        }
        if (params.busqueda) {
            params.label += " y cuyo nombre, apellido o cédula contenga ${params.busqueda}"
        }

        return [params: params, results: results]
    }

    def listaPersonasPdfObj() {
        if (!params.id) {
            params.id = 1
        }
        if (!params.provincia || params.provincia == "") {
            params.provincia = null
        }
        if (!params.estado || params.estado == "") {
            params.estado = null
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

        def conv, prov, est

        conv = Convocatoria.get(params.id.toLong())
        if (params.provincia) {
            prov = Provincia.get(params.provincia.toLong())
        }
        if (params.estado) {
            est = Estado.get(params.estado.toLong())
        }

//        //println params
        def c = Persona.createCriteria()
        def results = c.list() {
            and {
                eq("convocatoria", conv)
                if (params.provincia) {
                    eq("provincia", prov)
                }
                if (params.estado) {
                    eq("estado", est)
                }
                if (params.busqueda) {
                    or {
                        ilike("cedula", "%" + params.busqueda + "%")
                        ilike("nombre", "%" + params.busqueda + "%")
                        ilike("apellido", "%" + params.busqueda + "%")
                    }
                }
                if (params.datos == "0") { //sin datos: no nombre ni apellido
                    isNull("nombre")
                    isNull("apellido")
                } else if (params.datos == "1") { //con datos: con nombre y apellido
                    isNotNull("nombre")
                    isNotNull("apellido")
                }
                order(params.sort, params.order)
            }
        }

        params.totalRows = results.size()

//        params.label = "Se encontr" + (params.totalRows == 1 ? "ó" : "aron") + " <b>${params.totalRows}</b> inscrito" + (params.totalRows == 1 ? "" : "s") + " a la convocatoria ${conv.descripcion}"
        params.label = "Inscritos a la convocatoria ${conv.descripcion}"
        if (params.provincia) {
            params.label += " en la provincia de ${prov.nombre}"
        } else {
            params.label += " en todas las provincias"
        }
        if (params.estado) {
            params.label += " con estado ${est.descripcion}"
        } else {
            params.label += " con cualquier estado"
        }
        if (params.datos == '1') {
            params.label += " que ya han ingresado sus datos"
        } else if (params.datos == "0") {
            params.label += " que aún no han ingresado sus datos"
        }
        if (params.busqueda) {
            params.label += " y cuyo nombre, apellido o cédula contenga ${params.busqueda}"
        }

        [personaInstanceList: results, params: params]
    }


    def listaPersonasXls() {
        if (!params.id) {
            params.id = 1
        }
        if (!params.provincia || params.provincia == "") {
            params.provincia = null
        }
        if (!params.estado || params.estado == "") {
            params.estado = null
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

        def datos = [
                [etiqueta: "CONVOCATORIA", campo: "o.convdscr", alias: "conv", width: 25],
                [etiqueta: "PROVINCIA", campo: "p.provnmbr", alias: "prov", width: 25],
                [etiqueta: "CANTON", campo: "c.cantnmbr", alias: "cant", width: 25],
                [etiqueta: "PARROQUIA", campo: "a.parrnmbr", alias: "parr", width: 25],
                [etiqueta: "COMUNIDAD", campo: "i.insccmnd", alias: "comu", width: 25],
                [etiqueta: "CEDULA", campo: "i.insccedu", alias: "cedula", width: 13],
                [etiqueta: "APELLIDOS", campo: "i.inscapel", alias: "apellido", width: 25],
                [etiqueta: "NOMBRES", campo: "i.inscnmbr", alias: "nombre", width: 25],
                [etiqueta: "FECHA NACIMIENTO", campo: "DATE_FORMAT(i.inscfecn,'%d-%m-%Y')", alias: "fecnac", width: 25],
                [etiqueta: "TITULO", campo: "t.titldscr", alias: "titulo", width: 25],
                [etiqueta: "ESTADO", campo: "e.etdodscr", alias: "estado", width: 12],
                [etiqueta: "GENERO", campo: "i.inscsexo", alias: "genero", width: 12],
                [etiqueta: "EMAIL", campo: "i.inscmail", alias: "mail", width: 25],
                [etiqueta: "ETNIA", campo: "i.inscetni", alias: "etnia", width: 13],
                [etiqueta: "PROMOTOR CNH", campo: "i.inscpcnh", alias: "prom", width: 10],
                [etiqueta: "HABLA L. NATIVA", campo: "i.insclenn", alias: 'lnat', width: 10],
                [etiqueta: "CERTIFICADO L. NATIVA", campo: "i.insccern", alias: 'cnat', width: 10],
                [etiqueta: "MAS DE 50% L. NATIVA", campo: "i.inscln50", alias: 'cinat', width: 10],
                [etiqueta: "L. NATIVA", campo: "ti.tpiddscr", alias: "tipoid", width: 13],
                [etiqueta: "HABLA L. EXTR.", campo: "i.insclene", alias: "lext", width: 10],
                [etiqueta: "CERTIFICADO L. EXTR.", campo: "i.insccere", alias: "cext", width: 10],
                [etiqueta: "MAS DE 50% L. EXTR.", campo: "i.inscle50", alias: "ciext", width: 10],
                [etiqueta: "DIRECCION", campo: "i.inscdire", alias: "dire", width: 25],
                [etiqueta: "TELEFONO FIJO", campo: "i.insctelf", alias: "tel", width: 13],
                [etiqueta: "CELULAR", campo: "i.insctelc", alias: "celu", width: 13],
                [etiqueta: "EXPERIENCIA A.", campo: "i.inscexan", alias: "exan", width: 10],
                [etiqueta: "EXPERIENCIA M.", campo: "i.inscexms", alias: "exms", width: 10],
                [etiqueta: "TRABAJO COM.", campo: "i.insccomu", alias: 'trcm', width: 10]
        ]

        def filtroProv = "", filtroEst = "", tipoJoin = "", filtroDatos = "", filtroBusqueda = "", sort = ""

        switch (params.sort) {
            case "provincia":
                sort = "p.provnmbr"
                break;
            case "canton":
                sort = "c.cantnmbr"
                break;
            case "titulo":
                sort = "t.titldscr"
                break;
            case "cedula":
                sort = "i.insccedu"
                break;
            case "apellido":
                sort = "i.inscapel"
                break;
            case "sexo":
                sort = "i.inscsexo"
                break;
            case "estado":
                sort = "e.etdodscr"
                break;
        }

        if (params.provincia) {
            filtroProv = " and p.prov__id=" + params.provincia + "\n"
        }
        if (params.estado) {
            filtroEst = " and e.etdo__id=" + params.estado + "\n"
        }
        if (params.datos == '-1') { //todos
            tipoJoin = "left"
        } else if (params.datos == '0') { //sin datos
            tipoJoin = "left"
            filtroDatos = " and i.inscapel is not null and i.inscnmbr is not null" + "\n"
        } else if (params.datos == '1') { //con datos
            tipoJoin = "inner"
        }
        if (params.busqueda) {
            filtroBusqueda = " and (upper(i.inscapel) like '%upper(" + params.busqueda + ")%' or upper(i.inscnmbr) like '%upper(" + params.busqueda + ")%') or i.insccedu like '%" + params.busqueda + "%'" + "\n"
        }

        def baseSql = "select" + "\n"

        datos.eachWithIndex { dt, i ->
            baseSql += "      " + dt.campo + "    " + dt.alias
            if (i < datos.size() - 1) {
                baseSql += ","
            }
            baseSql += "\n"
        }

        baseSql += "  from insc i" + "\n"
        baseSql += "          inner join conv o on i.conv__id=o.conv__id" + "\n"
        baseSql += "          " + tipoJoin + " join prov p on i.prov__id=p.prov__id" + "\n"
        baseSql += "          " + tipoJoin + " join cant c on i.cant__id=c.cant__id" + "\n"
        baseSql += "          " + tipoJoin + " join parr a on i.parr__id=a.parr__id" + "\n"
        baseSql += "          " + tipoJoin + " join titl t on i.titl__id=t.titl__id" + "\n"
        baseSql += "          " + tipoJoin + " join etdo e on i.etdo__id=e.etdo__id" + "\n"
        baseSql += "          left join tpid ti on i.tpididnt=ti.tpid__id" + "\n"
        baseSql += "  where i.conv__id=" + params.id + "\n"
        baseSql += filtroProv
        baseSql += filtroEst
        baseSql += filtroDatos
        baseSql += filtroBusqueda
        baseSql += " order by " + sort + " " + params.order

        params.label = "Inscritos a la convocatoria ${Convocatoria.get(params.id).descripcion}"
        if (params.provincia) {
            params.label += " en la provincia de ${Provincia.get(params.provincia).nombre}"
        } else {
            params.label += " en todas las provincias"
        }
        if (params.estado) {
            params.label += " con estado ${Estado.get(params.estado).descripcion}"
        } else {
            params.label += " con cualquier estado"
        }
        if (params.datos == '1') {
            params.label += " que ya han ingresado sus datos"
        } else if (params.datos == "0") {
            params.label += " que aún no han ingresado sus datos"
        }
        if (params.busqueda) {
            params.label += " y cuyo nombre, apellido o cédula contenga ${params.busqueda}"
        }

        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile(params.filename, '.xls')
        file.deleteOnExit()
        //println "paso"
        WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat formatXls = new WritableCellFormat(font)

        WritableSheet sheet = workbook.createSheet('Reporte', 0)

        WritableFont tituloFont = new WritableFont(WritableFont.TIMES, 14, WritableFont.BOLD, true);
        WritableCellFormat tituloFormat = new WritableCellFormat(tituloFont);

        WritableFont titulo2Font = new WritableFont(WritableFont.TIMES, 13, WritableFont.BOLD, true);
        WritableCellFormat titulo2Format = new WritableCellFormat(titulo2Font);

        WritableFont times11font = new WritableFont(WritableFont.TIMES, 12, WritableFont.BOLD, true);
        WritableCellFormat times16format = new WritableCellFormat(times11font);

        WritableFont times11font2 = new WritableFont(WritableFont.TIMES, 10, WritableFont.NO_BOLD, true);
        WritableCellFormat times16format2 = new WritableCellFormat(times11font2);

        // inicia textos y numeros para asocias a columnas
        def label = new Label(0, 1, "Texto", times16format);
        def nmro = new Number(12, 1, 9999);

        label = new Label(0, 0, "Lista de personas", tituloFormat); sheet.addCell(label)
        label = new Label(0, 1, params.label, titulo2Format); sheet.addCell(label)

        def filaIni = 3
        datos.eachWithIndex {l, columna ->
            //headers
            sheet.setColumnView(columna, l.width)
            label = new Label(columna, filaIni, l.etiqueta, times16format); sheet.addCell(label)
        }

        //println baseSql

        def cn = dbConnectionService.getConnection()
        def fila = 0
        cn.eachRow(baseSql) { row ->
            datos.eachWithIndex { d, col ->
                def val = row[d.alias]
                if (!val) {
                    val = ""
                }
                label = new Label(col, fila + filaIni + 1, val.toString(), times16format2); sheet.addCell(label)
            }
            fila++
        }

        cn.close()

        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + params.filename;
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

    def listaPersonasXlsObj() {
        if (!params.id) {
            params.id = 1
        }
        if (!params.provincia || params.provincia == "") {
            params.provincia = null
        }
        if (!params.estado || params.estado == "") {
            params.estado = null
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

        def conv, prov, est

        conv = Convocatoria.get(params.id.toLong())
        if (params.provincia) {
            prov = Provincia.get(params.provincia.toLong())
        }
        if (params.estado) {
            est = Estado.get(params.estado.toLong())
        }

//        //println params
        def c = Persona.createCriteria()
        def results = c.list() {
            and {
                eq("convocatoria", conv)
                if (params.provincia) {
                    eq("provincia", prov)
                }
                if (params.estado) {
                    eq("estado", est)
                }
                if (params.busqueda) {
                    or {
                        ilike("cedula", "%" + params.busqueda + "%")
                        ilike("nombre", "%" + params.busqueda + "%")
                        ilike("apellido", "%" + params.busqueda + "%")
                    }
                }
                if (params.datos == "0") { //sin datos: no nombre ni apellido
                    isNull("nombre")
                    isNull("apellido")
                } else if (params.datos == "1") { //con datos: con nombre y apellido
                    isNotNull("nombre")
                    isNotNull("apellido")
                }
                order(params.sort, params.order)
            }
        }

        params.totalRows = results.size()

//        params.label = "Se encontr" + (params.totalRows == 1 ? "ó" : "aron") + " <b>${params.totalRows}</b> inscrito" + (params.totalRows == 1 ? "" : "s") + " a la convocatoria ${conv.descripcion}"
        params.label = "Inscritos a la convocatoria ${conv.descripcion}"
        if (params.provincia) {
            params.label += " en la provincia de ${prov.nombre}"
        } else {
            params.label += " en todas las provincias"
        }
        if (params.estado) {
            params.label += " con estado ${est.descripcion}"
        } else {
            params.label += " con cualquier estado"
        }
        if (params.datos == '1') {
            params.label += " que ya han ingresado sus datos"
        } else if (params.datos == "0") {
            params.label += " que aún no han ingresado sus datos"
        }
        if (params.busqueda) {
            params.label += " y cuyo nombre, apellido o cédula contenga ${params.busqueda}"
        }

        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile(params.filename, '.xls')
        file.deleteOnExit()
        //println "paso"
        WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat formatXls = new WritableCellFormat(font)

        WritableSheet sheet = workbook.createSheet('Reporte', 0)

        WritableFont tituloFont = new WritableFont(WritableFont.TIMES, 14, WritableFont.BOLD, true);
        WritableCellFormat tituloFormat = new WritableCellFormat(tituloFont);

        WritableFont titulo2Font = new WritableFont(WritableFont.TIMES, 13, WritableFont.BOLD, true);
        WritableCellFormat titulo2Format = new WritableCellFormat(titulo2Font);

        WritableFont times11font = new WritableFont(WritableFont.TIMES, 12, WritableFont.BOLD, true);
        WritableCellFormat times16format = new WritableCellFormat(times11font);

        WritableFont times11font2 = new WritableFont(WritableFont.TIMES, 10, WritableFont.NO_BOLD, true);
        WritableCellFormat times16format2 = new WritableCellFormat(times11font2);

        // inicia textos y numeros para asocias a columnas
        def label = new Label(0, 1, "Texto", times16format);
        def nmro = new Number(12, 1, 9999);
        def c1 = { prop ->
            return prop?.descripcion
        }
        def c2 = { prop ->
            return prop?.nombre
        }


        def datos = [
                [etiqueta: "CONVOCATORIA", accion: [closure: [c1, "?"]], campo: "convocatoria"],
                [etiqueta: "PROVINCIA", accion: [closure: [c2, "?"]], campo: "provincia"],
                [etiqueta: "CANTON", accion: [closure: [c2, "?"]], campo: "canton"],
                [etiqueta: "PARROQUIA", accion: [closure: [c2, "?"]], campo: "parroquia"],
                [etiqueta: "COMUNIDAD", accion: [], campo: "comunidad"],
                [etiqueta: "CEDULA", accion: [], campo: "cedula"],
                [etiqueta: "APELLIDOS", accion: [], campo: "apellidos"],
                [etiqueta: "NOMBRES", accion: [], campo: "nombres"],
                [etiqueta: "FECHA NACIMIENTO", accion: ["format": ["dd-MM-yyyy"]], campo: "fechaNacimiento"],
                [etiqueta: "TITULO", accion: [closure: [c1, "?"]], campo: "titulo"],
                [etiqueta: "ESTADO", accion: [closure: [c1, "?"]], campo: "estado"],
                [etiqueta: "GENERO", accion: [], campo: "sexo"],
                [etiqueta: "EMAIL", accion: [], campo: "email"],
                [etiqueta: "ETNIA", accion: [], campo: "etnia"],
                [etiqueta: "PROMOTOR CNH", accion: [], campo: "promotorCNH"],
                [etiqueta: "HABLA L. NATIVA", accion: [], campo: "lenguaNativa"],
                [etiqueta: "CERTIFICADO L. NATIVA", accion: [], campo: "certificadoNativo"],
                [etiqueta: "MAS DE 50% L. NATIVA", accion: [], campo: "habla50Nativa"],
                [etiqueta: "L. NATIVA", accion: [closure: [c1, "?"]], campo: "tipoIdiomaNativo"],
                [etiqueta: "HABLA L. EXTR.", accion: [], campo: "lenguaExtrangera"],
                [etiqueta: "CERTIFICADO L. EXTR.", accion: [], campo: "certificadoExtrangero"],
                [etiqueta: "MAS DE 50% L. EXTR.", accion: [], campo: "habla50Extrangero"],
                [etiqueta: "DIRECCION", accion: [], campo: "direccion"],
                [etiqueta: "TELEFONO FIJO", accion: [], campo: "telefonoFijo"],
                [etiqueta: "TELEFONO CEL.", accion: [], campo: "telefonoCelular"],
                [etiqueta: "EXPERIENCIA A.", accion: [], campo: "experienciaAnio"],
                [etiqueta: "EXPERIENCIA M.", accion: [], campo: "experienciaMes"],
                [etiqueta: "TRABAJO COM.", accion: [], campo: "trabajoComunitario"]
        ]

        label = new Label(0, 0, "Lista de personas", tituloFormat); sheet.addCell(label)
        label = new Label(0, 1, params.label, titulo2Format); sheet.addCell(label)

        def filaIni = 3
        datos.etiqueta.eachWithIndex {l, columna ->
            //headers
            sheet.setColumnView(columna, 25)
            label = new Label(columna, filaIni, l, times16format); sheet.addCell(label)
        }
//
//
        results.eachWithIndex {r, fila ->
            datos.eachWithIndex {d, columna ->
//                //println "d: " + d
                def val
                if (d["accion"].size() > 0) {
                    val = bsc.operacion(propiedad: d["campo"], funcion: d["accion"], registro: r)
                } else {
                    val = r.properties[d["campo"]]
                }
                if (!val) {
                    val = ""
                }
                label = new Label(columna, fila + filaIni + 1, val.toString(), times16format2); sheet.addCell(label)
//                //println "----------------------------"
            }
//            //println "******************************************************************************************"
        }

//        datos.eachWithIndex { h, i ->
//            sheet.setColumnView(i, 25)
//            label = new Label(i, 1, h, times16format); sheet.addCell(label)
//        }

        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + params.filename;
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

}
