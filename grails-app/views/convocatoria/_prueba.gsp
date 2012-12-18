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
        <h3 style="font-size: 25px;margin-bottom: 5px;margin-left: 30px">Convocatoria: ${session.convocatoria.descripcion}</h3>
    </div>

    <p style="font-size: 16px;text-align: justify;margin-top: 20px;">Estimado/a Postulante:</p>

    <p style="font-size: 16px;text-align: justify;margin-top: 10px">
        <br/>
        Si usted ha sido calificada/o y aún no ha dado la prueba, le recordamos que ingrese  <a href="http://www.infa.gob.ec:7073/mies" target="_blank">AQUI</a>  , allí puede ingresar con su número cédula y contraseña (es la misma que se le dio al inicio para su registro) para realizar la prueba on-line. Recuerde que debe ingresar al sistema entre los días 14 al 21 de diciembre de 2012, hasta las 24h00.
        <br/>
        Felicitaciones y siga participando en el proceso.

        <br/>
        Más información a <a href="mailto:info@infa.gob.ec">info@infa.gob.ec</a>


    </p>

</div>

</body>
</html>