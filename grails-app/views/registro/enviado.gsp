<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="sinMenu"/>
        <title>Registro</title>

    </head>

    <body>
        <div class="container ui-corner-all">

            <div class="page-header" style="text-align: center; margin-bottom: 40px;">
                <h3 style="font-size: 22px; margin:20px;">Convocatoria: ${session.convocatoria.descripcion}</h3>
            </div>

            <p style="font-size: 16px;text-align: justify">

                <span style="font-size: large; font-weight:bold;">La contraseña se ha enviado a su correo</span><br/><br/>

                Gracias por inscribirse, Usted ha completado el primer paso del registro. El sistema le enviará un correo
                electrónico automático con su contraseña personalizada para seguir con el proceso de registro.
                Si no recibe el correo electrónico generado automáticamente, por favor repita este paso e ingrese
                nuevamente sus datos personales. Si requiere de ayuda o más información por favor escríbanos a
                <a href="mailto:valentinsvt@gmail.com">mail@aqui.com</a> y le asistiremos lo antes posible.
            </p>

            <div style="text-align: center; margin-top: 40px;">
                <g:link action="postulante" controller="login" class="aceptar btn btn-primary" style="margin-top: 25px;">Ingresar al sistema</g:link>
            </div>
        </div>
        <script type="text/javascript">

        </script>
    </body>
</html>