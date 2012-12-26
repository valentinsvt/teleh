<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/21/12
  Time: 3:55 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Lista de Personas
        </title>
    </head>

    <body>

        <div id="list-Persona" class="span12" role="main" style="margin-top: 10px;">

            <g:form class="well" name="frmSearch" params="${[max: params.max, sort: params.sort, order: params.order]}" action="list">
                <div class="row">
                    <div class="span12">
                        Inscritos en
                        la convocatoria <g:select class="input-medium" name="convocatoria" from="${teleh.Convocatoria.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" value="${params.id}"/>
                        en <g:select class="input-medium" name="provincia" from="${teleh.Provincia.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre" value="${params.provincia}" noSelection="['': 'Todas las provincias']"/>

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

            <table class="table table-bordered table-striped table-condensed table-hover" id="tbl">
                <thead>
                    <tr>
                        <g:sortableColumn action="list" property="provincia" title="Provincia" params="${params}"/>
                        <g:sortableColumn action="list" property="canton" title="Cantón" params="${params}"/>
                        <g:sortableColumn action="list" property="titulo" title="Formación" params="${params}"/>
                        <th>Cédula</th>
                        <g:sortableColumn action="list" property="apellido" title="Nombres" params="${params}"/>
                        <g:sortableColumn action="list" property="sexo" title="Género" params="${params}"/>
                        <th>Nota</th>
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
                                ${personaInstance.cedula}
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
                                ${teleh.Encuesta.findByPersona(personaInstance)}
                            </td>
                            <td>
                                <a class="btn btn-small btn-show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${personaInstance.id}">
                                    <i class="icon-zoom-in icon-large"></i>
                                </a>
                                <g:link action="entrevista" id="${personaInstance.id}" class="btn btn-small btn-titulo" rel="tooltip" title="Entrevista" data-id="${personaInstance.id}">
                                    <i class=" icon-comments icon-large"></i>
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
            $(function () {
                $('[rel=tooltip]').tooltip();

                $(".btn-show, .show").click(function () {
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
            });
        </script>

    </body>
</html>