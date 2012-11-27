
<%@ page import="teleh.Titulo" %>

<div id="show-titulo" class="span5" role="main">

    <form class="form-horizontal">
    
    <g:if test="${tituloInstance?.tipoTitulo}">
        <div class="control-group">
            <div>
                <span id="tipoTitulo-label" class="control-label label label-inverse">
                    Tipo Titulo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="tipoTitulo-label">
        %{--<g:link controller="tipoTitulo" action="show" id="${tituloInstance?.tipoTitulo?.id}">--}%
                    ${tituloInstance?.tipoTitulo?.descripcion}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${tituloInstance?.tipo}">
        <div class="control-group">
            <div>
                <span id="tipo-label" class="control-label label label-inverse">
                    Tipo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="tipo-label">
                    <g:fieldValue bean="${tituloInstance}" field="tipo"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${tituloInstance?.descripcion}">
        <div class="control-group">
            <div>
                <span id="descripcion-label" class="control-label label label-inverse">
                    Descripcion
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="descripcion-label">
                    <g:fieldValue bean="${tituloInstance}" field="descripcion"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${tituloInstance?.puntaje}">
        <div class="control-group">
            <div>
                <span id="puntaje-label" class="control-label label label-inverse">
                    Puntaje
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntaje-label">
                    <g:fieldValue bean="${tituloInstance}" field="puntaje"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    </form>
</div>
