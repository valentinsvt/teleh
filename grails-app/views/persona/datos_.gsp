<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 11/19/12
  Time: 12:54 PM
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

        table td {
            border : none !important;
        }

        .sep {
            width : 20px;
        }
        </style>

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

        <div class="span12 btn-group" role="navigation">
            <a href="#" class="btn btn-ajax btn-new" id="guardar">
                <i class="icon-file"></i>
                Guardar
            </a>
        </div>

        <g:form class="form-horizontal" name="frmSave-Persona" action="save">
            <g:hiddenField name="id" value="${personaInstance?.id}"/>
            <div id="list-grupo" class="span12" role="main" style="margin-top: 10px;margin-left: -10px">
                <div style="border-bottom: 1px solid black;padding-left: 50px;position: relative;">
                    <p class="css-vertical-text">Datos generales del aspirante</p>

                    <div class="linea" style="height: 100px;"></div>

                    <div class="row-fluid">
                        <div class="span2">
                            Apellidos
                            <g:textField name="apellido" maxlength="64" class=" required" value="${personaInstance?.apellido}"/>
                        </div>

                        <div class="span6">
                            Descripción
                            <input type="text" name="rubro.nombre" class="span72" value="">
                        </div>

                        <div class="span1" style="border: 0px solid black;height: 45px;padding-top: 18px">

                            <div class="btn-group" data-toggle="buttons-checkbox">
                                <button type="button" id="rubro_registro" class="btn btn-info " style="font-size: 10px">Registrado</button>
                            </div>
                            <input type="hidden" id="registrado" name="rubro.registro" value="">

                        </div>

                        <div class="span2">
                            Fecha registro
                            <elm:datepicker name="rubro.fechaReg" class="span24" value="" disabled="true" id="fechaReg"/>
                        </div>

                    </div>
                </div>
            </div>
        </g:form>

    %{--<div id="create-Persona" class="span" role="main">--}%
    %{--<g:form class="form-horizontal" name="frmSave-Persona" action="save">--}%
    %{--<g:hiddenField name="id" value="${personaInstance?.id}"/>--}%

    %{--<table class="table">--}%
    %{--<tr>--}%
    %{--<th colspan="5">--}%
    %{--Datos generales del aspirante--}%
    %{--</th>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Apellidos--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:textField name="apellido" maxlength="64" class=" required" value="${personaInstance?.apellido}"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--<td class="sep"></td>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Nombres--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:textField name="nombre" maxlength="64" class=" required" value="${personaInstance?.nombre}"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Cédula--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:textField name="cedula" maxlength="10" class=" required" value="${personaInstance?.cedula}"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--<td class="sep"></td>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Fecha Nacimiento--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<elm:datepicker name="fechaNacimiento" class=" required" value="${personaInstance?.fechaNacimiento}"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Género--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:select name="sexo" from="${personaInstance.constraints.sexo.inList}" class="" value="${personaInstance?.sexo}" valueMessagePrefix="persona.sexo" noSelection="['': '']"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--<td class="sep"></td>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--E-mail--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:field type="email" name="email" class="" value="${personaInstance?.email}"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Ud. se define como--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:select name="etnia" from="${personaInstance.constraints.etnia.inList}" class="" value="${personaInstance?.etnia}" valueMessagePrefix="persona.etnia" noSelection="['': '']"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--<td class="sep"></td>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Promotor CNH--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:select name="promotorCNH" from="${personaInstance.constraints.promotorCNH.inList}" class=" required" value="${personaInstance?.promotorCNH}" valueMessagePrefix="persona.promotorCNH"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--<td class="sep"></td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Tiene título de--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:select id="titulo" name="titulo.id" from="${teleh.Titulo.list()}" optionKey="id" class="many-to-one " value="${personaInstance?.titulo?.id}" noSelection="['null': '']"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--<td class="sep"></td>--}%
    %{--<td class="control-label label label-inverse">--}%
    %{--Puntaje--}%
    %{--</td>--}%
    %{--<td>--}%
    %{--<g:field type="number" name="puntajeTitulo" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajeTitulo')}"/>--}%
    %{--<p class="help-block ui-helper-hidden"></p>--}%
    %{--</td>--}%
    %{--</tr>--}%
    %{--<tr>--}%
    %{--<th colspan="5">--}%
    %{--Conocimiento de lenguas nativas y extranjeras--}%
    %{--</th>--}%
    %{--</tr>--}%
    %{--</table>--}%

    %{--</g:form>--}%
    %{--</div>--}%

        <script type="text/javascript">
            $("#frmSave-Persona").validate({
                errorPlacement : function (error, element) {
                    element.parent().find(".help-block").html(error).show();
                },
                success        : function (label) {
                    label.parent().hide();
                },
                errorClass     : "label label-important",
                submitHandler  : function (form) {
                    $(".btn-success").replaceWith(spinner);
                    form.submit();
                }
            });

            $("input").keyup(function (ev) {
                if (ev.keyCode == 13) {
                    submitForm($(".btn-success"));
                }
            });
        </script>

    </body>
</html>