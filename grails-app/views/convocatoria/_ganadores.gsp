<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Felicitaciones</title>
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


    <p style="margin-top: 16px">ESTIMADOS Y ESTIMADAS,</p>

    <p>Felicitaciones usted ha sido seleccionado para ejecutar la modalidad CNH, de acuerdo a su excelente participación!!!
    le solicitamos que revise la pagina web del MIES <a href="www.inclusion.gob.ec">www.inclusion.gob.ec</a>  para verificar su estado,
    además debe acudir a las oficinas de las direcciones distritales del MIES para la verificación de sus documentos de soporte.</p>

</div>

</body>
</html>