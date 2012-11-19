
<%@ page import="teleh.TipoIdioma" %>

<div id="show-tipoIdioma" class="span5" role="main">

    <form class="form-horizontal">
    
    <g:if test="${tipoIdiomaInstance?.tipo}">
        <div class="control-group">
            <div>
                <span id="tipo-label" class="control-label label label-inverse">
                    Tipo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="tipo-label">
                    <g:fieldValue bean="${tipoIdiomaInstance}" field="tipo"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${tipoIdiomaInstance?.descripcion}">
        <div class="control-group">
            <div>
                <span id="descripcion-label" class="control-label label label-inverse">
                    Descripcion
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="descripcion-label">
                    <g:fieldValue bean="${tipoIdiomaInstance}" field="descripcion"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    </form>
</div>
