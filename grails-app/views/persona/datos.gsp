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
            <a href="#" class="btn btn-success btn-save"><i class="icon-save"></i> Guardar</a>
        </div>

        <g:form class="form-horizontal" name="frmSave-Persona" action="savePersona">
            <g:hiddenField name="id" value="${personaInstance?.id}"/>
            <div id="list-grupo" class="span12" role="main" style="margin-top: 10px;margin-left: -10px">
                <div class="area">
                    <p class="tituloTree tituloGrande">Datos generales del aspirante</p>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Apellidos
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:textField name="apellido" maxlength="64" class=" required" value="${personaInstance?.apellido}"/>
                                </div>
                            </div>
                        </div>

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Nombres
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:textField name="nombre" maxlength="64" class=" required" value="${personaInstance?.nombre}"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Cédula
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:textField name="cedula" maxlength="10" class=" required" value="${personaInstance?.cedula}"/>
                                </div>
                            </div>
                        </div>

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Fecha Nacimiento
                                    </span>
                                </div>

                                <div class="controls">
                                    <elm:datepicker name="fechaNacimiento" class=" required" value="${personaInstance?.fechaNacimiento}"
                                                    yearRange="${new Date().format('yyyy').toInteger() - 70}:${new Date().format('yyyy').toInteger() - 18}"
                                                    minDate="new Date(${new Date().format('yyyy').toInteger() - 70}, 0, 1)"
                                                    maxDate="new Date(${new Date().format('yyyy').toInteger() - 18}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Género
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="sexo" from="${personaInstance.constraints.sexo.inList}" class="" value="${personaInstance?.sexo}" valueMessagePrefix="persona.sexo" noSelection="['': '']"/>
                                </div>
                            </div>
                        </div>

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        E-mail
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:field type="email" name="email" class="" value="${personaInstance?.email}"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Ud. se define como
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="etnia" from="${personaInstance.constraints.etnia.inList}" class="" value="${personaInstance?.etnia}" valueMessagePrefix="persona.etnia" noSelection="['': '']"/>
                                </div>
                            </div>
                        </div>

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Promotor CNH
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="promotorCNH" from="${personaInstance.constraints.promotorCNH.inList}" class=" required"
                                              value="${personaInstance?.promotorCNH ? personaInstance.promotorCNH : 'NO'}" valueMessagePrefix="persona.promotorCNH"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Tiene título de
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:if test="${personaInstance?.promotorCNH == 'SI'}">
                                        <g:set var="tipos" value="${['S', 'A']}"/>
                                    </g:if>
                                    <g:else>
                                        <g:set var="tipos" value="${['N', 'A']}"/>
                                    </g:else>
                                    <g:select id="titulo" name="titulo.id" from="${teleh.Titulo.findAllByTipoInList(tipos, [sort: 'descripcion'])}"
                                              optionKey="id" optionValue="${{it.descripcion + ' (' + it.tipoTitulo.descripcion + ')'}}" class="many-to-one " value="${personaInstance?.titulo?.id}" noSelection="['null': '']"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="area">
                    <p class="tituloTree tituloGrande">Conocimiento de lenguas nativas y extrangeras</p>

                    <div class="row-fluid">
                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Habla alguna lengua de los <br/>pueblos y nacionalidades <br/>del Ecuador
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="lenguaNativa" style="width: 70px" from="${personaInstance.constraints.lenguaNativa.inList}" class=" required lengua"
                                              value="${personaInstance?.lenguaNativa}" valueMessagePrefix="persona.lenguaNativa" data-tipo="nativa"/>
                                </div>
                            </div>
                        </div>

                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Certificado por la Dirección </br>Intercultural Bilingüe
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="certificadoNativo" style="width: 70px" from="${personaInstance.constraints.certificadoNativo.inList}" class=" required nativa"
                                              value="${personaInstance?.certificadoNativo}" valueMessagePrefix="persona.certificadoNativo" disabled="${personaInstance?.lenguaNativa == 'NO'}"/>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Lengua nativa
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="tipoIdiomaNativo.id" style="width: 150px" from="${teleh.TipoIdioma.findAllByTipo('N', [sort: 'descripcion'])}" class=" required nativa"
                                              value="${personaInstance?.tipoIdiomaNativo?.id}" optionKey="id" optionValue="descripcion" noSelection="['null': '']" disabled="${personaInstance?.lenguaNativa == 'NO'}"/>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row-fluid">

                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Habla más del 50%
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="habla50Nativa" style="width: 70px" from="${personaInstance.constraints.habla50Nativa.inList}" class=" required nativa"
                                              value="${personaInstance?.habla50Nativa}" valueMessagePrefix="persona.habla50Nativa" disabled="${personaInstance?.lenguaNativa == 'NO'}"/>
                                </div>
                            </div>
                        </div>


                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Domina alguna lengua </br>extrangera
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="lenguaExtrangera" style="width: 70px" from="${personaInstance.constraints.lenguaExtrangera.inList}" class=" required lengua"
                                              value="${personaInstance?.lenguaExtrangera}" valueMessagePrefix="persona.lenguaExtrangera" data-tipo="extrangera"/>
                                </div>
                            </div>
                        </div>

                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Certificado por Institución</br/> reconocida
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="certificadoExtrangero" style="width: 70px" from="${personaInstance.constraints.certificadoExtrangero.inList}" class=" required extrangera"
                                              value="${personaInstance?.certificadoExtrangero}" valueMessagePrefix="persona.certificadoExtrangero" disabled="${personaInstance?.lenguaExtrangera == 'NO'}"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Habla más del 50%
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select name="habla50Extrangera" style="width: 70px" from="${personaInstance.constraints.habla50Extrangera.inList}" class=" required extrangera"
                                              value="${personaInstance?.habla50Extrangera}" valueMessagePrefix="persona.habla50Extrangera" disabled="${personaInstance?.lenguaExtrangera == 'NO'}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="area">
                    <p class="tituloTree tituloGrande">Dirección de residencia</p>

                    <div class="row-fluid">
                        <div class="span10">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Calles y número
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:textField name="direccion" maxlength="128" class="span11 required" value="${personaInstance?.direccion}"/>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        ...en la provincia
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select id="provincia" name="provincia.id" from="${teleh.Provincia.list()}" optionKey="id" class="many-to-one  required"
                                              value="${personaInstance?.provincia?.id}" noSelection="['': '']"/>
                                </div>
                            </div>
                        </div>

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        cantón
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select id="canton" name="canton.id" from="${teleh.Canton.list()}" optionKey="id" class="many-to-one  required"
                                              value="${personaInstance?.canton?.id}" noSelection="['': '']"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        ...de la parroquia
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:select id="parroquia" name="parroquia.id" from="${teleh.Parroquia.list()}" optionKey="id" class="many-to-one "
                                              value="${personaInstance?.parroquia?.id}" noSelection="['': '']"/>
                                </div>
                            </div>
                        </div>

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Comunidad
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:textField name="nombreComunidad" maxlength="63" class="" value="${personaInstance?.nombreComunidad}"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Teléfono fijo
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:textField name="telefonoFijo" maxlength="24" class="" value="${personaInstance?.telefonoFijo}"/>
                                </div>
                            </div>
                        </div>

                        <div class="span5">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Teléfono celular
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:textField name="telefonoCelular" maxlength="24" class="" value="${personaInstance?.telefonoCelular}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="area">
                    <p class="tituloTree tituloGrande">Experiencia específica y capacitación</p>

                    <div class="row-fluid">
                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Años de experiencia
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:field type="number"  style="width: 110px" name="experienciaAnio" class=" required" value="${fieldValue(bean: personaInstance, field: 'experienciaAnio')}"/>
                                </div>
                            </div>
                        </div>

                        <div class="span4">
                            <div class="control-group">
                                <div>
                                    <span class="control-label label label-inverse">
                                        Meses de experiencia
                                    </span>
                                </div>

                                <div class="controls">
                                    <g:field type="number" style="width: 110px" name="experienciaMes" class=" required" value="${fieldValue(bean: personaInstance, field: 'experienciaMes')}"/>
                                </div>
                            </div>
                        </div>

                        <div class="control-group span4">
                            <div>
                                <span class="control-label label label-inverse">
                                    Trabajo comunitario, <br/>pertenece y participa <br/>activamente en alguna <br/>organización activista o <br/>de dirigencia comunitaria <br/>o social
                                </span>
                            </div>

                            <div class="controls">
                                <g:select name="trabajoComunitario"  style="width: 70px" from="${personaInstance.constraints.trabajoComunitario.inList}" class=" required" value="${personaInstance?.trabajoComunitario}" valueMessagePrefix="persona.trabajoComunitario"/>
                            </div>
                        </div>

                    </div>

                    %{--<div class="row-fluid">--}%
                        %{--<div class="span10">--}%
                            %{--<div class="control-group span5">--}%
                                %{--<div>--}%
                                    %{--<span class="control-label label label-inverse">--}%
                                        %{--Trabajo comunitario, <br/>pertenece y participa <br/>activamente en alguna <br/>organización activista o <br/>de dirigencia comunitaria <br/>o social--}%
                                    %{--</span>--}%
                                %{--</div>--}%

                                %{--<div class="controls">--}%
                                    %{--<g:select name="trabajoComunitario"  style="width: 70px" from="${personaInstance.constraints.trabajoComunitario.inList}" class=" required" value="${personaInstance?.trabajoComunitario}" valueMessagePrefix="persona.trabajoComunitario"/>--}%
                                %{--</div>--}%
                            %{--</div>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                </div>

                <div class="area">
                    <p class="tituloTree tituloGrande">Cursos afines al desarrollo integral infantil</p>

                    <table class="table table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th style="width: 100px">Fecha</th>
                                <th style="width: 425px">Institución</th>
                                <th style="width: 425px">Nombre del curso</th>
                                <th>Horas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <elm:datepicker name="fecha1" style="width: 100px" class=" required" value="${personaInstance?.fecha1}"
                                                    minDate="new Date(2009,0,1)" maxDate="new Date(${new Date().format('yyyy')}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"/>
                                </td>
                                <td>
                                    <g:textField name="institucion1" style="width: 425px" maxlength="96" class="" value="${personaInstance?.institucion1}"/>
                                </td>
                                <td>
                                    <g:textField name="nombreCurso1" style="width: 425px" maxlength="96" class="" value="${personaInstance?.nombreCurso1}"/>
                                </td>
                                <td>
                                    <g:field type="number" name="horas1"  style="width: 70px" class=" required" value="${fieldValue(bean: personaInstance, field: 'horas1')}"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <elm:datepicker name="fecha2" style="width: 100px" class=" required" value="${personaInstance?.fecha2}"
                                                    minDate="new Date(2009,0,1)" maxDate="new Date(${new Date().format('yyyy')}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"/>
                                </td>
                                <td>
                                    <g:textField name="institucion2" style="width: 425px" maxlength="96" class="" value="${personaInstance?.institucion2}"/>
                                </td>
                                <td>
                                    <g:textField name="nombreCurso2" style="width: 425px" maxlength="96" class="" value="${personaInstance?.nombreCurso2}"/>
                                </td>
                                <td>
                                    <g:field type="number" name="horas2" style="width: 70px" class=" required" value="${fieldValue(bean: personaInstance, field: 'horas2')}"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <elm:datepicker name="fecha3" style="width: 100px" class=" required" value="${personaInstance?.fecha3}"
                                                    minDate="new Date(2009,0,1)" maxDate="new Date(${new Date().format('yyyy')}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"/>
                                </td>
                                <td>
                                    <g:textField name="institucion3" style="width: 425px" maxlength="96" class="" value="${personaInstance?.institucion3}"/>
                                </td>
                                <td>
                                    <g:textField name="nombreCurso3" style="width: 425px" maxlength="96" class="" value="${personaInstance?.nombreCurso3}"/>
                                </td>
                                <td>
                                    <g:field type="number" name="horas3" style="width: 70px" class=" required" value="${fieldValue(bean: personaInstance, field: 'horas3')}"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </g:form>

        <div class="span12 btn-group" role="navigation" style="margin-bottom: 20px;">
            <a href="#" class="btn btn-success btn-save"><i class="icon-save"></i> Guardar</a>
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

                $("#promotorCNH").change(function () {
                    var val = $(this).val();

                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'cargarTitulos')}",
                        data    : {
                            promotor : val
                        },
                        success : function (msg) {
                            $("#titulo").replaceWith(msg);
                        }
                    });
                }); //combo promotor

                $(".lengua").change(function () {
                    var tipo = $(this).data("tipo");
                    var disabled = $(this).val() == "NO";
                    $("." + tipo).val("NO").prop("disabled", disabled);
                }); //combos idiomas

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