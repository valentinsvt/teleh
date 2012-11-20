
<%@ page import="teleh.Auxiliar" %>

<div id="show-auxiliar" class="span5" role="main">

    <form class="form-horizontal">
    
    <g:if test="${auxiliarInstance?.usuario}">
        <div class="control-group">
            <div>
                <span id="usuario-label" class="control-label label label-inverse">
                    Usuario
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="usuario-label">
                    <g:fieldValue bean="${auxiliarInstance}" field="usuario"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${auxiliarInstance?.password}">
        <div class="control-group">
            <div>
                <span id="password-label" class="control-label label label-inverse">
                    Password
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="password-label">
                    <g:fieldValue bean="${auxiliarInstance}" field="password"/>
                </span>
        
            </div>
        </div>
    </g:if>
    

    
    </form>
</div>
