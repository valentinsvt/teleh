
<%@ page import="teleh.Auxiliar" %>

<div id="create-Auxiliar" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-Auxiliar" action="save">
        <g:hiddenField name="id" value="${auxiliarInstance?.id}"/>
                
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Usuario
                </span>
            </div>

            <div class="controls">
                <g:textField name="usuario" maxlength="20" class="" value="${auxiliarInstance?.usuario}"/>
                
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>
                
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Password
                </span>
            </div>

            <div class="controls">
                <g:passwordField name="password"   value="${(auxiliarInstance)?'teleh':''}" class="required"></g:passwordField>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>
                

                
    </g:form>

<script type="text/javascript">
    $("#frmSave-Auxiliar").validate({
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
