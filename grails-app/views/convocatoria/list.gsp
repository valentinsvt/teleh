<%@ page import="teleh.Convocatoria" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Lista de Convocatorias
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
        </div>

        <div class="span8 btn-group" role="navigation">
            <a href="#" class="btn btn-ajax btn-new">
                <i class="icon-file"></i>
                Crear  Convocatoria
            </a>
        </div>

        <div id="search" class="pull-right"></div>

        <g:form action="delete" name="frmDelete-Convocatoria">
            <g:hiddenField name="id"/>
        </g:form>

        <div id="list-Convocatoria" class="span12" role="main" style="margin-top: 10px;">

            <table class="table table-bordered table-striped table-condensed table-hover">
                <thead>
                    <tr>
                        <g:sortableColumn property="descripcion" title="Descripcion"/>
                        <g:sortableColumn property="fechaInicio" title="Fecha Inicio"/>
                        <g:sortableColumn property="fechaRegistro" title="Fecha max. Registro"/>
                        <g:sortableColumn property="fechaRegistro" title="Fecha evaluación"/>
                        <g:sortableColumn property="fechaFin" title="Fecha Fin"/>
                        <th width="150">Acciones</th>
                    </tr>
                </thead>
                <tbody class="paginate">
                    <g:each in="${convocatoriaInstanceList}" status="i" var="convocatoriaInstance">
                        <tr>

                            <td>${fieldValue(bean: convocatoriaInstance, field: "descripcion")}</td>
                            <td>${convocatoriaInstance.fechaInicio?.format('dd-MM-yyyy')}</td>
                            <td>${convocatoriaInstance.fechaRegistro?.format('dd-MM-yyyy')}</td>
                            <td>${convocatoriaInstance.fechaEvaluacion?.format('dd-MM-yyyy')}</td>
                            <td>${convocatoriaInstance.fechaFin?.format('dd-MM-yyyy')}</td>
                            <td>
                                <a class="btn btn-small btn-show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${convocatoriaInstance.id}">
                                    <i class="icon-zoom-in icon-large"></i>
                                </a>
                                <a class="btn btn-small btn-edit btn-ajax" href="#" rel="tooltip" title="Editar" data-id="${convocatoriaInstance.id}">
                                    <i class="icon-pencil icon-large"></i>
                                </a>

                                <a class="btn btn-small btn-delete" href="#" rel="tooltip" title="Eliminar" data-id="${convocatoriaInstance.id}">
                                    <i class="icon-trash icon-large"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>

        </div>

        <div class="modal hide fade" id="modal-Convocatoria">
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
                if ($("#frmSave-Convocatoria").valid()) {
                    btn.replaceWith(spinner);
                }
                $("#frmSave-Convocatoria").submit();
            }

            $(function () {
                $('[rel=tooltip]').tooltip();

                $(".paginate").paginate({
                    maxRows        : 10,
                    searchPosition : $("#search")
                });

                $(".btn-new").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'form_ajax')}",
                        success : function (msg) {
                            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                            var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-save"></i> Guardar</a>');

                            btnSave.click(function () {
                                submitForm(btnSave);
                                return false;
                            });

                            $("#modalHeader").removeClass("btn-edit btn-show btn-delete");
                            $("#modalTitle").html("Crear Convocatoria");
                            $("#modalBody").html(msg);
                            $("#modalFooter").html("").append(btnOk).append(btnSave);
                            $("#modal-Convocatoria").modal("show");
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
                            $("#modalTitle").html("Editar Convocatoria");
                            $("#modalBody").html(msg);
                            $("#modalFooter").html("").append(btnOk).append(btnSave);
                            $("#modal-Convocatoria").modal("show");
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
                            $("#modalTitle").html("Ver Convocatoria");
                            $("#modalBody").html(msg);
                            $("#modalFooter").html("").append(btnOk);
                            $("#modal-Convocatoria").modal("show");
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
                        $("#frmDelete-Convocatoria").submit();
                        return false;
                    });

                    $("#modalHeader").removeClass("btn-edit btn-show btn-delete").addClass("btn-delete");
                    $("#modalTitle").html("Eliminar Convocatoria");
                    $("#modalBody").html("<p>¿Está seguro de querer eliminar esta Convocatoria?</p>");
                    $("#modalFooter").html("").append(btnOk).append(btnDelete);
                    $("#modal-Convocatoria").modal("show");
                    return false;
                });

            });

        </script>

    </body>
</html>
