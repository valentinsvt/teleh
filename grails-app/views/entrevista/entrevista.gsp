<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/21/12
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.rmi.server.ObjID" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Entrevista
        </title>
        <style type="text/css">
        td {
            vertical-align : middle !important;
        }
        </style>

    </head>

    <body>

        <div class="row btn-group" role="navigation">
            <div class="span5">
                <g:if test="${!readOnly}">
                    <a href="#" class="btn btn-success btnSave">
                        <i class="icon-save"></i>
                        Guardar
                    </a>
                </g:if>
                <g:link action="list" class="btn">
                    <i class="icon-caret-left"></i>
                    Regresar
                </g:link>
            </div>

        </div>

        <div class="well" style="margin-top: 15px;">
            <div class="row">
                <div class="span1 label">Nombres</div>

                <div class="span4">${persona.nombre} ${persona.apellido}</div>

                <div class="span1 label">Cédula</div>

                <div class="span4">${persona.cedula}</div>
            </div>
        </div>
        <g:form id="${persona.id}" action="saveEntrevista" name="frmEntrevista" method="POST">
            <div class="tituloTree">Acciones de verificación durante la entrevista - Actitud de quienes desarrollan la entrevista</div>
            <table class="table table-condensed table-bordered table-striped table-hover">
                <g:set var="alfabeto" value="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
                <g:each in="${respuestasPersona.findAll { it.preguntaEntrevista.tipo == 'Valoracion' }}" var="pregunta">
                    <tr>
                        <td>
                            ${alfabeto[pregunta.preguntaEntrevista.numero - 1]}
                        </td>
                        <td style="width: 250px;">
                            ${pregunta.preguntaEntrevista.pregunta}
                        </td>
                        <td>
                            ${pregunta.preguntaEntrevista.valoracion}
                        </td>
                        <td>
                            <g:if test="${readOnly}">
                                ${pregunta.valor > 0 ? "<i class='icon-check icon-large'></i>" : ""}
                            </g:if>
                            <g:else>
                                <input type="checkbox" name="preg_${pregunta.id}" value="${pregunta.preguntaEntrevista.positivo}" ${pregunta.valor > 0 ? "checked" : ""}/>
                            </g:else>
                        </td>
                    </tr>
                </g:each>
            </table>

            <div class="tituloTree">Preguntas para la entrevista a educadores CNH</div>
            <table class="table table-condensed table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th></th>
                        <th>Pregunta</th>
                        <th>Se considera positivo si la respuesta indica</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${respuestasPersona.findAll { it.preguntaEntrevista.tipo =~ 'Entrevista' }}" var="pregunta">
                        <tr>
                            <td>
                                ${pregunta.preguntaEntrevista.numero}
                            </td>
                            <td style="width: 250px;">
                                ${pregunta.preguntaEntrevista.pregunta}
                            </td>
                            <td>
                                ${pregunta.preguntaEntrevista.valoracion}
                            </td>
                            <td>
                                <g:if test="${pregunta.preguntaEntrevista.tipo.contains('con')}">
                                    <g:if test="${readOnly}">
                                        ${pregunta.valor > 0 ? "<i class='icon-check icon-large'></i>" : ""}
                                    </g:if>
                                    <g:else>
                                        <input type="checkbox" name="preg_${pregunta.id}" value="${pregunta.preguntaEntrevista.positivo}" ${pregunta.valor > 0 ? "checked" : ""}/>
                                    </g:else>
                                </g:if>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </g:form>

        <div class="row btn-group" role="navigation" style="margin-top: 15px; margin-bottom: 15px;">
            <div class="span5">
                <a href="#" class="btn btn-success btnSave">
                    <i class="icon-save"></i>
                    Guardar
                </a>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".btnSave").click(function () {
                    $("#frmEntrevista").submit();
                });

            });
        </script>

    </body>
</html>