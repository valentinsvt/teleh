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






    <p style="margin-top: 16px"> Estimado/a participante:</p>

    <p>Le informamos que después de analizar la información, al encontrarse usted cursando (1ro a 7mo. Semestre) los estudios previos a la
    obtención de su título profesional, no se ha aceptado su participación en esta
    convocatoria, pero estamos ubicando sus datos en una base de datos institucional, para que de darse otra convocatoria,
    será tomada en cuenta su postulación.</p>

    <p>Agradecemos su participación.</p>

</div>

</body>
</html>