<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Registro</title>
    <style type="text/css">
    .control-group{
        clear: both;margin: 5px;height: 35px
    }
    .control-label{
        width: 150px;float: left;height: 30px;line-height: 30px;text-align: right;font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 13px;font-weight: bold
    }
    .controls{
        width: 400px;float: left;margin-left: 10px;height: 30px;line-height: 30px;
    }
    input{
        height: 20px;width: 200px;
    }
    .page-header{
        border-bottom: 1px #aaa solid;margin-bottom: 25px;
    }
    .required {
        border-right:  red solid 2px;
    }
    .fotter{
        position: absolute;
        bottom: 5px;
        height: 50px;
        width: 580px
    }
    </style>
</head>
<body>
<div class="container ui-corner-all" style="width: 600px;min-height: 600px;float: left;margin: 20px;border: 1px #aaa solid;padding: 10px;position: relative;" >

    <div class="page-header" style="">
        <h3 style="font-size: 25px;margin-bottom: 5px;margin-left: 30px">Concurso Interno de Méritos y Oposición</h3>
    </div>

    <p style="font-size: 16px;text-align: justify;margin-top: 20px;">Estimado/a Postulante:</p>

    <p style="font-size: 16px;text-align: justify;margin-top: 10px">

        Usted ha solicitado nuevamente su contraseña para rendir su evaluación de conocimientos técnicos en línea de acuerdo a lo establecido en el Acuerdo Ministerial N° MRL-2011-00142.<br/>

        Debe descargarse de la página web www.msp.gob.ec botón “Concursos Internos de Méritos y Oposición” el instructivo para rendir la evaluación<br/>

        Para ingresar a rendir su evaluación de click donde dice: “Rendir Evaluación de Conocimientos Técnicos” con el siguiente usuario y clave:<br/><br/>

        USUARIO: ${usuario}<br/>

        CLAVE: ${clave}<br/><br/>

        Podrá rendir la evaluación hasta 3 días después de reciba la convocatoria.<br/>

        Por favor quede atento a su correo electrónico para conocer las siguientes etapas del proceso.<br/>

        Saludos Cordiales,<br/>

        Talento Humano<br/>

    </p>

</div>

</body>
</html>