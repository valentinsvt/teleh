
<%@ page import="teleh.Pregunta" %>

<div id="show-pregunta" class="span5" role="main">

    <form class="form-horizontal">
    
    <g:if test="${preguntaInstance?.examen}">
        <div class="control-group">
            <div>
                <span id="examen-label" class="control-label label label-inverse">
                    Examen
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="examen-label">
        %{--<g:link controller="examen" action="show" id="${preguntaInstance?.examen?.id}">--}%
                    ${preguntaInstance?.examen?.encodeAsHTML()}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${preguntaInstance?.orden}">
        <div class="control-group">
            <div>
                <span id="orden-label" class="control-label label label-inverse">
                    Orden
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="orden-label">
                    <g:fieldValue bean="${preguntaInstance}" field="orden"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${preguntaInstance?.pregunta}">
        <div class="control-group">
            <div>
                <span id="pregunta-label" class="control-label label label-inverse">
                    Pregunta
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="pregunta-label">
                    <g:fieldValue bean="${preguntaInstance}" field="pregunta"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${preguntaInstance?.respuestas}">
        <div class="control-group">
            <div>
                <span id="respuestas-label" class="control-label label label-inverse">
                    Respuestas
                </span>
            </div>
            <div class="controls">
        
                <g:each in="${preguntaInstance.respuestas}" var="r">
                    <span aria-labelledby="respuestas-label">
            %{--<g:link controller="respuesta" action="show" id="${r.id}">--}%
                        ${r?.encodeAsHTML()}
            %{--</g:link>--}%
                    </span>
                </g:each>
        
            </div>
        </div>
    </g:if>
    
    </form>
</div>
