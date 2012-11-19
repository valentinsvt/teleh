<%@ page contentType="text/html;charset=UTF-8" %>

<html>

<head>
    <meta name="layout" content="login">
    <title> Registro </title>

    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
    <link href='${resource(dir: "css", file: "custom.css")}' rel='stylesheet' type='text/css'>
    <link href='${resource(dir: "font/open", file: "stylesheet.css")}' rel='stylesheet' type='text/css'>
    <link href='${resource(dir: "font/tulpen", file: "stylesheet.css")}' rel='stylesheet' type='text/css'>


</head>

<body>
<div style="border: 1px solid #525E67;background: #E0E0E0;color: #939Aa2;width: 340px;position: relative;padding: 10px;min-height: 320px;margin: 0px;" class="ui-corner-all">
    <g:if test="${session.convocatoria}">
        <g:form class="well form-horizontal" id="frmLogin" action="registrar" name="frmLogin" style="background: none;border: 0px solid #E0E0E0 !important;padding-left: 0px;margin-left: 20px;box-shadow: none" >
            <p class=" tituloGrande" style="float:left;font-family: 'Open Sans Condensed',serif;font-weight: bold;font-size: 25px;width: 95%">Sistema de evaluación</p>

        %{--<div class="linea" style="height: 95%;left: 45px"></div>--}%
            <fieldset style="background: none;margin: 0px;border: 0px solid #E0E0E0 !important;color: #333;margin-top: 50px">

                <g:if test="${msn}">
                    <div class="alert alert-info" role="status">
                        <a class="close" data-dismiss="alert" href="#">×</a>
                        ${msn}
                    </div>
                </g:if>

                <div class="control-group" style="margin-top: 0">
                    <label class="control-label" for="login" style="width: 100%;text-align: left;font-size: 20px;font-family: 'Open Sans Condensed', serif;font-weight: bolder">Cédula:</label>

                    <div class="controls" style="width: 100%;margin-left: 5px">
                        <g:textField name="cedula" class="span2 required" style="width: 90%"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="login" style="width: 100%;text-align: left;font-size: 20px;font-family: 'Open Sans Condensed', serif;font-weight: bolder">Correo electrónico:</label>

                    <div class="controls" style="width: 100%;margin-left: 5px">
                        <g:textField name="email" class="span2 required"  id="email" style="width: 90%"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </div>

                <div class="control-group">

                    <a href="#" class="btn btn-primary" id="btnLogin">Continuar</a>
                    <a href="#" id="btnOlvidoPass" style="color: #0088CC;margin-left: 70px;text-decoration: none;font-family: 'Open Sans Condensed', serif;font-weight: bold">
                        No recibió su contraseña?
                    </a>
                </div>
            </fieldset>
        </g:form>
    </g:if>
    <g:else>
        <p class=" tituloGrande" style="float:left;font-family: 'Open Sans Condensed',serif;font-weight: bold;font-size: 25px;width: 95%">Sistema de evaluación</p>
            <div class="alert alert-info" role="status" style="margin-top: 50px;">
                No existe ninguna convocatoria vigente actualmente
            </div>
    </g:else>
</div>


<!-- Modal -->
<div class="modal hide fade" id="modal-pass">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>

        <h3 id="modalTitle"></h3>
    </div>

    <div class="modal-body" id="modalBody">
    </div>

    <div class="modal-footer" id="modalFooter">
        <a href="#" data-dismiss="modal" class="btn">Cerrar</a>
        <a href="#" class="btn btn-success" id="btnSend"><i class="icon-ok"></i> Enviar</a>
    </div>
</div>

<script type="text/javascript">
    $(function () {

        $("#btnOlvidoPass").click(function () {
            var p = $("<p>Por favor repita el paso anterior, registre su cédula y asegurese de escribir correctamente su dirección de correo electrónico.</p>");
            var div = $('<div class="control-group" id="divMail"/>');

            var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
//            var btnSend = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Enviar</a>');


            $("#modalTitle").html(" No recibió su contraseña?");
            $("#modalBody").html("").append(p).append(div);
            $("#modalFooter").html("").append(btnOk)
            $("#modal-pass").modal("show");
        });

        $("#email").keypress(function (ev) {
            if (ev.keyCode == 13) {
                $("#frmLogin").submit();
            }
        });

        $("#btnLogin").click(function () {
            $("#frmLogin").submit();
            return false;
        });

        $("#frmLogin").validate({
            errorPlacement : function (error, element) {
                element.parent().find(".help-block").html(error).show();
            },
            success        : function (label) {
                label.parent().hide();
            },
            errorClass     : "label label-important",
            submitHandler  : function (form) {
                $("#btnLogin").replaceWith(spinnerLogin);
                form.submit();
            }
        });

    });
</script>

</body>
</html>