<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <title>
        <g:layoutTitle default="${g.message(code: 'default.app.name', default: 'Películas')}"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <script src="${resource(dir: 'js/jquery/js', file: 'jquery-1.8.2.js')}"></script>
    <script src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.9.1.custom.min.js')}"></script>

    <!-- Le styles -->
    <link href="${resource(dir: 'css/bootstrap/css', file: 'bootstrap.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css/bootstrap/css', file: 'bootstrap-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'js/jquery/css/twitBoot', file: 'jquery-ui-1.9.1.custom.min.css')}" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="${resource(dir: 'images/ico', file: 'teleh_16.png')}">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${resource(dir: 'images/ico', file: 'teleh_144.png')}">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${resource(dir: 'images/ico', file: 'teleh_114.png')}">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${resource(dir: 'images/ico', file: 'teleh_72.png')}">
    <link rel="apple-touch-icon-precomposed" href="${resource(dir: 'images/ico', file: 'teleh_57.png')}">
    <link href='${resource(dir:"font/open",file: "stylesheet.css" )}' rel='stylesheet' type='text/css'>
    <link href='${resource(dir:"font/tulpen",file: "stylesheet.css" )}' rel='stylesheet' type='text/css'>
    <g:layoutHead/>
    <script type="text/javascript">
        var url = "${resource(dir:'images', file:'spinnerLogin_24.gif')}";
        var spinnerLogin = $("<img style='margin-left:15px;' src='" + url + "' alt='Cargando...'/>");
        var url1 = "${resource(dir:'images', file:'spinner_24.gif')}";
        var spinner= $("<img style='margin-left:15px;' src='" + url1 + "' alt='Cargando...'/>");
        var url2 = "${resource(dir:'images', file:'spinner.gif')}";
        var spinner2 = $("<img style='margin-left:15px;' src='" + url + "' alt='Cargando...'/>");
    </script>
</head>

<body style="background: none">

<div style="width: 1100px;margin-top: 50px;margin-left: 30px;">
    <g:layoutBody/>
</div>


<!-- Le javascript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="${resource(dir: 'css/bootstrap/js', file: 'bootstrap.js')}"></script>
</body>
</html>
