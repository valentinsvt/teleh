<%@ page import="teleh.PreguntaEntrevista" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Lista de Pregunta Entrevistas
        </title>
        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
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

        <div class="row">
            <div class="span">
                Convocatoria
                <g:select class="input-xxlarge" name="convocatoria" from="${teleh.Convocatoria.list([sort: 'descripcion'])}" optionKey="id" optionValue="descripcion" value="${params.id}"/>
            </div>
        </div>

        <div class="span8 btn-group" role="navigation">
            <a href="#" class="btn btn-ajax btn-new">
                <i class="icon-file"></i>
                Crear  Pregunta Entrevista
            </a>
            %{--<g:if test="${preguntaEntrevistaInstanceList.size() == 0}">--}%
                <a href="#" class="btn btn-ajax btn-copy">
                    <i class="icon-copy"></i>
                    Copiar entrevista
                </a>
            %{--</g:if>--}%
        </div>


        <div id="search" class="pull-right"></div>

        <g:form action="delete" name="frmDelete-PreguntaEntrevista">
            <g:hiddenField name="id"/>
        </g:form>

        <div id="list-PreguntaEntrevista" class="span12" role="main" style="margin-top: 10px;">
            <g:set var="alfabeto" value="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
            <table class="table table-bordered table-striped table-condensed table-hover">
                <thead>
                    <tr>

                        <g:sortableColumn property="tipo" title="Tipo"/>

                        <g:sortableColumn property="orden" title="Orden"/>

                        <g:sortableColumn property="numero" title="Numero"/>

                        <g:sortableColumn property="pregunta" title="Pregunta"/>

                        <g:sortableColumn property="valoracion" title="Valoracion"/>

                        <g:sortableColumn property="positivo" title="Positivo"/>

                        <g:sortableColumn property="negativo" title="Negativo"/>

                        <th width="150">Acciones</th>
                    </tr>
                </thead>
                <tbody class="paginate">
                    <g:each in="${preguntaEntrevistaInstanceList}" status="i" var="preguntaEntrevistaInstance">
                        <tr>

                            <td>${fieldValue(bean: preguntaEntrevistaInstance, field: "tipo")}</td>

                            <td>${fieldValue(bean: preguntaEntrevistaInstance, field: "orden")}</td>

                            <td>
                                ${preguntaEntrevistaInstance.tipo == 'Verificacion' ? preguntaEntrevistaInstance.numero + " (" + alfabeto[preguntaEntrevistaInstance.numero - 1] + ")" : preguntaEntrevistaInstance.numero}
                            </td>

                            <td>${fieldValue(bean: preguntaEntrevistaInstance, field: "pregunta")}</td>

                            <td>${fieldValue(bean: preguntaEntrevistaInstance, field: "valoracion")}</td>

                            <td>${fieldValue(bean: preguntaEntrevistaInstance, field: "positivo")}</td>

                            <td>${fieldValue(bean: preguntaEntrevistaInstance, field: "negativo")}</td>

                            <td>
                                <a class="btn btn-small btn-show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${preguntaEntrevistaInstance.id}">
                                    <i class="icon-zoom-in icon-large"></i>
                                </a>
                                <a class="btn btn-small btn-edit btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${preguntaEntrevistaInstance.id}">
                                    <i class="icon-pencil icon-large"></i>
                                </a>

                                <a class="btn btn-small btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${preguntaEntrevistaInstance.id}">
                                    <i class="icon-trash icon-large"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>

        </div>

        <div class="modal hide fade" id="modal-PreguntaEntrevista">
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
                if ($("#frmSave-PreguntaEntrevista").valid()) {
                    btn.replaceWith(spinner);
                }
                $("#frmSave-PreguntaEntrevista").submit();
            }

            $(function () {
                $('[rel=tooltip]').tooltip();

                $("#convocatoria").change(function () {
                    var id = $(this).val();
                    location.href = "${createLink(action: 'list')}/" + id;
                });

                $(".paginate").paginate({
                    maxRows        : 10,
                    searchPosition : $("#search")
                });

                $(".btn-copy").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'copy_ajax')}",
                        data    : {
                            conv : "${params.id}"
                        },
                        success : function (msg) {
                            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                            var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Aceptar</a>');

                            btnSave.click(function () {
                                submitForm(btnSave);
                                return false;
                            });

                            $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                            $("#modalTitle").html("Copiar Entrevista");
                            $("#modalBody").html(msg);
                            $("#modalFooter").html("").append(btnOk).append(btnSave);
                            $("#modal-PreguntaEntrevista").modal("show");
                        }
                    });
                    return false;
                }); //click btn new

                $(".btn-new").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'form_ajax')}",
                        data    : {
                            conv : "${params.id}"
                        },
                        success : function (msg) {
                            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                            var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                            btnSave.click(function () {
                                submitForm(btnSave);
                                return false;
                            });

                            $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                            $("#modalTitle").html("Crear Pregunta Entrevista");
                            $("#modalBody").html(msg);
                            $("#modalFooter").html("").append(btnOk).append(btnSave);
                            $("#modal-PreguntaEntrevista").modal("show");
                        }
                    });
                    return false;
                }); //click btn new

                $(".btn-edit").click(function () {
                    var id = $(this).data("id");
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'form_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                            var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                            btnSave.click(function () {
                                submitForm(btnSave);
                                return false;
                            });

                            $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-edit");
                            $("#modalTitle").html("Editar Pregunta Entrevista");
                            $("#modalBody").html(msg);
                            $("#modalFooter").html("").append(btnOk).append(btnSave);
                            $("#modal-PreguntaEntrevista").modal("show");
                        }
                    });
                    return false;
                }); //click btn edit

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
                            $("#modalTitle").html("Ver Pregunta Entrevista");
                            $("#modalBody").html(msg);
                            $("#modalFooter").html("").append(btnOk);
                            $("#modal-PreguntaEntrevista").modal("show");
                        }
                    });
                    return false;
                }); //click btn show

                $(".btn-delete").click(function () {
                    var id = $(this).data("id");
                    $("#id").val(id);
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnDelete = $('<a href="#" class="btn btn-danger"><i class="icon-trash"></i> Eliminar</a>');

                    btnDelete.click(function () {
                        btnDelete.replaceWith(spinner);
                        $("#frmDelete-PreguntaEntrevista").submit();
                        return false;
                    });

                    $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-delete");
                    $("#modalTitle").html("Eliminar Pregunta Entrevista");
                    $("#modalBody").html("<p>¿Está seguro de querer eliminar esta Pregunta Entrevista?</p>");
                    $("#modalFooter").html("").append(btnOk).append(btnDelete);
                    $("#modal-PreguntaEntrevista").modal("show");
                    return false;
                });

            });

        </script>

    </body>
</html>
