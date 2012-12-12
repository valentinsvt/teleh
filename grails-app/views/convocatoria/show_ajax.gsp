
<%@ page import="teleh.Convocatoria" %>

<div id="show-convocatoria" class="span5" role="main">

    <form class="form-horizontal">
    
    <g:if test="${convocatoriaInstance?.descripcion}">
        <div class="control-group">
            <div>
                <span id="descripcion-label" class="control-label label label-inverse">
                    Descripcion
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="descripcion-label">
                    <g:fieldValue bean="${convocatoriaInstance}" field="descripcion"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${convocatoriaInstance?.fechaInicio}">
        <div class="control-group">
            <div>
                <span id="fechaInicio-label" class="control-label label label-inverse">
                    Fecha Inicio
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="fechaInicio-label">
                    <g:formatDate date="${convocatoriaInstance?.fechaInicio}" />
                </span>
        
            </div>
        </div>
    </g:if>

    <g:if test="${convocatoriaInstance?.fechaRegistro}">
        <div class="control-group">
            <div>
                <span id="fechaRegistro-label" class="control-label label label-inverse">
                    Fecha Máxima de registro
                </span>
            </div>
            <div class="controls">

                <span aria-labelledby="fechaInicio-label">
                    <g:formatDate date="${convocatoriaInstance?.fechaRegistro}" />
                </span>

            </div>
        </div>
    </g:if>
        <g:if test="${convocatoriaInstance?.fechaEvaluacion}">
            <div class="control-group">
                <div>
                    <span id="fechaEvaluacion-label" class="control-label label label-inverse">
                        Fecha de incio de evaluaciones
                    </span>
                </div>
                <div class="controls">

                    <span aria-labelledby="fechaInicio-label">
                        <g:formatDate date="${convocatoriaInstance?.fechaEvaluacion}" />
                    </span>

                </div>
            </div>
        </g:if>
    
    <g:if test="${convocatoriaInstance?.fechaFin}">
        <div class="control-group">
            <div>
                <span id="fechaFin-label" class="control-label label label-inverse">
                    Fecha Fin
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="fechaFin-label">
                    <g:formatDate date="${convocatoriaInstance?.fechaFin}" />
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${convocatoriaInstance?.textoInicio}">
        <div class="control-group">
            <div>
                <span id="textoInicio-label" class="control-label label label-inverse">
                    Texto Inicio
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="textoInicio-label">
                    <g:fieldValue bean="${convocatoriaInstance}" field="textoInicio"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${convocatoriaInstance?.textoNota}">
        <div class="control-group">
            <div>
                <span id="textoNota-label" class="control-label label label-inverse">
                    Texto Nota
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="textoNota-label">
                    <g:fieldValue bean="${convocatoriaInstance}" field="textoNota"/>
                </span>
        
            </div>
        </div>
    </g:if>
        <g:if test="${convocatoriaInstance?.textoEvaluacion}">
            <div class="control-group">
                <div>
                    <span id="textoEvaluacion-label" class="control-label label label-inverse">
                        Texto Evaluación
                    </span>
                </div>
                <div class="controls">

                    <span aria-labelledby="textoNota-label">
                        <g:fieldValue bean="${convocatoriaInstance}" field="textoEvaluacion"/>
                    </span>

                </div>
            </div>
        </g:if>
    
    </form>
</div>
