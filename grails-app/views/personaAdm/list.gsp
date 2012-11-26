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

                Inscritos
                en la convocatoria <g:select name="convocatoria" from="${teleh.Convocatoria.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" value="${params.id}"/>
                en <g:select name="provincia" from="${teleh.Provincia.list([sort: 'nombre'])}" optionKey="id" optionValue="nombre" value="${params.provincia}" noSelection="['': 'Todas las provincias']"/>
                con estado <g:select name="estado" from="${teleh.Estado.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" value="${params.estado}" noSelection="['': 'Todos los estados']"/>

                <div style="height: 30px;">
                    <g:if test="${params.totalRows != 0}">
                        <div class="pull-left" style="line-height: 30px;">
                            Total de registros: ${params.totalRows}
                        </div>
                    </g:if>
                    <g:form class='form-search pull-right' name="frmBuscar" action="list" params="${[provincia: params.provincia]}" id="${params.id}">
                        <div class='input-append'>
                            <input type='text' name="busqueda" class='span2 search-query' value="${params.busqueda}"/>
                            %{--<a href='#' class='btn' id="btnBuscar"><i class='icon-zoom-in'></i> Buscar</a>--}%
                            <g:submitButton name="Buscar" class='btn'/>
                        </div>
                    </g:form>
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

                    $("#convocatoria").change(function () {
                        var conv = $(this).val();
                        location.href = "${createLink(action:'list')}/" + conv;
                    });
                    $("#provincia").change(function () {
                        var prov = $(this).val();
                        location.href = "${createLink(action:'list', id:params.id)}?provincia=" + prov;
                    });
                    $("#estado").change(function () {
                        var est = $(this).val();
                        location.href = "${createLink(action:'list', id:params.id)}?estado=" + est;
                    });

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

                });

            </script>

    </body>
</html>
