<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 11/28/12
  Time: 3:33 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Fix cursos</title>
    </head>

    <body>

        <table border="1">
            <thead>
                <tr>
                    <th>Id persona</th>

                    <th>Fecha 1</th>
                    <th>Inst 1</th>
                    <th>Horas 1</th>
                    <th>Nombre 1</th>

                    <th>Fecha 2</th>
                    <th>Inst 2</th>
                    <th>Horas 2</th>
                    <th>Nombre 2</th>

                    <th>Fecha 3</th>
                    <th>Inst 3</th>
                    <th>Horas 3</th>
                    <th>Nombre 3</th>

                    <th>Nueva tabla</th>
                </tr>
            </thead>
            <g:each in="${res}" var="persona">
                <tr>
                    <td>
                        ${persona.id} &nbsp;
                    </td>

                    <td>
                        ${persona.fecha1} &nbsp;
                    </td>
                    <td>
                        ${persona.institucion1} &nbsp;
                    </td>
                    <td>
                        ${persona.horas1} &nbsp;
                    </td>
                    <td>
                        ${persona.nombreCurso1}&nbsp;
                    </td>

                    <td>
                        ${persona.fecha2}&nbsp;
                    </td>
                    <td>
                        ${persona.institucion2}&nbsp;
                    </td>
                    <td>
                        ${persona.horas2}&nbsp;
                    </td>
                    <td>
                        ${persona.nombreCurso2}&nbsp;
                    </td>

                    <td>
                        ${persona.fecha3}&nbsp;
                    </td>
                    <td>
                        ${persona.institucion3}&nbsp;
                    </td>
                    <td>
                        ${persona.horas3}&nbsp;
                    </td>
                    <td>
                        ${persona.nombreCurso3}&nbsp;
                    </td>

                    <td>
                        ${teleh.CursoPersona.countByPersona(persona)}
                    </td>
                </tr>
            </g:each>
        </table>

    </body>
</html>