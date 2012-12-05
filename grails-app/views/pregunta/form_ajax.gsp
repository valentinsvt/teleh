<%@ page import="teleh.Pregunta" %>

<div id="create-Pregunta" class="span" role="main">
<g:form class="form-horizontal" name="frmSave-Pregunta" action="save">
    <g:hiddenField name="id" id="pregId" value="${preguntaInstance?.id}"/>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Examen
            </span>
        </div>

        <div class="controls">
            <g:hiddenField id="examen" name="examen.id" value="${preguntaInstance?.examen?.id}"/>
            ${preguntaInstance?.examen?.descripcion}
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Orden
            </span>
        </div>

        <div class="controls">
            <g:field type="number" name="orden" class="input-mini required" value="${fieldValue(bean: preguntaInstance, field: 'orden')}"/>
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
            <g:textArea name="pregunta" cols="40" rows="1" maxlength="1024" class="input-xxlarge required" value="${preguntaInstance?.pregunta}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Respuestas
            </span>
        </div>

        <div class="controls">

            <ul class="one-to-many">
                <g:each in="${preguntaInstance?.respuestas ?}" var="r">
                    <li><g:link controller="respuesta" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
                </g:each>
                %{--<li class="add">--}%
                    %{--<g:link controller="respuesta" action="create" params="['pregunta.id': preguntaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'respuesta.label', default: 'Respuesta')])}</g:link>--}%
                %{--</li>--}%
            </ul>


            %{--<p class="help-block ui-helper-hidden"></p>--}%
        </div>
    </div>

</g:form>

<script type="text/javascript">

    $("#frmSave-Pregunta").validate({
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
