
<%@ page import="teleh.TipoTitulo" %>

<div id="show-tipoTitulo" class="span5" role="main">

    <form class="form-horizontal">
    
    <g:if test="${tipoTituloInstance?.descripcion}">
        <div class="control-group">
            <div>
                <span id="descripcion-label" class="control-label label label-inverse">
                    Descripcion
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="descripcion-label">
                    <g:fieldValue bean="${tipoTituloInstance}" field="descripcion"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    </form>
</div>
