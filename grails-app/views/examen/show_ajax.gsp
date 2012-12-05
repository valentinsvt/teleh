<%@ page import="teleh.Examen" %>

<div id="show-examen" class="span5" role="main">

    <form class="form-horizontal">

        <g:if test="${examenInstance?.descripcion}">
            <div class="control-group">
                <div>
                    <span id="descripcion-label" class="control-label label label-inverse">
                        Descripción
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="descripcion-label">
                        <g:fieldValue bean="${examenInstance}" field="descripcion"/>
                    </span>

                </div>
            </div>
        </g:if>

        <g:if test="${examenInstance?.proposito}">
            <div class="control-group">
                <div>
                    <span id="proposito-label" class="control-label label label-inverse">
                        Propósito
                    </span>
                </div>

                <div class="controls">

                    <span aria-labelledby="proposito-label">
                        <g:fieldValue bean="${examenInstance}" field="proposito"/>
                    </span>

                </div>
            </div>
        </g:if>

        <div class="control-group">
            <div>
                <span id="tipo-label" class="control-label label label-inverse">
                    Tipo
                </span>
            </div>

            <div class="controls">

                <span aria-labelledby="tipo-label">
                    ${examenInstance.tipo == 0 ? 'Examen' : 'Encuesta'}
                </span>

            </div>
        </div>

    </form>
</div>
