
<%@ page import="teleh.TipoIdioma" %>

<div id="create-TipoIdioma" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-TipoIdioma" action="save">
        <g:hiddenField name="id" value="${tipoIdiomaInstance?.id}"/>
                
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Tipo
                </span>
            </div>

            <div class="controls">
                <g:textField name="tipo" maxlength="1" class=" required" value="${tipoIdiomaInstance?.tipo}"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>
                
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Descripcion
                </span>
            </div>

            <div class="controls">
                <g:textField name="descripcion" maxlength="31" class=" required" value="${tipoIdiomaInstance?.descripcion}"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>
                
    </g:form>

<script type="text/javascript">
    $("#frmSave-TipoIdioma").validate({
        errorPlacement : function (error, element) {
            element.parent().find(".help-block").html(error).show();
        },
        success        : function (label) {
            label.parent().hide();
        },
        errorClass     : "label label-important",
        submitHandler  : function(form) {
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
