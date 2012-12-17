<%@ page import="teleh.Pregunta" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Lista de Preguntas
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

        <g:if test="${examen}">

            <div class="tituloTree">Preguntas de <i>${examen.descripcion}</i></div>

            <div class="span8 btn-group" role="navigation">
                <g:link controller="examen" action="list" class="btn">
                    <i class="icon-arrow-left"></i>
                    Regresar a Exámenes
                </g:link>
                <a href="#" class="btn btn-ajax btn-new">
                    <i class="icon-file"></i>
                    Crear  Pregunta
                </a>
            </div>

            <div id="search" class="pull-right"></div>

            <g:form action="delete" name="frmDelete-Pregunta">
                <g:hiddenField name="id"/>
            </g:form>

            <div id="list-Pregunta" class="span12" role="main" style="margin-top: 10px;">

                <table class="table table-bordered table-striped table-condensed table-hover">
                    <thead>
                        <tr>
                            <g:sortableColumn property="orden" title="Orden"/>
                            <g:sortableColumn property="pregunta" title="Pregunta"/>
                            <th>Respuestas</th>
                            <th width="150">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="paginate">
                        <g:each in="${preguntaInstanceList}" status="i" var="preguntaInstance">
                            <tr>
                                <td style="width: 55px; text-align: center; vertical-align: middle;">${preguntaInstance.orden}</td>
                                <td>${fieldValue(bean: preguntaInstance, field: "pregunta")}</td>
                                <td style="width: 75px; text-align: center; vertical-align: middle;" class="resps">
                                    ${preguntaInstance.respuestas.size()}
                                </td>
                                <td>
                                    <a class="btn btn-small btn-show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${preguntaInstance.id}">
                                        <i class="icon-zoom-in icon-large"></i>
                                    </a>
                                    <a class="btn btn-small btn-edit btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${preguntaInstance.id}">
                                        <i class="icon-pencil icon-large"></i>
                                    </a>

                                    <a class="btn btn-small btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${preguntaInstance.id}">
                                        <i class="icon-trash icon-large"></i>
                                    </a>
                                    <a data-id="${preguntaInstance.id}" class="btn btn-small btn-respuestas" href="#" rel="tooltip" title="Definir respuestas">
                                        <i class="icon-comments-alt icon-large"></i>
                                    </a>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>

            </div>

            <div class="modal longModal hide fade" id="modal-Pregunta">
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
                    if ($("#frmSave-Pregunta").valid()) {
                        btn.replaceWith(spinner);
                    }
                    $("#frmSave-Pregunta").submit();
                }

                $(function () {
                    $('[rel=tooltip]').tooltip();

                    $(".paginate").paginate({
                        maxRows        : 20,
                        searchPosition : $("#search")
                    });

                    $(".btn-new").click(function () {
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'form_ajax')}",
                            data    : {
                                examen : "${examen.id}"
                            },
                            success : function (msg) {
                                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                                btnSave.click(function () {
                                    submitForm(btnSave);
                                    return false;
                                });

                                $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                                $("#modalTitle").html("Crear Pregunta");
                                $("#modalBody").html(msg);
                                $("#modalFooter").html("").append(btnOk).append(btnSave);
                                $("#modal-Pregunta").modal("show");
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
                                id     : id,
                                examen : "${examen.id}"
                            },
                            success : function (msg) {
                                var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                                var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                                btnSave.click(function () {
                                    submitForm(btnSave);
                                    return false;
                                });

                                $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-edit");
                                $("#modalTitle").html("Editar Pregunta");
                                $("#modalBody").html(msg);
                                $("#modalFooter").html("").append(btnOk).append(btnSave);
                                $("#modal-Pregunta").modal("show");
                            }
                        });
                        return false;
                    }); //click btn edit

                    $(".btn-respuestas").click(function () {
                        var btn = $(this);
                        var id = btn.data("id");
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'respuestas_ajax')}",
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                var btnOk = $('<a href="#" class="btn btn-success"><i class="icon-save"></i> Guardar</a>');
                                btnOk.click(function () {
                                    var ok = $(".correcta").size();
                                    if (ok > 0) {
                                        var cant = $("#tbResp").children("tr").size();
                                        if (cant >= 3) {
                                            btn.parents("td").siblings(".resps").text(cant);
                                            $("#modal-Pregunta").modal("hide");
                                        } else {
                                            error("Debe haber al menos 3 respuestas por pregunta...");
                                        }
                                    } else {
                                        error("Debe haber una respuesta correcta por pregunta...");
                                    }
                                    return false;
                                });

                                $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                                $("#modalTitle").html("Respuestas");
                                $("#modalBody").html(msg);
                                $("#modalFooter").html("").append(btnOk);//.append(btnSave);
                                $("#modal-Pregunta").modal("show");
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
                                $("#modalTitle").html("Ver Pregunta");
                                $("#modalBody").html(msg);
                                $("#modalFooter").html("").append(btnOk);
                                $("#modal-Pregunta").modal("show");
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
                            $("#frmDelete-Pregunta").submit();
                            return false;
                        });

                        $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-delete");
                        $("#modalTitle").html("Eliminar Pregunta");
                        $("#modalBody").html("<p>¿Está seguro de querer eliminar esta Pregunta?</p>");
                        $("#modalFooter").html("").append(btnOk).append(btnDelete);
                        $("#modal-Pregunta").modal("show");
                        return false;
                    });

                });

            </script>
        </g:if>

    </body>
</html>
