<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.6.2.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.16.custom.min.js')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js/', file: 'funciones.js')}"></script>

    <link rel="stylesheet"
          href="${resource(dir: 'js/jquery/css/cupertino', file: 'jquery-ui-1.8.16.custom.css')}"/>
    <title>Gracias por su colaboración</title>
</head>
<body>

<div style="float: left;width: 750;">
    <div style="font-size: 15px;" id="dialogo">
        ${texto}<br><br><br>
        %{--Su nota es : ${nota}--}%
        ${nota}
    </div>

</div>

<script type="text/javascript">
    $("#dialogo").dialog({
        width:500,
        height:550,
        position:[45,15],
        autoOpen:true,
        modal:false,
        title:"El examen ha concluido. <br/>Gracias por su colaboración",
        resizable:false,
        draggable:false,
        buttons:{
            "Salir":function(){

                window.parent.parent.parent.location.href="${createLink(controller: 'login',action: 'login')}"
                window.parent.parent.close()
                %{--window.parent.location.href="${createLink(controller: 'login',action: 'login')}"--}%

            }
        },
        open:function (event, ui) {
            $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
        }
    });
    $(window.parent.document.getElementById("countdown")).remove()
    $(window.parent.document.getElementById("texto_count")).remove()
    $("#boton").button()
</script>
</body>
</html>
