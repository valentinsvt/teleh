<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>

    <head>
        <meta name="layout" content="login">
        <title>Ingreso al sistema</title>

        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>
        <link href='${resource(dir: "css", file: "custom.css")}' rel='stylesheet' type='text/css'>
        <link href='${resource(dir: "font/open", file: "stylesheet.css")}' rel='stylesheet' type='text/css'>
        <link href='${resource(dir: "font/tulpen", file: "stylesheet.css")}' rel='stylesheet' type='text/css'>

    </head>

    <body>
        <div style=";color: #939Aa2;width: 600px;position: relative;padding: 10px;min-height: 320px;margin: 0px;float: left;" class="ui-corner-all">

            <div style="height: 125px">
                <img src="${resource(dir: 'images', file: 'logo.jpg')}" alt="">
            </div>

            <div style="min-height: 30px;float: left;width: 98%;margin-top: 10px;border-bottom: 1px solid black">
                <span class=" tituloGrande" style="float:left;font-family: 'Open Sans Condensed',serif;font-weight: bold;font-size: 25px;">
                    Convocatoria:
                </span>
                <span style="float:left;font-family: 'Open Sans Condensed',serif;font-weight: bold;font-size: 20px;margin-left: 10px;color:#333333 ">
                    ${session.convocatoria?.descripcion}
                </span>

            </div>

            <div class="" style="width: 98%;color: black;font-family: 'Open Sans Condensed',serif;font-size: 15px;float: left;height: 130px;margin-top: 10px;margin-left: 5px;text-align: justify">
                ${session.convocatoria?.textoInicio}
            </div>

            <div class="" style="width: 98%;color: black;font-family: 'Open Sans Condensed',serif;font-size: 25px;float: left;height: 130px;margin-top: 10px;margin-left: 5px;text-align: justify">
                <a href="${g.createLink(controller: 'registro')}" class="btn btn-primary" style="font-size: 20px">Registrarse</a>
            </div>

        </div>

        <div style="border: 1px solid #525E67;background: #E0E0E0;color: #939Aa2;width: 320px;position: relative;padding: 10px;height: 360px;margin: 0px;float: left" class="ui-corner-all">
            <g:if test="${session.convocatoria}">
                <g:form class="well form-horizontal" id="frmLogin" action="validar" name="frmLogin" style="background: none;border: 0px solid #E0E0E0 !important;padding: 0px;margin-left: 10px;box-shadow: none">

                    <fieldset style="background: none;margin: 0px;border: 0px solid #E0E0E0 !important;color: #333;margin-top: 0px">

                        <div class="alert alert-info" role="status" style="float: left;height: 95px;">
                            <a class="close" data-dismiss="alert" href="#">×</a>
                            <g:if test="${flash.message}">
                                ${flash.message}
                            </g:if>
                            <g:else>
                                Para rendir la <b>PRUEBA</b>, ingrese su número de cédula y la contraseña que fue enviada a su correo electrónico cuando se
                                <b>Registró</b> y si ha recibido el correo de que ha sido calificad@.
                            </g:else>
                        </div>

                        <div class="control-group" style="margin-top: 0">
                            <label class="control-label" for="login" style="width: 100%;text-align: left;font-size: 20px;font-family: 'Open Sans Condensed', serif;font-weight: bolder">Cédula:</label>

                            <div class="controls" style="width: 100%;margin-left: 5px">
                                <g:textField name="cedula" class="span2 required" style="width: 90%"/>
                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="login" style="width: 100%;text-align: left;font-size: 20px;font-family: 'Open Sans Condensed', serif;font-weight: bolder">Contraseña:</label>

                            <div class="controls" style="width: 100%;margin-left: 5px">
                                <g:passwordField name="pin" class="span2 required" id="pass" style="width: 90%"/>
                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </div>

                        <div class="control-group">
                            <a href="#" class="btn btn-primary" id="btnLogin">Continuar</a>
                        </div>

                        <div class="control-group">
                            <a href="#" id="btnOlvidoPass" style="color: #0088CC;text-decoration: none;font-family: 'Open Sans Condensed', serif;font-weight: bold">
                                Si olvidó su contraseña, haga click AQUÍ...
                            </a>
                        </div>

                    </fieldset>
                </g:form>
            </g:if>
            <g:else>
                <div class="alert alert-info" role="status" style="margin-top: 50px;">
                    <h2>Sistema de evaluación</h2>
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
                    var p = $("<p>Ingrese su número de cédula y el email registrado a su usuario y se le enviará una nueva contraseña para ingresar al sistema.</p>");
                    var div = $('<div class="control-group" id="divMail"/>');
                    var input = $('<input type="text" class="" id="ci" placeholder="Cédula"/>');
                    var input2 = $('<input type="text" class="" id="email" placeholder="Email"/>');
                    div.append(input).append("<br/>").append(input2);

                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
                    var btnSend = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Enviar</a>');

                    var send = function () {
                        var ci = $.trim(input.val());
                        var email = $.trim(input2.val());
                        if (ci != "" && email != "") {
                            btnSend.replaceWith(spinner);
                            $.ajax({
                                type    : "POST",
                                url     : "${createLink(action:'olvidoPass')}",
                                data    : {
                                    ci    : ci,
                                    email : email
                                },
                                success : function (msg) {
                                    var parts = msg.split("*");
                                    if (parts[0] == "OK") {
                                        $("#modalBody").addClass("alert alert-success");
                                    } else {
                                        $("#modalBody").addClass("alert alert-error");
                                    }
                                    $("#modalBody").html(parts[1]);
                                    spinner.remove();
                                }
                            });
                        } else {
                            $("#divMail").addClass("error");
                        }
                    };

                    btnSend.click(function () {
                        send();
                        return false;
                    });
                    input.keyup(function (ev) {
                        if (ev.keyCode == 13) {
                            send();
                        }
                    });

                    $("#modalTitle").html("Olvidó su contraseña?");
                    $("#modalBody").html("").append(p).append(div);
                    $("#modalFooter").html("").append(btnOk).append(btnSend);
                    $("#modal-pass").modal("show");
                });

                $("#pass").keypress(function (ev) {
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