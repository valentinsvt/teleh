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
        <h3 style="font-size: 25px;margin-bottom: 5px;margin-left: 30px">Convocatoria: ${session.convocatoria.descripcion}</h3>
    </div>

    <p style="font-size: 16px;text-align: justify;margin-top: 20px;">Estimado/a Postulante:</p>

    <p style="font-size: 16px;text-align: justify;margin-top: 10px">

        %{--Para continuar con el proceso por favor acceda nuevamente a la página web del Ministerio de Salud Pública www.msp.gob.ec en el espacio de: “Concursos Interno para Servidores con Contratos por 4 Años”. Presione “Ingresar al sistema”.--}%
        Para continuar con el proceso por favor ingrese <a href="http://127.0.0.1:8080/login/postulante" target="_blank">AQUI</a> con la siguiente información.
        <br/>
        <br/>
        <b>USUARIO:</b> ${prsn.cedula}<br/>

        <b>CONTRASEÑA:</b> ${pin}<br/>

        <br/>
        Recuerde que su registro todavía está incompleto. Más información a <a href="mailto:info@infa.gob.ec">info@infa.gob.ec</a>


    </p>

</div>

</body>
</html>