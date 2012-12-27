<%@ page import="teleh.PreguntaEntrevista" %>

<div id="show-preguntaEntrevista" class="span5" role="main">

    <form class="form-horizontal">

        <g:if test="${preguntaEntrevistaInstance?.convocatoria}">
            <div class="control-group">
                <div>
                    <span id="convocatoria-label" class="control-label label label-inverse">
                        Convocatoria
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="convocatoria-label">
                        %{--<g:link controller="convocatoria" action="show" id="${preguntaEntrevistaInstance?.convocatoria?.id}">--}%
                        ${preguntaEntrevistaInstance?.convocatoria?.descripcion}
                        %{--</g:link>--}%
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${preguntaEntrevistaInstance?.tipo}">
            <div class="control-group">
                <div>
                    <span id="tipo-label" class="control-label label label-inverse">
                        Tipo
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="tipo-label">
                        <g:fieldValue bean="${preguntaEntrevistaInstance}" field="tipo"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${preguntaEntrevistaInstance?.orden}">
            <div class="control-group">
                <div>
                    <span id="orden-label" class="control-label label label-inverse">
                        Orden
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="orden-label">
                        <g:fieldValue bean="${preguntaEntrevistaInstance}" field="orden"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${preguntaEntrevistaInstance?.numero}">
            <div class="control-group">
                <div>
                    <span id="numero-label" class="control-label label label-inverse">
                        Número
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="numero-label">
                        <g:set var="alfabeto" value="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
                        ${preguntaEntrevistaInstance.tipo == 'Verificacion' ? preguntaEntrevistaInstance.numero + " (" + alfabeto[preguntaEntrevistaInstance.numero - 1] + ")" : preguntaEntrevistaInstance.numero}
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${preguntaEntrevistaInstance?.pregunta}">
            <div class="control-group">
                <div>
                    <span id="pregunta-label" class="control-label label label-inverse">
                        Pregunta
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="pregunta-label">
                        <g:fieldValue bean="${preguntaEntrevistaInstance}" field="pregunta"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${preguntaEntrevistaInstance?.valoracion}">
            <div class="control-group">
                <div>
                    <span id="valoracion-label" class="control-label label label-inverse">
                        Valoracion
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="valoracion-label">
                        <g:fieldValue bean="${preguntaEntrevistaInstance}" field="valoracion"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${preguntaEntrevistaInstance?.positivo}">
            <div class="control-group">
                <div>
                    <span id="positivo-label" class="control-label label label-inverse">
                        Positivo
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="positivo-label">
                        <g:fieldValue bean="${preguntaEntrevistaInstance}" field="positivo"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${preguntaEntrevistaInstance?.negativo}">
            <div class="control-group">
                <div>
                    <span id="negativo-label" class="control-label label label-inverse">
                        Negativo
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="negativo-label">
                        <g:fieldValue bean="${preguntaEntrevistaInstance}" field="negativo"/>
                    </span>

                </div>
            </div>
        </g:if>

    </form>
</div>
