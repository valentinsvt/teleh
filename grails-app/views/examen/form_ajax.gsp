<%@ page import="teleh.Examen" %>

<div id="create-Examen" class="span" role="main">
<g:form class="form-horizontal" name="frmSave-Examen" action="save">
    <g:hiddenField name="id" value="${examenInstance?.id}"/>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Descripción
            </span>
        </div>

        <div class="controls">
            <g:textArea name="descripcion" cols="40" rows="2" maxlength="1024" class=" required" value="${examenInstance?.descripcion}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    <div class="control-group">
        <div>
            <span class="control-label label label-inverse">
                Propósito
            </span>
        </div>

        <div class="controls">
            <g:textField name="proposito" maxlength="250" class=" required" value="${examenInstance?.proposito}"/>
            <span class="mandatory">*</span>

            <p class="help-block ui-helper-hidden"></p>
        </div>
    </div>

    %{--<div class="control-group">--}%
        %{--<div>--}%
            %{--<span class="control-label label label-inverse">--}%
                %{--Tipo--}%
            %{--</span>--}%
        %{--</div>--}%

        %{--<div class="controls">--}%
            %{--<g:select from="['0': 'Examen', '1': 'Encuesta']" name="tipo" class=" required" value="${fieldValue(bean: examenInstance, field: 'tipo')}" optionKey="key" optionValue="value"/>--}%
            %{--<span class="mandatory">*</span>--}%

            %{--<p class="help-block ui-helper-hidden"></p>--}%
        %{--</div>--}%
    %{--</div>--}%

</g:form>

<script type="text/javascript">
    $("#frmSave-Examen").validate({
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
