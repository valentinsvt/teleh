<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.6.2.min.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.16.custom.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/', file: 'funciones.js')}"></script>
        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/js/countdown', file: 'jquery.countdown.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/js/countdown', file: 'jquery.countdown.css')}"/>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/cupertino', file: 'jquery-ui-1.8.16.custom.css')}"/>
        <title>MIES - Examen ${exa}</title>

    </head>

    <body>

        <div id="texto_count"
             style="width: 160px;height: 30px;position: absolute;top:5px;left: 45px;font-size: 12px;line-height: 15px;">Tiempo restante para rendir su examen</div>

        <div id="countdown"
             style="width: 150px;height: 30px;position: absolute;top:3px;left: 230px;border: none;background: none"></div>

        <div id="countdown2"
             style="width: 70px;height: 30px;position: absolute;top:3px;left: 120px;border: none;display: none"></div>
        <g:form action="fin" class="afuera">
            <input type="hidden" name="flag" value="1">
        </g:form>

        <iframe style="width: 730px;height: 800px;border:none;margin: 15px;margin-top: 30px;"
                src="${createLink(controller: "evaluacion", action: "examen")}" id="frm">
        </iframe>
        
        <g:set var="fecha" value="${new Date()}" />
        
        <script type="text/javascript">

            var year = ${session.fin.format("yyyy")};
            var month = ${session.fin.format("MM")}-1;
            var day = ${session.fin.format("dd")};
            var hours = ${session.fin.format("HH")};
            var minutes = ${session.fin.format("mm")};
            var seconds = ${session.fin.format("ss")};

            var year0 = ${fecha.format("yyyy")};
            var month0 = ${fecha.format("MM")}-1;
            var day0 = ${fecha.format("dd")};
            var hours0 = ${fecha.format("HH")};
            var minutes0 = ${fecha.format("mm")};
            var seconds0 = ${fecha.format("ss")};

            var ini = new Date(year0, month0, day0, hours0, minutes0, seconds0, 0);
            var fin = new Date(year, month, day, hours, minutes, seconds, 0);

            function getini() {
                return ini;
            }

            function alerta() {
                $("#texto_count").css("color", "red").show("pulsate");
                $("#countdown").css("color", "red");
            }

            try {
                var cambio = new Date(year, month, day, hours, minutes - 5, seconds, 0);
                $('#countdown2').countdown({serverSync:getini, until:cambio, compact:true, format:'MS', description:'', onExpiry:alerta});
            } catch (e) {

            }

            $('#countdown').countdown({serverSync:getini, until:fin, compact:true, format:'MS', description:'', onExpiry:terminarExamen});
            function terminarExamen() {
                $(".afuera").submit();
            }

        </script>
    </body>
</html>