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
            Lista de Personas para entrevistas
        </title>
    </head>

    <body>
        <g:if test="${flash.message}">
            <div class="span12">
                <div class="alert ${flash.clase ?: 'alert-info'}" role="status">
                    <a class="close" data-dismiss="alert" href="#">×</a>
                    ${flash.message}
                </div>
            </div>
        </g:if>

        <g:if test="${session.usuario.tipo.toString().equalsIgnoreCase('a')}">
            <div class="span8 btn-group" role="navigation">
                <g:link class="btn" controller="preguntaEntrevista" action="list">
                    <i class="icon-pencil"></i>
                    Editar Entrevistas
                </g:link>
            </div>
        </g:if>

        <div id="list-Persona" class="span12" role="main" style="margin-top: 10px;">

            <g:form class="well" name="frmSearch" params="${[max: 100, sort: params.sort, order: params.order]}" action="list">
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

            <table class="table table-bordered table-striped table-condensed table-hover" id="tbl">
                <thead>
                    <tr>
                        <g:sortableColumn action="list" property="5" title="Provincia" params="${params}"/>
                        <g:sortableColumn action="list" property="6" title="Cantón" params="${params}"/>
                        <g:sortableColumn action="list" property="7" title="Formación" params="${params}"/>
                        <th>Cédula</th>
                        <g:sortableColumn action="list" property="4" title="Nombres" params="${params}"/>
                        <g:sortableColumn action="list" property="8" title="Género" params="${params}"/>
                        <th>Nota Prueba</th>
                        <th>Nota Entrevista</th>
                        <th width="150">Acciones</th>
                    </tr>
                </thead>
                <tbody class="paginate">
                    <g:each in="${res}" status="i" var="r">
                        <tr>
                            <td>
                                ${r[4]}
                            </td>
                            <td>
                                ${r[5]}
                            </td>
                            <td>
                                ${r[6]}
                            </td>
                            <td>
                                ${r[8]}
                            </td>
                            <td>
                                <a class="show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${r[0]}">
                                    ${r[3]}, ${r[2]}
                                </a>
                            </td>
                            <td>
                                ${r[6]}
                            </td>
                            <td>
                                ${r[9]}
                            </td>
                            <td>
                                ${r[10]}
                            </td>
                            <td>
                                <a class="btn btn-small btn-show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${r[0]}">
                                    <i class="icon-zoom-in icon-large"></i>
                                </a>
                                <g:link action="entrevista" id="${r[0]}" class="btn btn-small btn-titulo" rel="tooltip" title="Entrevista" data-id="${r[0]}">
                                    <i class=" icon-comments icon-large"></i>
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>

            <elm:paginate total="${total}" action="list" id="${params.id}" params="${params}" maxsteps="9"/>

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

                $("#btnFiltrar").click(function () {
                    $(".well").submit()
                });
            });
        </script>

    </body>
</html>