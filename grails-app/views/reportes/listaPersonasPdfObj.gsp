<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 11/27/12
  Time: 12:34 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Lista de personas</title>
        <style type="text/css">
        @page {
            size   : 21cm 29.7cm ;  /*width height */
            margin : 1.5cm;
        }

        html {
            font-family : Verdana, Arial, sans-serif;
            font-size   : 9px;
        }

        .hoja {
            width      : 17.5cm;
            /*background : #ffebcd;*/
            /*border     : solid 1px black;*/
            min-height : 200px;
        }

        h1, h2, h3 {
            text-align : center;
        }

        h1 {
            font-size : 14px;
        }

        table {
            border-collapse : collapse;
            width           : 100%;
        }

        th, td {
            vertical-align : middle;
        }

        th {
            background : #bbb;
            font-size  : 10px;
        }

        td {
            font-size : 9px;
        }

        .even {
            background : #ddd;
        }

        .odd {
            background : #efefef;
        }

        .right {
            float : right;
        }
        </style>
    </head>

    <body>
        <div class="hoja">

            <h1>Lista de personas</h1>

            <h3>
                ${params.label}
            </h3>
            <h5>
                <b>Fecha de consulta:</b> <g:formatDate date="${new Date()}" format="dd-MM-yyyy"/>
            </h5>


            <table border="1">
                <thead>
                    <tr>
                        <th>Vive en</th>
                        <th>Cantón</th>
                        <th>Formación</th>
                        <th>Cédula</th>
                        <th>Nombres</th>
                        <th>Género</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody class="paginate">
                    <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                        <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                            <td>
                                ${fieldValue(bean: personaInstance, field: "provincia")}
                            </td>
                            <td>
                                ${fieldValue(bean: personaInstance, field: "canton")}
                            </td>
                            <td>
                                ${personaInstance.titulo?.descripcion}
                            </td>
                            <td>
                                ${personaInstance.cedula}
                            </td>
                            <td>
                                ${personaInstance.apellido}, ${personaInstance.nombre}
                            </td>
                            <td>
                                ${personaInstance.sexo?.capitalize()}
                            </td>
                            <td>
                                ${personaInstance?.estado?.descripcion}
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>