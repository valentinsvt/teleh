package teleh

class TituloTagLib {

    static namespace = "ttl"

    def render(id) {
        def tituloPersona = TituloPersona.findByPersona(Persona.get(id))

        if (!tituloPersona || !tituloPersona.tituloArchivo || !tituloPersona.tipoArchivo) {
            response.sendError(404)
            return;
        }
//        response.setContentType(tituloPersona.tipoArchivo)
//        response.setContentLength(tituloPersona.tituloArchivo.size())
//        OutputStream out = response.getOutputStream();
//        out.write(tituloPersona.tituloArchivo);
//        out.close();

        response.setContentType(tituloPersona.tipoArchivo)
        response.outputStream << (tituloPersona.tituloArchivo)
    }

    def ver = { attrs ->
        def id = attrs.remove("id")
        def persona = Persona.get(id)
        def titulo = TituloPersona.findByPersona(persona)
        if (titulo.tipoArchivo == 'application/pdf') {
            out << "<a href='" + createLink(controller: 'persona', action: 'verTitulo', id: id) + "'>Descargar archivo PDF</a>"
        } else {
            def img = '<img src="' + createLink(controller: 'persona', action: 'verTitulo', id: id) + '" '
            img += renderAttributes(attrs)
            img += "/>"

            out << img
        }
    }

    /********************************************************* funciones ******************************************************/

    /**
     * renders attributes in HTML compliant fashion returning them in a string
     */
    String renderAttributes(attrs) {
        def ret = ""
        attrs.remove('tagName') // Just in case one is left
        attrs.each { k, v ->
            ret += k
            ret += '="'
            if (v) {
                ret += v.encodeAsHTML()
            } else {
                ret += ""
            }
            ret += '" '
        }
        return ret
    }
}
