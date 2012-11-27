
<%@ page import="teleh.Titulo" %>

<div id="create-Titulo" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-Titulo" action="save">
        <g:hiddenField name="id" value="${tituloInstance?.id}"/>
                
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Tipo Titulo
                </span>
            </div>

            <div class="controls">
                <g:select id="tipoTitulo" name="tipoTitulo.id" from="${teleh.TipoTitulo.list()}" optionKey="id" optionValue="descripcion" class="many-to-one  required" value="${tituloInstance?.tipoTitulo?.id}"/>
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
                <g:select name="tipo" from="${tituloInstance.constraints.tipo.inList}" class=" required" value="${tituloInstance?.tipo}" valueMessagePrefix="titulo.tipo"/>
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
                <g:textField name="descripcion" maxlength="127" class=" required" value="${tituloInstance?.descripcion}"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>
                
        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Puntaje
                </span>
            </div>

            <div class="controls">
                <g:field type="number" name="puntaje" class=" required" value="${fieldValue(bean: tituloInstance, field: 'puntaje')}"/>
                <span class="mandatory">*</span>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>
                
    </g:form>

<script type="text/javascript">
    $("#frmSave-Titulo").validate({
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
