<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 11/19/12
  Time: 12:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="teleh.Provincia; teleh.Canton; teleh.Persona" %>
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
    p {
        border : none !important;
        height : 30px;
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
    <a href="#" class="btn btn-success btn-save"><i class="icon-save"></i> Guardar</a>
</div>

<g:form class="form-horizontal" name="frmSave-Persona" action="savePersona" style="min-width: 1200px;">
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
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                    <g:textField name="cedula" maxlength="10" class=" required" value="${personaInstance?.cedula}" disabled="true"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>
        </div>

        <div class="span5">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Fec. Nacimiento
                    </span>
                </div>

                <div class="controls">
                    <elm:datepicker name="fechaNacimiento" class=" required" value="${personaInstance?.fechaNacimiento}"
                                    yearRange="${new Date().format('yyyy').toInteger() - 70}:${new Date().format('yyyy').toInteger() - 18}"
                                    minDate="new Date(${new Date().format('yyyy').toInteger() - 70}, 0, 1)"
                                    maxDate="new Date(${new Date().format('yyyy').toInteger() - 18}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"
                                    rel="tooltip" title="Fecha de nacimiento"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                    <g:select name="sexo" from="${personaInstance.constraints.sexo.inList}" class="required" value="${personaInstance?.sexo}" valueMessagePrefix="persona.sexo" noSelection="['': '']"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                    <g:field type="email" name="email" class="required" value="${personaInstance?.email}"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>
        </div>
    </div>

    <div class="row-fluid">
        <div class="span5">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Etnia
                    </span>
                </div>

                <div class="controls">
                    <g:select name="etnia" from="${personaInstance.constraints.etnia.inList}" rel="tooltip" title="Ud. se define como"
                              class="" value="${personaInstance?.etnia}" valueMessagePrefix="persona.etnia" noSelection="['': '']"/>
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
                    <g:select name="promotorCNH" from="${personaInstance.constraints.promotorCNH.inList}" class=" " rel="tooltip" title="Ud. está trabajando actualmente como promotor CNH"
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
                              optionKey="id" optionValue="${{it.descripcion + ' (' + it.tipoTitulo.descripcion + ')'}}" class="many-to-one required"
                              value="${personaInstance?.titulo?.id}" noSelection="['null': '']"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="area">
    <p class="tituloTree tituloGrande">Conocimiento de lenguas nativas y extranjeras</p>

    <div class="row-fluid">
        <div class="span3">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Habla lengua<br/>nativa
                    </span>
                </div>

                <div class="controls">
                    <g:select name="lenguaNativa" style="width: 70px" from="${personaInstance.constraints.lenguaNativa.inList}" class=" required lengua"
                              rel="tooltip" title="Habla alguna lengua de los pueblos y nacionalidades del Ecuador"
                              value="${personaInstance?.lenguaNativa}" valueMessagePrefix="persona.lenguaNativa" data-tipo="nativa"/>
                </div>
            </div>
        </div>

        <div class="span3">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Certificado
                    </span>
                </div>

                <div class="controls">
                    <g:select name="certificadoNativo" style="width: 70px" from="${personaInstance.constraints.certificadoNativo.inList}" class=" required nativa"
                              rel="tooltip" title="Certificado por la Dirección Intercultural Bilingüe"
                              value="${personaInstance?.certificadoNativo}" valueMessagePrefix="persona.certificadoNativo" disabled="${personaInstance?.lenguaNativa == 'NO'}"/>
                </div>
            </div>
        </div>

        <div class="span3">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Lengua nativa
                    </span>
                </div>

                <div class="controls">
                    <g:select name="tipoIdiomaNativo.id" style="width: 150px" from="${teleh.TipoIdioma.findAllByTipo('N', [sort: 'descripcion'])}" class=" required nativa"
                              rel="tooltip" title="Lengua nativa que habla"
                              value="${personaInstance?.tipoIdiomaNativo?.id}" optionKey="id" optionValue="descripcion" noSelection="['null': '']" disabled="${personaInstance?.lenguaNativa == 'NO'}"/>
                </div>
            </div>
        </div>

    </div>

    <div class="row-fluid">

        <div class="span3">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Habla más<br/>del 50%
                    </span>
                </div>

                <div class="controls">
                    <g:select name="habla50Nativa" style="width: 70px" from="${personaInstance.constraints.habla50Nativa.inList}" class=" required nativa"
                              rel="tooltip" title="Habla más del 50% de la lengua nativa?"
                              value="${personaInstance?.habla50Nativa}" valueMessagePrefix="persona.habla50Nativa" disabled="${personaInstance?.lenguaNativa == 'NO'}"/>
                </div>
            </div>
        </div>


        <div class="span3">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Habla lengua </br>extranjera
                    </span>
                </div>

                <div class="controls">
                    <g:select name="lenguaExtrangera" style="width: 70px" from="${personaInstance.constraints.lenguaExtrangera.inList}" class=" required lengua"
                              rel="tooltip" title="Domina alguna lengua extranjera"
                              value="${personaInstance?.lenguaExtrangera}" valueMessagePrefix="persona.lenguaExtrangera" data-tipo="extrangera"/>
                </div>
            </div>
        </div>

        <div class="span3">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Certificado
                    </span>
                </div>

                <div class="controls">
                    <g:select name="certificadoExtrangero" style="width: 70px" from="${personaInstance.constraints.certificadoExtrangero.inList}" class=" required extrangera"
                              rel="tooltip" title="Certificado por Institución reconocida"
                              value="${personaInstance?.certificadoExtrangero}" valueMessagePrefix="persona.certificadoExtrangero" disabled="${personaInstance?.lenguaExtrangera == 'NO'}"/>
                </div>
            </div>
        </div>
    </div>

    <div class="row-fluid">
        <div class="span3">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Habla más<br/>del 50%
                    </span>
                </div>

                <div class="controls">
                    <g:select name="habla50Extrangera" style="width: 70px" from="${personaInstance.constraints.habla50Extrangera.inList}" class=" required extrangera"
                              rel="tooltip" title="Habla más del 50% de la lengua extranjera?"
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
                    <g:textField name="direccion" maxlength="128" class="span11 required" style="width: 700px" value="${personaInstance?.direccion}"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                    <g:select name="provincia.id" from="${teleh.Provincia.list()}" optionKey="id" class="many-to-one  required"
                              value="${personaInstance?.provincia?.id}" noSelection="['': '']" id="cmb_prov"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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

                <div class="controls" id="div_canton">
                    <g:select name="canton.id" from="${personaInstance?.provincia?.id ? Canton.findAllByProvincia(Provincia.get(personaInstance.provinciaId)) : []}"
                              optionKey="id" class="many-to-one  required"
                              value="${personaInstance?.canton?.id}" noSelection="['': '']" id="cmb_canton"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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

                <div class="controls" id="div_parr">
                    <g:select name="parroquia.id" from="${personaInstance?.canton?.id ? teleh.Parroquia.findAllByCanton(Canton.get(personaInstance.cantonId)) : []}"
                              optionKey="id" class="many-to-one required"
                              value="${personaInstance?.parroquia?.id}" noSelection="['': '']" id="cmb_parr"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                    <g:textField name="telefonoFijo" maxlength="9" class="digits required telefono" value="${personaInstance?.telefonoFijo}"
                                 rel="tooltip" title="Hasta 9 dígitos: ej. 022134567"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                    <g:textField name="telefonoCelular" maxlength="10" class="digits required celular" value="${personaInstance?.telefonoCelular}"
                                 rel="tooltip" title="Hasta 10 dígitos: ej. 0998765432"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
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
                        Años de <br/>experiencia
                    </span>
                </div>

                <div class="controls">
                    <g:field type="number" style="width: 110px" maxlength="2" max="99" name="experienciaAnio" class="digits required" value="${fieldValue(bean: personaInstance, field: 'experienciaAnio')}"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>
        </div>

        <div class="span4">
            <div class="control-group">
                <div>
                    <span class="control-label label label-inverse">
                        Meses de <br/>experiencia
                    </span>
                </div>


                <div class="controls">
                    <g:field type="number" style="width: 110px" maxlength="2" max="99" name="experienciaMes" class="digits required" value="${fieldValue(bean: personaInstance, field: 'experienciaMes')}"/>
                    <span class="mandatory">*</span>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </div>
        </div>

        <div class="control-group span4">
            <div>
                <span class="control-label label label-inverse">
                    Trabajo<br/>comunitario
                </span>
            </div>

            <div class="controls">
                <g:select name="trabajoComunitario" style="width: 70px" from="${personaInstance.constraints.trabajoComunitario.inList}"
                          rel="tooltip" title="Trabajo comunitario: pertenece y participa activamente en alguna organización activista o de dirigencia comunitaria o social"
                          class=" required" value="${personaInstance?.trabajoComunitario}" valueMessagePrefix="persona.trabajoComunitario"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

    </div>

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
                <elm:datepicker name="fecha1" style="width: 100px" class=" " value="${personaInstance?.fecha1}"
                                minDate="new Date(2009,0,1)" maxDate="new Date(${new Date().format('yyyy')}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"/>
            </td>
            <td>
                <g:textField name="institucion1" style="width: 425px" maxlength="96" class="" value="${personaInstance?.institucion1}"/>
            </td>
            <td>
                <g:textField name="nombreCurso1" style="width: 425px" maxlength="96" class="" value="${personaInstance?.nombreCurso1}"/>
            </td>
            <td>
                <g:field type="number" name="horas1" style="width: 70px" class=" " value="${fieldValue(bean: personaInstance, field: 'horas1')}"/>
            </td>
        </tr>
        <tr>
            <td>
                <elm:datepicker name="fecha2" style="width: 100px" class=" " value="${personaInstance?.fecha2}"
                                minDate="new Date(2009,0,1)" maxDate="new Date(${new Date().format('yyyy')}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"/>
            </td>
            <td>
                <g:textField name="institucion2" style="width: 425px" maxlength="96" class="" value="${personaInstance?.institucion2}"/>
            </td>
            <td>
                <g:textField name="nombreCurso2" style="width: 425px" maxlength="96" class="" value="${personaInstance?.nombreCurso2}"/>
            </td>
            <td>
                <g:field type="number" name="horas2" style="width: 70px" class=" " value="${fieldValue(bean: personaInstance, field: 'horas2')}"/>
            </td>
        </tr>
        <tr>
            <td>
                <elm:datepicker name="fecha3" style="width: 100px" class=" " value="${personaInstance?.fecha3}"
                                minDate="new Date(2009,0,1)" maxDate="new Date(${new Date().format('yyyy')}, ${new Date().format('MM').toInteger() - 1}, ${new Date().format('dd')})"/>
            </td>
            <td>
                <g:textField name="institucion3" style="width: 425px" maxlength="96" class="" value="${personaInstance?.institucion3}"/>
            </td>
            <td>
                <g:textField name="nombreCurso3" style="width: 425px" maxlength="96" class="" value="${personaInstance?.nombreCurso3}"/>
            </td>
            <td>
                <g:field type="number" name="horas3" style="width: 70px" class=" " value="${fieldValue(bean: personaInstance, field: 'horas3')}"/>
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
        if ($("#frmSave-Persona").valid()) {
            btn.replaceWith(spinner);
        }
        $("#frmSave-Persona").submit();
    }
    $(function () {
        $("[rel=tooltip]").tooltip();

        $("#frmSave-Persona").validate({
            errorPlacement : function (error, element) {
                element.parent().find(".help-block").html(error).show();
            },
            success        : function (label) {
                label.parent().hide();
            },
            errorClass     : "label label-important",
            messages       : {
                experienciaAnio : {
                    maxlength : "No más de 2 caracteres"
                },
                experienciaMes  : {
                    maxlength : "No más de 2 caracteres"
                }
            },
            submitHandler  : function (form) {
                $(".btn-success").replaceWith(spinner);
                form.submit();
            }
        });

        $("#cmb_prov").change(function () {
            var id = $(this).val()
            $("#div_parr").html("")
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'comboCanton')}",
                data    : {
                    id : id
                },
                success : function (msg) {
                    $("#div_canton").html(msg);
                }
            });
        });

        $("#cmb_canton").change(function () {
            var id = $(this).val()
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'comboParr')}",
                data    : {
                    id : id
                },
                success : function (msg) {
                    $("#div_parr").html(msg);
                }
            });
        });

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

    //                        $("input").keyup(function (ev) {
    //                            if (ev.keyCode == 13) {
    //                                submitForm($(".btn-success"));
    //                            }
    //                        });
</script>

</body>
</html>