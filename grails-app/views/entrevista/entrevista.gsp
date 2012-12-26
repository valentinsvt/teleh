<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/21/12
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
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
                <a href="#" class="btn btn-success btnSave">
                    <i class="icon-save"></i>
                    Guardar
                </a>
            </div>

            <div class="span5 hide">
                <g:form id="${persona.id}" action="saveEntrevista" name="frmEntrevista" method="POST">
                    <g:hiddenField name="total"/>
                </g:form>
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

        <div class="tituloTree">Acciones de verificación durante la entrevista - Actitud de quienes desarrollan la entrevista</div>
        <table class="table table-condensed table-bordered">
            <tr>
                <td>A</td>
                <td style="width: 250px;">Expresión y comunicación</td>
                <td>
                    Observe y valore como positivo si durante la entrevista se ha expresado con respeto, claridad, elocuencia, tranquilidad, firmeza y ha sido fácil comprender lo que indica
                </td>
                <td>
                    <input type="checkbox" name="a" value="0.25"/>
                </td>
            </tr>
            <tr>
                <td>B</td>
                <td>Presentación personal</td>
                <td>
                    Se valora como positivo si se observa aseo personal
                </td>
                <td>
                    <input type="checkbox" name="b" value="0.25"/>
                </td>
            </tr>
            <tr>
                <td>C</td>
                <td>Verificación de título original (SENECYT)</td>
                <td>
                    Se valora con 0.50 puntos a la verificacion que se haga del título universitario
                </td>
                <td>
                    <input type="checkbox" name="c" value="0.5"/>
                </td>
            </tr>
        </table>

        <div class="tituloTree">Preguntas para la entrevista a educadores CNH</div>
        <table class="table table-condensed table-bordered">
            <thead>
                <tr>
                    <th></th>
                    <th>Pregunta</th>
                    <th>Se considera positivo si la respuesta indica</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>
                        ¿Le aburre hacer el mismo trabajo una y otra vez?
                    </td>
                    <td>
                        Se aburre. Le gusta innovar, crear, hacer cosas diferentes con fines determinados
                    </td>
                    <td>
                        <input type="checkbox" name="1" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>
                        ¿Le gusta trabajar con otras personas?
                    </td>
                    <td>
                        Que si le gusta compartir con otras personas, socializar, comunicarse, dialogar, trabajar en equipo
                    </td>
                    <td>
                        <input type="checkbox" name="2" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>
                        ¿Se aburre con los detalles?
                    </td>
                    <td>
                        Que le gusta fijarse en los detalles, es meticuulosa, y perseverante.
                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>
                        ¿Cómo encara usted las tareas que le disgustan?
                    </td>
                    <td>
                        Que lo hace con disposición y tratando de hacerlo bien. Enfrentandolo como un reto.
                    </td>
                    <td>
                        <input type="checkbox" name="4" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>
                        ¿Cuál es su idea sobre el éxito?
                    </td>
                    <td>
                        Que es superación personal, profesional, familiar. Lograr los objetivos propuestos. Ser feliz.
                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>
                        ¿Qué tipo de personas le desagradan?
                    </td>
                    <td>
                        Quienes no tengan una actitud positiva, propositiva, que construya relaciones interpersonales.
                    </td>
                    <td>
                        <input type="checkbox" name="6" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>
                        ¿Cuál es el problema más difícil de comunicación que haya tenido con sus colegas?
                    </td>
                    <td>
                        Que tiene claridad en cuanto a la importancia de la comunicación y menciona acciones que promuevan una comunicación interpersonal.
                    </td>
                    <td>
                        <input type="checkbox" name="7" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>
                        Si pudiera hacer otra cosa. ¿Qué haría?
                    </td>
                    <td>
                        Trabajo con niños, niñas, familias o comunidad
                    </td>
                    <td>
                        <input type="checkbox" name="8" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>9</td>
                    <td>
                        ¿Qué ha aprendido de sus errores?
                    </td>
                    <td>
                        Una enseñanza importante para su vida, si se muestra sincera, sin mayor discurso.
                    </td>
                    <td>
                        <input type="checkbox" name="9" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>11</td>
                    <td>
                        ¿Prefiere trabajar con números o con palabras?
                    </td>
                    <td>
                        Que prefiere trabajar con palabras o directamente con las personas.
                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td>12</td>
                    <td>
                        ¿Qué hace cuando tiene dificultades para resolver un problema?
                    </td>
                    <td>
                        Que solicita apoyo a otras personas, reconociendo sus capacidades, puede indicar que es perseverante o que no huye de los problemas y los enfrenta.
                    </td>
                    <td>
                        <input type="checkbox" name="12" value="0.5"/>
                    </td>
                </tr>
                <tr>
                    <td>13</td>
                    <td>
                        ¿Qué haría si en un momento todas las personas de su departamento se reportaran enfermas?
                    </td>
                    <td>
                        Que cubriría en lo posible las actividades de otras personas dependiendo de la prioridad, que solicitaría ayuda a otras personas o dependencia
                        para cubrir los requerimientos más prioritarios o que haría todo lo posible para atender a los diferentes procesos.
                    </td>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td>17</td>
                    <td>
                        ¿Con qué grupos de edad de niños le gustaría trabajar?
                    </td>
                    <td>
                        Que refiere trabajar con niños y niñas de 0 a 3 años de edad o hasta 5 años.
                    </td>
                    <td>
                        <input type="checkbox" name="17" value="1"/>
                    </td>
                </tr>
                <tr>
                    <td>18</td>
                    <td>
                        ¿Cree estar totalmente preparada para el trabajo con niños y niñas menores de 3 años?
                    </td>
                    <td>
                        Que no está preparada totalmente y que es necesario investigar, capacitarse aunque tenga un título que avala su preparación
                    </td>
                    <td>
                        <input type="checkbox" name="17" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>20</td>
                    <td>
                        ¿Podría trabajar fuera del horario de labores?
                    </td>
                    <td>
                        Que es posible siempre y lo que requeriría es organizarse.
                    </td>
                    <td>
                        <input type="checkbox" name="20" value="0.5"/>
                    </td>
                </tr>
                <tr>
                    <td>21</td>
                    <td>
                        ¿Le gusta trabajar a presión?
                    </td>
                    <td>
                        Que si le gusta o que puede manejar varias acciones, actividades y que el resultado es positivo.
                    </td>
                    <td>
                        <input type="checkbox" name="21" value="1"/>
                    </td>
                </tr>
                <tr>
                    <td>22</td>
                    <td>
                        ¿Le gusta trabajar con familias? ¿lo ha hecho? ¿de qué manera?
                    </td>
                    <td>
                        Si le gusta, ha trabajado con ellas promoviendo su desarrollo como personas, profesionales, en los roles de familia, sobre derechos,
                        o en temas o procesos que denoten superación.
                    </td>
                    <td>
                        <input type="checkbox" name="22" value="1"/>
                    </td>
                </tr>
                <tr>
                    <td>23</td>
                    <td>
                        ¿Le gusta trabajar con actores comunitarios? ¿lo ha hecho? ¿de qué manera?
                    </td>
                    <td>
                        Si le gusta, ha trabajado con ellos promoviendo su desarrollo como personas, profesionales o en su rol dentro de la comunidad,
                        trabajando sobre derechos, o en temas o procesos que denoten superación de la comunidad.
                    </td>
                    <td>
                        <input type="checkbox" name="23" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>24</td>
                    <td>
                        ¿Ha realizado actividades de coordinación intersectorial?
                    </td>
                    <td>
                        Que si lo ha hecho, puede haber participado o generado esta articulación.
                    </td>
                    <td>
                        <input type="checkbox" name="24" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>26</td>
                    <td>
                        ¿Tendría algún inconveniente en trabajar con grupos de personas adultas?
                    </td>
                    <td>
                        Que no tiene ningún problema. Que le gusta, que ha tenido experiencia
                    </td>
                    <td>
                        <input type="checkbox" name="26" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>27</td>
                    <td>
                        Si una persona adulta tiene dificultad en comprender el mensaje que usted le indica, ¿qué hace?
                    </td>
                    <td>
                        Busca otras formas de explicarle ya que el objetivo es que la otra persona comprenda. No se da por vencida
                    </td>
                    <td>
                        <input type="checkbox" name="27" value="0.25"/>
                    </td>
                </tr>
                <tr>
                    <td>28</td>
                    <td>
                        El trabajo es en los sectores, requiere trasladarse de una vivienda a otra, ¿requeriría usted transporte para realizar el trabajo?
                    </td>
                    <td>
                        Que no requeriría ya que le gusta caminar.
                    </td>
                    <td>
                        <input type="checkbox" name="28" value="0.5"/>
                    </td>
                </tr>
                <tr>
                    <td>29</td>
                    <td>
                        ¿Usted estaría dispuesta a caminar lo que se necesite aunque los estados del tiempo sean cambiantes y las distancias sean considerables?
                    </td>
                    <td>
                        Que no habría ningún problema ya que le gusta caminar y los estados del clima no impedirían ejecutar su trabajo
                    </td>
                    <td>
                        <input type="checkbox" name="29" value="1"/>
                    </td>
                </tr>
                <tr>
                    <td>30</td>
                    <td>
                        Tiene algún inconveniente en su salud que le impida caminar largas distancias o permanecer bajo los estados cambiantes del clima?
                    </td>
                    <td>
                        Que no tiene ningún problema de salud.
                    </td>
                    <td>
                        <input type="checkbox" name="29" value="0.5"/>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="row btn-group" role="navigation" style="margin-top: 15px; margin-bottom: 15px;">
            <div class="span5">
                <a href="#" class="btn btn-success btnSave">
                    <i class="icon-save"></i>
                    Guardar
                </a>
            </div>
        </div>

        <script type="text/javascript">
            function check() {
                var total = 0;
                $("input[type=checkbox]").each(function () {
                    if ($(this).is(":checked")) {
                        total += parseFloat($(this).val());
                    }
                });
                $("#total").val(total);
            }
            $(function () {
                $("input").click(function () {
                    check();
                });

                $(".btnSave").click(function () {
                    $("#frmEntrevista").submit();
                });

            });
        </script>

    </body>
</html>