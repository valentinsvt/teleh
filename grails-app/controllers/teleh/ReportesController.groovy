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

    def index() { }

    def buscadorService
    def reporteBuscador = {

        // println "reporte buscador params !! "+params
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
//            println "name "+name
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

        def conv, prov, est

        conv = Convocatoria.get(params.id.toLong())
        if (params.provincia) {
            prov = Provincia.get(params.provincia.toLong())
        }
        if (params.estado) {
            est = Estado.get(params.estado.toLong())
        }

//        println params
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

        def conv, prov, est

        conv = Convocatoria.get(params.id.toLong())
        if (params.provincia) {
            prov = Provincia.get(params.provincia.toLong())
        }
        if (params.estado) {
            est = Estado.get(params.estado.toLong())
        }

//        println params
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
        println "paso"
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
//                println "d: " + d
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
//                println "----------------------------"
            }
//            println "******************************************************************************************"
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
