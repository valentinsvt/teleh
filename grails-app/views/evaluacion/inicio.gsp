<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.8.0.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.9.1.custom.min.js')}"></script>

        <script type="text/javascript" src="${resource(dir: 'js/', file: 'functions.js')}"></script>

        <link rel="stylesheet"
              href="${resource(dir: 'js/jquery/css/twit', file: 'jquery-ui-1.8.23.custom.css')}"/>
        <title>Gracias por su colaboración</title>
    </head>

    <body>

    <div class="ui-widget-content ui-corner-all" style="width: 800px; height: 550px;">

    <div style="">
        <img  src="${resource(dir: 'images', file: 'logo.jpg')}" alt="mies" width="100%" />
    </div>

        <div style="float: left;width: 750;">
            <div id="dialogo" style=" font-size: 15px; width: 620px; height: 620px; padding-left: 30px; padding-top: 30px;">
                <div id="mens" style="">
                   <p> Bienvenido <b> ${persona}</b></p>
                    %{--Dispone de 40 minutos para rendir su examen. .--}%
                    <p>${conv.textoEvaluacion}</p></br>
                    Haga click <a href="#" id="emp">AQUI</a> para iniciar
                </div>
                <a href="${createLink(action: 'postulante', controller: 'login')}" style="display: none;margin-top: 10px"
                   id="salir">Salir</a>
            </div>

        </div>
    </div>

        <script type="text/javascript">
/*
            $("#dialogo")({
                width:600,
                height:600,
                position:[150, 15],
                autoOpen:true,
                modal:false,
                title:"Ministerio de Inclusión Económica y Social",
                resizable:false,
                draggable:false,
                open:function (event, ui) {
                    $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
                }
            });
*/
            $("#emp").button().click(function () {
                $("#mens").html("No cierre la ventana de evaluación hasta que haya concluido");
                $("#salir").button().show();
                %{--var child = window.open('${createLink(controller:"evaluacion",action:"index")}', 'Mies_-_Sistema_de_evaluación', 'width=850,height=800,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');--}%

                var child = window.open('${createLink(controller:"evaluacion",action:"index")}', 'Mies', 'width=850,height=800,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');

                if (child.opener == null)
                    child.opener = self;
                window.toolbar.visible = false;
                window.menubar.visible = false;
            });
        </script>
    </body>
</html>
