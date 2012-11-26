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

                Inscritos en la convocatoria <g:select name="convocatoria" from="${teleh.Convocatoria.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" value="${params.convocatoria}"/>
                <div id="divTabla">
                    <div style="height: 30px;">
                        <div id="search" class="pull-right"></div>
                    </div>
                    <table class="table table-bordered table-striped table-condensed table-hover" id="tbl">
                        <thead>
                            <tr>
                                <th>Vive en</th>
                                <th>Canton</th>
                                <th>Formación</th>
                                <th>Cédula</th>
                                <th>Nombres</th>
                                <th>Género</th>
                                <th>Estado</th>
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

                    <script type="text/javascript">
                        $(".paginate").paginate({
                            maxRows        : 100,
                            searchPosition : $("#search"),
                            searchButton   : "Buscar"
                        });
                    </script>

                </div>

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
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'cambiaConvocatoria')}",
                            data    : {
                                id : conv
                            },
                            success : function (msg) {
                                $("#divTabla").html(msg);
                            }
                        });
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
