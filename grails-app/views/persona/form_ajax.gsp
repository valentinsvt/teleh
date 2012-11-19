<%@ page import="teleh.Persona" %>

<div id="create-Persona" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-Persona" action="save">
        <g:hiddenField name="id" value="${personaInstance?.id}"/>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Convocatoria
                </span>
            </div>

            <div class="controls">
                <g:select id="convocatoria" name="convocatoria.id" from="${teleh.Convocatoria.list()}" optionKey="id" class="many-to-one  required" value="${personaInstance?.convocatoria?.id}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Provincia
                </span>
            </div>

            <div class="controls">
                <g:select id="provincia" name="provincia.id" from="${teleh.Provincia.list()}" optionKey="id" class="many-to-one  required" value="${personaInstance?.provincia?.id}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Canton
                </span>
            </div>

            <div class="controls">
                <g:select id="canton" name="canton.id" from="${teleh.Canton.list()}" optionKey="id" class="many-to-one  required" value="${personaInstance?.canton?.id}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Parroquia
                </span>
            </div>

            <div class="controls">
                <g:select id="parroquia" name="parroquia.id" from="${teleh.Parroquia.list()}" optionKey="id" class="many-to-one " value="${personaInstance?.parroquia?.id}" noSelection="['null': '']"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Titulo
                </span>
            </div>

            <div class="controls">
                <g:select id="titulo" name="titulo.id" from="${teleh.Titulo.list()}" optionKey="id" class="many-to-one " value="${personaInstance?.titulo?.id}" noSelection="['null': '']"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Estado
                </span>
            </div>

            <div class="controls">
                <g:select id="estado" name="estado.id" from="${teleh.Estado.list()}" optionKey="id" class="many-to-one  required" value="${personaInstance?.estado?.id}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Apellido
                </span>
            </div>

            <div class="controls">
                <g:textField name="apellido" maxlength="64" class=" required" value="${personaInstance?.apellido}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Nombre
                </span>
            </div>

            <div class="controls">
                <g:textField name="nombre" maxlength="64" class=" required" value="${personaInstance?.nombre}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Cedula
                </span>
            </div>

            <div class="controls">
                <g:textField name="cedula" maxlength="10" class=" required" value="${personaInstance?.cedula}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Fecha Nacimiento
                </span>
            </div>

            <div class="controls">
                <elm:datepicker name="fechaNacimiento" class=" required" value="${personaInstance?.fechaNacimiento}"/>

                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Sexo
                </span>
            </div>

            <div class="controls">
                <g:select name="sexo" from="${personaInstance.constraints.sexo.inList}" class="" value="${personaInstance?.sexo}" valueMessagePrefix="persona.sexo" noSelection="['': '']"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Email
                </span>
            </div>

            <div class="controls">
                <g:field type="email" name="email" class="" value="${personaInstance?.email}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Etnia
                </span>
            </div>

            <div class="controls">
                <g:select name="etnia" from="${personaInstance.constraints.etnia.inList}" class="" value="${personaInstance?.etnia}" valueMessagePrefix="persona.etnia" noSelection="['': '']"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Promotor CNH
                </span>
            </div>

            <div class="controls">
                <g:select name="promotorCNH" from="${personaInstance.constraints.promotorCNH.inList}" class=" required" value="${personaInstance?.promotorCNH}" valueMessagePrefix="persona.promotorCNH"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Lengua Nativa
                </span>
            </div>

            <div class="controls">
                <g:select name="lenguaNativa" from="${personaInstance.constraints.lenguaNativa.inList}" class=" required" value="${personaInstance?.lenguaNativa}" valueMessagePrefix="persona.lenguaNativa"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Lengua Extrangera
                </span>
            </div>

            <div class="controls">
                <g:select name="lenguaExtrangera" from="${personaInstance.constraints.lenguaExtrangera.inList}" class=" required" value="${personaInstance?.lenguaExtrangera}" valueMessagePrefix="persona.lenguaExtrangera"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Certificado Nativo
                </span>
            </div>

            <div class="controls">
                <g:select name="certificadoNativo" from="${personaInstance.constraints.certificadoNativo.inList}" class=" required" value="${personaInstance?.certificadoNativo}" valueMessagePrefix="persona.certificadoNativo"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Certificado Extrangero
                </span>
            </div>

            <div class="controls">
                <g:select name="certificadoExtrangero" from="${personaInstance.constraints.certificadoExtrangero.inList}" class=" required" value="${personaInstance?.certificadoExtrangero}" valueMessagePrefix="persona.certificadoExtrangero"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Habla50 Nativa
                </span>
            </div>

            <div class="controls">
                <g:select name="habla50Nativa" from="${personaInstance.constraints.habla50Nativa.inList}" class=" required" value="${personaInstance?.habla50Nativa}" valueMessagePrefix="persona.habla50Nativa"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Habla50 Extrangera
                </span>
            </div>

            <div class="controls">
                <g:select name="habla50Extrangera" from="${personaInstance.constraints.habla50Extrangera.inList}" class=" required" value="${personaInstance?.habla50Extrangera}" valueMessagePrefix="persona.habla50Extrangera"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Direccion
                </span>
            </div>

            <div class="controls">
                <g:textField name="direccion" maxlength="128" class=" required" value="${personaInstance?.direccion}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Telefono Fijo
                </span>
            </div>

            <div class="controls">
                <g:textField name="telefonoFijo" maxlength="24" class="" value="${personaInstance?.telefonoFijo}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Telefono Celular
                </span>
            </div>

            <div class="controls">
                <g:textField name="telefonoCelular" maxlength="24" class="" value="${personaInstance?.telefonoCelular}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Nombre Comunidad
                </span>
            </div>

            <div class="controls">
                <g:textField name="nombreComunidad" maxlength="63" class="" value="${personaInstance?.nombreComunidad}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Experiencia Anio
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="experienciaAnio" class=" required" value="${fieldValue(bean: personaInstance, field: 'experienciaAnio')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Experiencia Mes
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="experienciaMes" class=" required" value="${fieldValue(bean: personaInstance, field: 'experienciaMes')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Trabajo Comunitario
                </span>
            </div>

            <div class="controls">
                <g:select name="trabajoComunitario" from="${personaInstance.constraints.trabajoComunitario.inList}" class=" required" value="${personaInstance?.trabajoComunitario}" valueMessagePrefix="persona.trabajoComunitario"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Fecha1
                </span>
            </div>

            <div class="controls">
                <elm:datepicker name="fecha1" class=" required" value="${personaInstance?.fecha1}"/>

                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Fecha2
                </span>
            </div>

            <div class="controls">
                <elm:datepicker name="fecha2" class=" required" value="${personaInstance?.fecha2}"/>

                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Fecha3
                </span>
            </div>

            <div class="controls">
                <elm:datepicker name="fecha3" class=" required" value="${personaInstance?.fecha3}"/>

                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Institucion1
                </span>
            </div>

            <div class="controls">
                <g:textField name="institucion1" maxlength="96" class="" value="${personaInstance?.institucion1}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Institucion2
                </span>
            </div>

            <div class="controls">
                <g:textField name="institucion2" maxlength="96" class="" value="${personaInstance?.institucion2}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Institucion3
                </span>
            </div>

            <div class="controls">
                <g:textField name="institucion3" maxlength="96" class="" value="${personaInstance?.institucion3}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Nombre Curso1
                </span>
            </div>

            <div class="controls">
                <g:textField name="nombreCurso1" maxlength="96" class="" value="${personaInstance?.nombreCurso1}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Nombre Curso2
                </span>
            </div>

            <div class="controls">
                <g:textField name="nombreCurso2" maxlength="96" class="" value="${personaInstance?.nombreCurso2}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Nombre Curso3
                </span>
            </div>

            <div class="controls">
                <g:textField name="nombreCurso3" maxlength="96" class="" value="${personaInstance?.nombreCurso3}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Horas1
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="horas1" class=" required" value="${fieldValue(bean: personaInstance, field: 'horas1')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Horas2
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="horas2" class=" required" value="${fieldValue(bean: personaInstance, field: 'horas2')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Horas3
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="horas3" class=" required" value="${fieldValue(bean: personaInstance, field: 'horas3')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Pin
                </span>
            </div>

            <div class="controls">
                <g:textField name="pin" maxlength="5" class="" value="${personaInstance?.pin}"/>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje Titulo
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntajeTitulo" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajeTitulo')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje Cursos
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntajeCursos" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajeCursos')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje Experiencia
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntajeExperiencia" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajeExperiencia')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje Trabajo Comunitario
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntajeTrabajoComunitario" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajeTrabajoComunitario')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje Bilingue
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntajeBilingue" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajeBilingue')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje Prueba
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntajePrueba" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajePrueba')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje Entrevista
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntajeEntrevista" class=" required" value="${fieldValue(bean: personaInstance, field: 'puntajeEntrevista')}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

    </g:form>
</div>

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
