<%@ page import="teleh.Persona" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Lista de Personas
        </title>
        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    </head>

    <body>

        <div class="span12">
            <g:if test="${flash.message}">
                <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
                    <a class="close" data-dismiss="alert" href="#">×</a>
                    ${flash.message}
                </div>
            </g:if>
        %{--</div>--}%

        %{--<div class="span8 btn-group" role="navigation">--}%

        %{--</div>--}%

        %{--<div id="search" class="pull-right"></div>--}%

            <g:form action="delete" name="frmDelete-Persona">
                <g:hiddenField name="id"/>
            </g:form>

            <div id="list-Persona" class="span12" role="main" style="margin-top: 10px;">

                <g:form class="well" name="frmSearch" params="${[max: params.max, sort: params.sort, order: params.order]}" action="list">
                    <div class="row">
                        <div class="span12">
                            Inscritos en
                            la convocatoria <g:select class="input-medium" name="convocatoria" from="${teleh.Convocatoria.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" value="${params.id}"/>
                            en <g:select class="input-medium" name="provincia" from="${teleh.Provincia.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre" value="${params.provincia}" noSelection="['': 'Todas las provincias']"/>
                            con estado <g:select class="input-medium" name="estado" from="${teleh.Estado.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" value="${params.estado}" noSelection="['': 'Cualquiera']"/>
                            <g:select class="input-small" name="datos" from="${['-1': 'Todos', '0': 'Sin datos', '1': 'Con datos']}" optionKey="key" optionValue="value" value="${params.datos}"/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="span12">
                            con nombre, apellido o cédula que contenga <input type='text' name="busqueda" class='span2 search-query' value="${params.busqueda}"/>
                            <a href="#" id="btnFiltrar" class="btn btn-info" style="margin-bottom: 9px;">
                                <i class=" icon-search"></i> Filtrar
                            </a>
                        </div>
                    </div>
                </g:form>

                <div class="row">
                    <div class="span9">
                        ${params.label}
                    </div>
                    %{--<g:form class='span31 form-search' name="frmBuscar" action="list" params="${[provincia: params.provincia]}" id="${params.id}">--}%
                    %{--<div class='input-append'>--}%
                    %{--<input type='text' name="busqueda" class='span2 search-query' value="${params.busqueda}"/>--}%
                    %{--<a href='#' class='btn' id="btnBuscar"><i class='icon-zoom-in'></i> Buscar</a>--}%
                    %{--<g:submitButton name="Buscar" class='btn'/>--}%
                    %{--</div>--}%
                    %{--</g:form>--}%
                </div>

                <div class="row">
                    <div class="span12" style="height: 30px;">
                        ${params.totales}
                    </div>
                </div>

                <div class="row">
                    <div class="span12" style="height: 30px; color: #1a2d57;">
                        ${params.calificados}
                    </div>
                </div>

                <div class="row">
                    <div class="span12 btn-group">
                        <a href="#" class="btn btn-export" rel="tooltip" title="Exportar esta búsqueda a Excel" id="xls">
                            <i class="icon-table"></i> Exportar a Excel
                        </a>
                        %{--<a href="#" class="btn btn-export" rel="tooltip" title="Exportar esta búsqueda a PDF" id="pdf">--}%
                        %{--<i class="icon-file"></i>--}%
                        %{--</a>--}%
                    </div>
                </div>

                <table class="table table-bordered table-striped table-condensed table-hover" id="tbl">
                    <thead>
                        <tr>
                            <g:sortableColumn action="list" property="provincia" title="Vive en" params="${params}"/>
                            <g:sortableColumn action="list" property="canton" title="Cantón" params="${params}"/>
                            <g:sortableColumn action="list" property="titulo" title="Formación" params="${params}"/>
                            <th>Cédula</th>
                            <g:sortableColumn action="list" property="apellido" title="Nombres" params="${params}"/>
                            <g:sortableColumn action="list" property="sexo" title="Género" params="${params}"/>
                            <g:sortableColumn action="list" property="estado" title="Estado" params="${params}"/>
                            <th width="150">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="paginate">
                        <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                            <tr>
                                <td>
                                    ${fieldValue(bean: personaInstance, field: "provincia")}
                                </td>
                                <td>
                                    ${fieldValue(bean: personaInstance, field: "canton")}
                                </td>
                                <td>
                                    ${personaInstance.titulo?.descripcion}
                                </td>
                                <td>
                                    <g:link action="verTitulo" rel="tooltip" title="Ver titulo" id="${personaInstance.id}">
                                        ${personaInstance.cedula}
                                    </g:link>
                                </td>
                                <td>
                                    <a class="show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${personaInstance.id}">
                                        ${personaInstance.apellido}, ${personaInstance.nombre}
                                    </a>
                                </td>
                                <td>
                                    ${personaInstance.sexo?.capitalize()}
                                </td>
                                <td>
                                    ${personaInstance?.estado?.descripcion}
                                </td>
                                <td>
                                    <a class="btn btn-small btn-show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${personaInstance.id}">
                                        <i class="icon-zoom-in icon-large"></i>
                                    </a>
                                    <g:link action="verTitulo" id="${personaInstance.id}" class="btn btn-small btn-titulo" rel="tooltip" title="Ver título" data-id="${personaInstance.id}">
                                        <i class=" icon-credit-card icon-large"></i>
                                    </g:link>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>

                <elm:paginate total="${params.totalRows}" action="list" id="${params.id}" params="${params}" maxsteps="9"/>
            </div>

            <div class="modal hide fade" id="modal-Persona">
                <div class="modal-header" id="modalHeader">
                    <button type="button" class="close darker" data-dismiss="modal">
                        <i class="icon-remove-circle"></i>
                    </button>

                    <h3 id="modalTitle"></h3>
                </div>

                <div class="modal-body" id="modalBody">
                </div>

                <div class="modal-footer" id="modalFooter">
                </div>
            </div>

            <script type="text/javascript">

                function submitForm(btn) {
                    if ($("#frmSave-Persona").valid()) {
                        btn.replaceWith(spinner);
                    }
                    $("#frmSave-Persona").submit();
                }

                $(function () {
                    $('[rel=tooltip]').tooltip();

                    $(".btn-show").click(function () {
                        var id = $(this).data("id");
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'show_ajax')}",
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                var btnOk = $('<a href="#" data-dismiss="modal" class="btn btn-primary">Aceptar</a>');
                                $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-show");
                                $("#modalTitle").html("Ver Persona");
                                $("#modalBody").html(msg);
                                $("#modalFooter").html("").append(btnOk);
                                $("#modal-Persona").modal("show");
                            }
                        });
                        return false;
                    }); //click btn show

                    $("#btnFiltrar").click(function () {
                        $(this).replaceWith(spinner);
//                        console.log($("#frmSearch").serialize());
                        $("#frmSearch").submit();
                    });

                    %{--$("#convocatoria").change(function () {--}%
                    %{--var conv = $(this).val();--}%
                    %{--location.href = "${createLink(action:'list')}/" + conv;--}%
                    %{--});--}%
                    %{--$("#provincia").change(function () {--}%
                    %{--var prov = $(this).val();--}%
                    %{--location.href = "${createLink(action:'list', id:params.id)}?provincia=" + prov;--}%
                    %{--});--}%
                    %{--$("#estado").change(function () {--}%
                    %{--var est = $(this).val();--}%
                    %{--location.href = "${createLink(action:'list', id:params.id)}?estado=" + est;--}%
                    %{--});--}%
                    %{--$("#datos").change(function () {--}%
                    %{--var dat = $(this).val();--}%
                    %{--location.href = "${createLink(action:'list', id:params.id)}?datos=" + dat;--}%
                    %{--});--}%

                    $(".show").click(function () {
                        var id = $(this).data("id");
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(controller: 'personaAdm', action:'show_ajax')}",
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                var btnOk = $('<a href="#" data-dismiss="modal" class="btn btn-primary">Aceptar</a>');
                                $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-show");
                                $("#modalTitle").html("Ver Persona");
                                $("#modalBody").html(msg);
                                $("#modalFooter").html("").append(btnOk);
                                $("#modal-Persona").modal("show");
                            }
                        });
                        return false;
                    }); //click btn show

                    $(".btn-export").click(function () {
                        var tipo = $(this).attr("id");

                        var sep, actionUrl, url, data = "";
                        switch (tipo) {
                            case "xls":
                                sep = "&";
                                actionUrl = "";
                                url = "${createLink(controller: "reportes", action: 'listaPersonasXls')}";
                                data = "filename=listaPersonas.xls" + sep;
                                break;
                            case "pdf":
                                sep = "W";
                                actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=listaPersonas.pdf&url=";
                                url = "${createLink(controller: "reportes", action: 'listaPersonasPdf')}";
                                break;
                        }

                        data += "id=${params.id}" + sep;
                        data += "provincia=${params.provincia}" + sep;
                        data += "estado=${params.estado}" + sep;
                        data += "sort=${params.sort}" + sep;
                        data += "order=${params.order}" + sep;
                        data += "datos=${params.datos}" + sep;
                        data += "busqueda=${params.busqueda}" + sep;

                        //                        console.log(actionUrl + url + "?" + data)

                        location.href = actionUrl + url + "?" + data;

                        %{--var sep = "W";--}%
                        %{--var url = "${createLink(controller: "reportes", action: 'listaPersonasPdf')}";--}%
                        %{--var actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=listaPersonas.pdf";--}%
                        %{--var data = "id=${params.id}" + sep;--}%
                        %{--data += "provincia=${params.provincia}" + sep;--}%
                        %{--data += "estado=${params.estado}" + sep;--}%
                        %{--data += "sort=${params.sort}" + sep;--}%
                        %{--data += "order=${params.order}" + sep;--}%
                        %{--data += "datos=${params.datos}" + sep;--}%
                        %{--data += "busqueda=${params.busqueda}" + sep;--}%
                        %{--//                        location.href = url + "?" + data;--}%
                        %{--location.href = actionUrl + "&url=" + url + "?" + data;--}%

                    });

                });

            </script>

    </body>
</html>
