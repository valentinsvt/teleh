<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.8.0.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.9.1.custom.min.js')}"></script>

    <script type="text/javascript" src="${resource(dir: 'js/', file: 'functions.js')}"></script>

    <link rel="stylesheet"
          href="${resource(dir: 'js/jquery/css/twit', file: 'jquery-ui-1.8.23.custom.css')}"/>
    <title>MIES - Examen ${exa}</title>
</head>
<body>

<div style="float: left;width: 710;">
    <g:if test="${pregunta}">
        <div id="respuestas" style="font-size: 15px;height: 600px;overflow:auto">
            <g:form class="examen" controller="evaluacion" action="siguiente">
                <input type="hidden" name="preg" value="${pregunta.id}">
                <div style="font-size: 15px;margin-bottom: 20px;" id="pregunta">
                    ${pregunta.pregunta}
                </div>
                <g:each in="${respuestas}" var="resp">
                    <div style="width:90%;min-height: 25px;margin-bottom: 10px;line-height: 25px;margin-left: 20px;;border-bottom: 1px #2779AA dotted">
                        <input type="radio" name="resp" class="radios" style="margin-right: 5px;" value="${resp.id}">${resp.respuesta}
                    </div>
                </g:each>

            </g:form>
        </div>

    </g:if>
    <g:else>
        Fin del examen
    </g:else>
</div>

<script type="text/javascript">

    $("#respuestas").dialog({
        width:710,
        height:700,
        position:[45,15],
        autoOpen:true,
        modal:false,
        title:" Pregunta #${pregunta.orden}",
        resizable:false,
        draggable:false,
        buttons:{
            "Siguiente":function(){
                var band = false
                $.each($(".radios"),function(){
                    if($(this).attr("checked")=="checked")
                        band=true

                });
                if(!band){
                    alert("Seleccione una respuesta")
                }else{
                    $(".examen").submit()
                }
            }
        },
        open:function (event, ui) {
            $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
        }
    });
    $("#boton").button()
</script>
</body>
</html>