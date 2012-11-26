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
    <style type="text/css">
        /*input{*/
        /*background-color: #E0E0E0 !important;*/
        /*}*/
    </style>

</head>

<body>
<g:if test="${session.convocatoria}">
    <div style=";color: #939Aa2;width: 600px;position: relative;padding: 10px;min-height: 320px;margin: 0px;float: left;" class="ui-corner-all">

        <div style="height: 125px">
            <img src="${resource(dir: 'images',file: 'logo.jpg')}" alt="">
        </div>

        <div style="min-height: 30px;float: left;width: 98%;margin-top: 10px;border-bottom: 1px solid black">
            <span class=" tituloGrande" style="float:left;font-family: 'Open Sans Condensed',serif;font-weight: bold;font-size: 25px;">
                Convocatoria:
            </span>
            <span  style="float:left;font-family: 'Open Sans Condensed',serif;font-weight: bold;font-size: 20px;margin-left: 10px;color:#333333 ">
                ${session.convocatoria?.descripcion}
            </span>

        </div>
        <div class="" style="width: 98%;color: black;font-family: 'Open Sans Condensed',serif;font-size: 15px;float: left;height: 130px;margin-top: 10px;margin-left: 5px;text-align: justify">
            ${session.convocatoria?.textoInicio}
        </div>


    </div>
    <fieldset style="color: #333;margin-top: 20px;;width: 300px;background-color:#E0E0E0;padding: 10px;height: 346px ">
        <g:form  id="frmLogin" action="registrar" name="frmLogin" style="background: none;border: 0px solid #E0E0E0 !important;padding-left: 0px;margin-left: 0px;box-shadow: none;width: 290px" >

            <div class="alert alert-info" role="status" style="float: left;height: 100px;">
                <a class="close" data-dismiss="alert" href="#">×</a>
                <g:if test="${msn}">
                    ${msn}
                </g:if>
                <g:else>
                    Para empezar el proceso de registro, por favor ingrese su cédula y dirección de correo electrónico
                </g:else>
            </div>


            <div class="control-group" style="margin-top: 0;width: 290px">
                <label class="control-label" for="login" style="width: 100%;text-align: left;font-size: 20px;font-family: 'Open Sans Condensed', serif;font-weight: bolder;margin-left: 5px;">Cédula:</label>

                <div class="controls" style="width: 100%;margin-left: 5px">
                    <g:textField name="cedula" class="span2 required" style="width: 90%"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>

            <div class="control-group" style="width: 290px">
                <label class="control-label" for="login" style="width: 100%;text-align: left;font-size: 20px;font-family: 'Open Sans Condensed', serif;font-weight: bolder;margin-left: 5px;">Correo electrónico:</label>

                <div class="controls" style="width: 100%;margin-left: 5px">
                    <g:textField name="email" class="span2 required"  id="email" style="width: 90%"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>

            <div class="control-group">

                <a href="#" class="btn btn-primary" id="btnLogin" style="margin-left: 10px">Continuar</a>
                <a href="#" id="btnOlvidoPass" style="color: #0088CC;margin-left: 40px;text-decoration: none;font-family: 'Open Sans Condensed', serif;font-weight: bold">
                    No recibió su contraseña?
                </a>
            </div>
        </g:form>
    </fieldset>

</g:if>
<g:else>
    <p class=" tituloGrande" style="float:left;font-family: 'Open Sans Condensed',serif;font-weight: bold;font-size: 25px;width: 95%">Sistema de evaluación</p>
    <div class="alert alert-info" role="status" style="margin-top: 50px;">
        No existe ninguna convocatoria vigente actualmente
    </div>
</g:else>
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
                $("#btnLogin").replaceWith(spinner);
                form.submit();
            }
        });

    });
</script>

</body>
</html>