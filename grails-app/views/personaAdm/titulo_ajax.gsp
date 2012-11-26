<%@ page import="teleh.Persona" %>

<div id="create-Persona" class="span" role="main">
    <g:uploadForm class="form-horizontal" name="frmSave-Persona" action="uploadTitulo">
        <g:hiddenField name="persona.id" value="${personaInstance?.id}"/>
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Título
                </span>
            </div>

            <div class="controls">
                <input type="file" name="tituloArchivo" class="required"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>
    </g:uploadForm>
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
