package teleh

class MenuTagLib {
    static namespace = "mn"


    def renderItem(item, tipo) {
//        println session.cn + "\t" + item.controller
//        println session.an + "\t" + item.action
        def str = "", clase = ""
        if (session.cn == item.controller && session.an == item.action) {
            clase = "active"
        }
        if (item.items) {
            clase += " dropdown"
        }
        str += "<li class='" + clase + "'>"
        if (item.items) {
            str += "<a href='" + item.url + "' class='dropdown-toggle' data-toggle='dropdown'>" + item.label + "<b class=\"caret\"></b></a>"
            str += '<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">'
            item.items.each { t, i ->
                str += renderItem(i, t)
            }
            str += "</ul>"
        } else {
            str += "<a href='" + createLink(controller: item.controller, action: item.action) + "'>" + item.label + "</a>"
        }
        str += "</li>"

        return str
    }

    def menu = { attrs ->

        def items = [:]

        def usu = Auxiliar.get(session.usuario.id)

        switch (session.perfil) {
            case "admin":
//                items.administracion = [:]
//                items.administracion.label = "Administración"
//                items.administracion.items = [:]
//                items.administracion.items.usuarios = [:]
//                items.administracion.items.usuarios.label = "Usuarios"
//                items.administracion.items.usuarios.controller = "usro"
//                items.administracion.items.usuarios.action = "index"
//                items.administracion.items.parametros = [:]
//                items.administracion.items.parametros.label = "Parámetros"
//                items.administracion.items.parametros.controller = "parametros"
//                items.administracion.items.parametros.action = "index"
//                items.administracion.items.reportes = [:]
//                items.administracion.items.reportes.label = "Reportes"
//                items.administracion.items.reportes.controller = "reportes"
//                items.administracion.items.reportes.action = "index"

                if (usu.tipo.equalsIgnoreCase("a")) {
                    items.convocatoria = [:]
                    items.convocatoria.controller = "convocatoria"
                    items.convocatoria.action = "list"
                    items.convocatoria.label = "Convocatoria"
                }

                if (usu.tipo.equalsIgnoreCase("a") || usu.tipo.equalsIgnoreCase("c")) {
                    items.postulantes = [:]
                    items.postulantes.controller = "personaAdm"
                    items.postulantes.action = "list"
                    items.postulantes.label = "Postulantes"
                }

                if (usu.tipo.equalsIgnoreCase("a") || usu.tipo.equalsIgnoreCase("c") || usu.tipo.equalsIgnoreCase("e")) {
                    items.entrevista = [:]
                    items.entrevista.controller = "entrevista"
                    items.entrevista.action = "list"
                    items.entrevista.label = "Entrevistas"
                }

                if (usu.tipo.equalsIgnoreCase("a")) {
                    items.tipoTitulo = [:]
                    items.tipoTitulo.controller = "tipoTitulo"
                    items.tipoTitulo.action = "list"
                    items.tipoTitulo.label = "Tipo de título"

                    items.titulo = [:]
                    items.titulo.controller = "titulo"
                    items.titulo.action = "list"
                    items.titulo.label = "Títulos"

                    items.auxiliar = [:]
                    items.auxiliar.controller = "auxiliar"
                    items.auxiliar.action = "list"
                    items.auxiliar.label = "Usuarios"

                    items.examen = [:]
                    items.examen.label = "Exámenes"
                    items.examen.controller = "examen"
                    items.examen.action = "list"
                }
                break;
        }

        def strItems = ""
        items.each { tipo, item ->
            strItems += renderItem(item, tipo)
        }

        def html = ""
        html += '<div class="navbar navbar-static-top navbar-inverse">'
        html += '<div class="navbar-inner">'
        html += '<div class="container">'
        html += '<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</a>'
        html += '<a class="brand titulo" href="#">'
        html += attrs.title
        html += '</a>'

        html += '<div class="nav-collapse">'
        html += '<ul class="nav">'
        html += strItems
        html += ' <li class="divider-vertical"></li>'
        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="icon-off icon-white"></i> Salir</a></li>'
//        html += '<li><a href="#contact">Contact</a></li>'
        html += '</ul>'
        html += '<p class="navbar-text pull-right" id="countdown"></p>'
        html += '</div><!--/.nav-collapse -->'
        html += '</div>'
        html += '</div>'
        html += '</div>'

        out << html
    } //menu
}
