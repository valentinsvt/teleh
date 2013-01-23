<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        comunicado
    </title>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    <style type="text/css">
    .red {
        color : #be1400;
    }
    </style>
</head>

<body>


<div id="list-Persona" class="span12" role="main" style="margin-top: 10px;">
    <g:uploadForm class="form-horizontal" name="frmSave-Persona" action="enviarComunicadoGanadores">

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Archivo csv
                </span>
            </div>

            <div class="controls">
                <input type="file" name="tituloArchivo" class="required"/>
                %{--<span class="mandatory">*</span>--}%

                %{--<p class="help-block ui-helper-hidden"></p>--}%
            </div>

        </div>
        <div>
            <a href="#" class="btn btn-success btn-save"><i class="icon-save"></i> Guardar</a>
        </div>
    </g:uploadForm>

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
    });

</script>

</body>
</html>