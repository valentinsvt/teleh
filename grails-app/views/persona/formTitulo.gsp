<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 11/19/12
  Time: 4:21 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="teleh.Persona" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Datos del postulante
        </title>
        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

        <style type="text/css">
        .red {
            color : #be1400;
        }
        </style>
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

        <g:if test="${completo}">
            <div class="span12">
                <div class="alert alert-info" role="status">
                    <a class="close" data-dismiss="alert" href="#">×</a>
                    Usted ha terminado el proceso de inscripción. Puede ingresar a su registro para actualizar, revisar  y completar su información hasta el 9 de diciembre.
                </div>
            </div>
        </g:if>

        <div class="span12 btn-group" role="navigation">
            <g:link class="btn" action="datos">
                <i class="icon-user"></i> Datos
            </g:link>
            <a href="#" class="btn btn-success btn-save"><i class="icon-save"></i> Guardar</a>
        </div>

        <div id="list-Persona" class="span12" role="main" style="margin-top: 10px;">
            <g:uploadForm class="form-horizontal" name="frmSave-Persona" action="uploadArchivo">
                <g:hiddenField name="persona.id" value="${personaInstance?.id}"/>
                POR FAVOR SUBIR AL MIES EL DOCUMENTO ESCANEADO DE SU TITULO<br/>
                Sólo se admiten archivos en formato <span class="red">png, jpg, gif, pdf</span> con un tamaño no mayor a 500 Kb (½ mega)
                <div class="control-group">
                    <div>
                        <span class="control-label label label-inverse">
                            Título
                        </span>
                    </div>

                    <div class="controls">
                        <input type="file" name="tituloArchivo" class="required"/>
                        %{--<span class="mandatory">*</span>--}%

                        %{--<p class="help-block ui-helper-hidden"></p>--}%
                    </div>
                </div>
            </g:uploadForm>
            <g:if test="${teleh.TituloPersona.findAllByPersona(personaInstance).size() > 0}">
                <div class="noMargin well">
                    <div class="tituloTree">
                        Título actualmente cargado
                    </div>

                    <p>
                        Cargue otro archivo para reemplazar este
                    </p>
                    <ttl:ver class="titulo" id="${personaInstance.id}"/>
                </div>
            </g:if>
        </div>
        <script type="text/javascript">

            function submitForm(btn) {
//                if ($("#frmSave-Persona").valid()) {
                btn.replaceWith(spinner);
//                }
                $("#frmSave-Persona").submit();
            }
            $(function () {
                $(".btn-save").click(function () {
                    submitForm($(this));
                });
            });

            //            $("#frmSave-Persona").validate({
            //                errorPlacement : function (error, element) {
            //                    element.parent().find(".help-block").html(error).show();
            //                },
            //                success        : function (label) {
            //                    label.parent().hide();
            //                },
            //                errorClass     : "label label-important",
            //                submitHandler  : function (form) {
            //                    $(".btn-success").replaceWith(spinner);
            //                    form.submit();
            //                }
            //            });
            //
            //            $("input").keyup(function (ev) {
            //                if (ev.keyCode == 13) {
            //                    submitForm($(".btn-success"));
            //                }
            //            });
        </script>

    </body>
</html>