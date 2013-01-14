<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Evaluaciones</title>
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
        <h3 style="font-size: 25px;margin-bottom: 5px;margin-left: 30px">Convocatoria: ${conv.descripcion}</h3>
    </div>



    <p style="font-size: 16px;text-align: justify;margin-top: 10px">
        Estimados y estimadas hemos revisado su participación en el proceso de selección de profesionales para la modalidad CNH,
        por tanto le solicitamos que rinda la  evaluación en línea en la pagina: <a href="http://www.infa.gob.ec:7073/mies" target="_blank">www.infa.gob.ec:7073/mies</a> ; deberá ingresar con
        la  misma contraseña de su inscripción desde el sábado 12 al 15 de enero de 2013 hasta las 24h00. Posteriormente se
        enviará a sus correos si ha sido favorecido para continuar en el proceso.

        <br/>

        Más información a <a href="mailto:info@infa.gob.ec">info@infa.gob.ec</a>


    </p>

</div>

</body>
</html>