<%@ page import="teleh.PreguntaEntrevista" %>

<div id="create-PreguntaEntrevista" class="span" role="main">
<g:form class="form-horizontal" name="frmSave-PreguntaEntrevista" action="save">
    <g:hiddenField name="id" value="${preguntaEntrevistaInstance?.id}"/>


    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Convocatoria
            </span>
        </div>

        <div class="controls">
            ${preguntaEntrevistaInstance.convocatoria.descripcion}
            <g:hiddenField id="convocatoria" name="convocatoria.id" value="${preguntaEntrevistaInstance?.convocatoria?.id}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Tipo
            </span>
        </div>

        <div class="controls">
            <g:select name="tipo" from="${preguntaEntrevistaInstance.constraints.tipo.inList}" class=" required" value="${preguntaEntrevistaInstance?.tipo}" valueMessagePrefix="preguntaEntrevista.tipo"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Orden
            </span>
        </div>

        <div class="controls">
            <g:field type="number" name="orden" class=" required" value="${fieldValue(bean: preguntaEntrevistaInstance, field: 'orden')}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Numero
            </span>
        </div>

        <div class="controls">
            <g:field type="number" name="numero" class=" required" value="${fieldValue(bean: preguntaEntrevistaInstance, field: 'numero')}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Pregunta
            </span>
        </div>

        <div class="controls">
            <g:textField name="pregunta" class=" required" value="${preguntaEntrevistaInstance?.pregunta}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Valoracion
            </span>
        </div>

        <div class="controls">
            <g:textField name="valoracion" class=" required" value="${preguntaEntrevistaInstance?.valoracion}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Positivo
            </span>
        </div>

        <div class="controls">
            <g:field type="number" name="positivo" class=" required" value="${fieldValue(bean: preguntaEntrevistaInstance, field: 'positivo')}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Negativo
            </span>
        </div>

        <div class="controls">
            <g:field type="number" name="negativo" class=" required" value="${fieldValue(bean: preguntaEntrevistaInstance, field: 'negativo')}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

</g:form>

<script type="text/javascript">
    $("#frmSave-PreguntaEntrevista").validate({
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
