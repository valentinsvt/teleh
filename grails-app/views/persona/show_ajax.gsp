
<%@ page import="teleh.Persona" %>

<div id="show-persona" class="span5" role="main">

    <form class="form-horizontal">
    
    <g:if test="${personaInstance?.convocatoria}">
        <div class="control-group">
            <div>
                <span id="convocatoria-label" class="control-label label label-inverse">
                    Convocatoria
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="convocatoria-label">
        %{--<g:link controller="convocatoria" action="show" id="${personaInstance?.convocatoria?.id}">--}%
                    ${personaInstance?.convocatoria?.encodeAsHTML()}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.provincia}">
        <div class="control-group">
            <div>
                <span id="provincia-label" class="control-label label label-inverse">
                    Provincia
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="provincia-label">
        %{--<g:link controller="provincia" action="show" id="${personaInstance?.provincia?.id}">--}%
                    ${personaInstance?.provincia?.encodeAsHTML()}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.canton}">
        <div class="control-group">
            <div>
                <span id="canton-label" class="control-label label label-inverse">
                    Canton
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="canton-label">
        %{--<g:link controller="canton" action="show" id="${personaInstance?.canton?.id}">--}%
                    ${personaInstance?.canton?.encodeAsHTML()}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.parroquia}">
        <div class="control-group">
            <div>
                <span id="parroquia-label" class="control-label label label-inverse">
                    Parroquia
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="parroquia-label">
        %{--<g:link controller="parroquia" action="show" id="${personaInstance?.parroquia?.id}">--}%
                    ${personaInstance?.parroquia?.encodeAsHTML()}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.titulo}">
        <div class="control-group">
            <div>
                <span id="titulo-label" class="control-label label label-inverse">
                    Titulo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="titulo-label">
        %{--<g:link controller="titulo" action="show" id="${personaInstance?.titulo?.id}">--}%
                    ${personaInstance?.titulo?.encodeAsHTML()}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.estado}">
        <div class="control-group">
            <div>
                <span id="estado-label" class="control-label label label-inverse">
                    Estado
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="estado-label">
        %{--<g:link controller="estado" action="show" id="${personaInstance?.estado?.id}">--}%
                    ${personaInstance?.estado?.encodeAsHTML()}
        %{--</g:link>--}%
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.dateCreated}">
        <div class="control-group">
            <div>
                <span id="dateCreated-label" class="control-label label label-inverse">
                    Date Created
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="dateCreated-label">
                    <g:formatDate date="${personaInstance?.dateCreated}" />
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.apellido}">
        <div class="control-group">
            <div>
                <span id="apellido-label" class="control-label label label-inverse">
                    Apellido
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="apellido-label">
                    <g:fieldValue bean="${personaInstance}" field="apellido"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.nombre}">
        <div class="control-group">
            <div>
                <span id="nombre-label" class="control-label label label-inverse">
                    Nombre
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="nombre-label">
                    <g:fieldValue bean="${personaInstance}" field="nombre"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.cedula}">
        <div class="control-group">
            <div>
                <span id="cedula-label" class="control-label label label-inverse">
                    Cedula
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="cedula-label">
                    <g:fieldValue bean="${personaInstance}" field="cedula"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.fechaNacimiento}">
        <div class="control-group">
            <div>
                <span id="fechaNacimiento-label" class="control-label label label-inverse">
                    Fecha Nacimiento
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="fechaNacimiento-label">
                    <g:formatDate date="${personaInstance?.fechaNacimiento}" />
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.sexo}">
        <div class="control-group">
            <div>
                <span id="sexo-label" class="control-label label label-inverse">
                    Sexo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="sexo-label">
                    <g:fieldValue bean="${personaInstance}" field="sexo"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.email}">
        <div class="control-group">
            <div>
                <span id="email-label" class="control-label label label-inverse">
                    Email
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="email-label">
                    <g:fieldValue bean="${personaInstance}" field="email"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.etnia}">
        <div class="control-group">
            <div>
                <span id="etnia-label" class="control-label label label-inverse">
                    Etnia
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="etnia-label">
                    <g:fieldValue bean="${personaInstance}" field="etnia"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.promotorCNH}">
        <div class="control-group">
            <div>
                <span id="promotorCNH-label" class="control-label label label-inverse">
                    Promotor CNH
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="promotorCNH-label">
                    <g:fieldValue bean="${personaInstance}" field="promotorCNH"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.lenguaNativa}">
        <div class="control-group">
            <div>
                <span id="lenguaNativa-label" class="control-label label label-inverse">
                    Lengua Nativa
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="lenguaNativa-label">
                    <g:fieldValue bean="${personaInstance}" field="lenguaNativa"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.lenguaExtrangera}">
        <div class="control-group">
            <div>
                <span id="lenguaExtrangera-label" class="control-label label label-inverse">
                    Lengua Extrangera
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="lenguaExtrangera-label">
                    <g:fieldValue bean="${personaInstance}" field="lenguaExtrangera"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.certificadoNativo}">
        <div class="control-group">
            <div>
                <span id="certificadoNativo-label" class="control-label label label-inverse">
                    Certificado Nativo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="certificadoNativo-label">
                    <g:fieldValue bean="${personaInstance}" field="certificadoNativo"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.certificadoExtrangero}">
        <div class="control-group">
            <div>
                <span id="certificadoExtrangero-label" class="control-label label label-inverse">
                    Certificado Extrangero
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="certificadoExtrangero-label">
                    <g:fieldValue bean="${personaInstance}" field="certificadoExtrangero"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.habla50Nativa}">
        <div class="control-group">
            <div>
                <span id="habla50Nativa-label" class="control-label label label-inverse">
                    Habla50 Nativa
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="habla50Nativa-label">
                    <g:fieldValue bean="${personaInstance}" field="habla50Nativa"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.habla50Extrangera}">
        <div class="control-group">
            <div>
                <span id="habla50Extrangera-label" class="control-label label label-inverse">
                    Habla50 Extrangera
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="habla50Extrangera-label">
                    <g:fieldValue bean="${personaInstance}" field="habla50Extrangera"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.direccion}">
        <div class="control-group">
            <div>
                <span id="direccion-label" class="control-label label label-inverse">
                    Direccion
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="direccion-label">
                    <g:fieldValue bean="${personaInstance}" field="direccion"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.telefonoFijo}">
        <div class="control-group">
            <div>
                <span id="telefonoFijo-label" class="control-label label label-inverse">
                    Telefono Fijo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="telefonoFijo-label">
                    <g:fieldValue bean="${personaInstance}" field="telefonoFijo"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.telefonoCelular}">
        <div class="control-group">
            <div>
                <span id="telefonoCelular-label" class="control-label label label-inverse">
                    Telefono Celular
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="telefonoCelular-label">
                    <g:fieldValue bean="${personaInstance}" field="telefonoCelular"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.nombreComunidad}">
        <div class="control-group">
            <div>
                <span id="nombreComunidad-label" class="control-label label label-inverse">
                    Nombre Comunidad
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="nombreComunidad-label">
                    <g:fieldValue bean="${personaInstance}" field="nombreComunidad"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.experienciaAnio}">
        <div class="control-group">
            <div>
                <span id="experienciaAnio-label" class="control-label label label-inverse">
                    Experiencia Anio
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="experienciaAnio-label">
                    <g:fieldValue bean="${personaInstance}" field="experienciaAnio"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.experienciaMes}">
        <div class="control-group">
            <div>
                <span id="experienciaMes-label" class="control-label label label-inverse">
                    Experiencia Mes
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="experienciaMes-label">
                    <g:fieldValue bean="${personaInstance}" field="experienciaMes"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.trabajoComunitario}">
        <div class="control-group">
            <div>
                <span id="trabajoComunitario-label" class="control-label label label-inverse">
                    Trabajo Comunitario
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="trabajoComunitario-label">
                    <g:fieldValue bean="${personaInstance}" field="trabajoComunitario"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.fecha1}">
        <div class="control-group">
            <div>
                <span id="fecha1-label" class="control-label label label-inverse">
                    Fecha1
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="fecha1-label">
                    <g:formatDate date="${personaInstance?.fecha1}" />
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.fecha2}">
        <div class="control-group">
            <div>
                <span id="fecha2-label" class="control-label label label-inverse">
                    Fecha2
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="fecha2-label">
                    <g:formatDate date="${personaInstance?.fecha2}" />
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.fecha3}">
        <div class="control-group">
            <div>
                <span id="fecha3-label" class="control-label label label-inverse">
                    Fecha3
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="fecha3-label">
                    <g:formatDate date="${personaInstance?.fecha3}" />
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.institucion1}">
        <div class="control-group">
            <div>
                <span id="institucion1-label" class="control-label label label-inverse">
                    Institucion1
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="institucion1-label">
                    <g:fieldValue bean="${personaInstance}" field="institucion1"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.institucion2}">
        <div class="control-group">
            <div>
                <span id="institucion2-label" class="control-label label label-inverse">
                    Institucion2
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="institucion2-label">
                    <g:fieldValue bean="${personaInstance}" field="institucion2"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.institucion3}">
        <div class="control-group">
            <div>
                <span id="institucion3-label" class="control-label label label-inverse">
                    Institucion3
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="institucion3-label">
                    <g:fieldValue bean="${personaInstance}" field="institucion3"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.nombreCurso1}">
        <div class="control-group">
            <div>
                <span id="nombreCurso1-label" class="control-label label label-inverse">
                    Nombre Curso1
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="nombreCurso1-label">
                    <g:fieldValue bean="${personaInstance}" field="nombreCurso1"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.nombreCurso2}">
        <div class="control-group">
            <div>
                <span id="nombreCurso2-label" class="control-label label label-inverse">
                    Nombre Curso2
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="nombreCurso2-label">
                    <g:fieldValue bean="${personaInstance}" field="nombreCurso2"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.nombreCurso3}">
        <div class="control-group">
            <div>
                <span id="nombreCurso3-label" class="control-label label label-inverse">
                    Nombre Curso3
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="nombreCurso3-label">
                    <g:fieldValue bean="${personaInstance}" field="nombreCurso3"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.horas1}">
        <div class="control-group">
            <div>
                <span id="horas1-label" class="control-label label label-inverse">
                    Horas1
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="horas1-label">
                    <g:fieldValue bean="${personaInstance}" field="horas1"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.horas2}">
        <div class="control-group">
            <div>
                <span id="horas2-label" class="control-label label label-inverse">
                    Horas2
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="horas2-label">
                    <g:fieldValue bean="${personaInstance}" field="horas2"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.horas3}">
        <div class="control-group">
            <div>
                <span id="horas3-label" class="control-label label label-inverse">
                    Horas3
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="horas3-label">
                    <g:fieldValue bean="${personaInstance}" field="horas3"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.pin}">
        <div class="control-group">
            <div>
                <span id="pin-label" class="control-label label label-inverse">
                    Pin
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="pin-label">
                    <g:fieldValue bean="${personaInstance}" field="pin"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.puntajeTitulo}">
        <div class="control-group">
            <div>
                <span id="puntajeTitulo-label" class="control-label label label-inverse">
                    Puntaje Titulo
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntajeTitulo-label">
                    <g:fieldValue bean="${personaInstance}" field="puntajeTitulo"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.puntajeCursos}">
        <div class="control-group">
            <div>
                <span id="puntajeCursos-label" class="control-label label label-inverse">
                    Puntaje Cursos
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntajeCursos-label">
                    <g:fieldValue bean="${personaInstance}" field="puntajeCursos"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.puntajeExperiencia}">
        <div class="control-group">
            <div>
                <span id="puntajeExperiencia-label" class="control-label label label-inverse">
                    Puntaje Experiencia
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntajeExperiencia-label">
                    <g:fieldValue bean="${personaInstance}" field="puntajeExperiencia"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.puntajeTrabajoComunitario}">
        <div class="control-group">
            <div>
                <span id="puntajeTrabajoComunitario-label" class="control-label label label-inverse">
                    Puntaje Trabajo Comunitario
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntajeTrabajoComunitario-label">
                    <g:fieldValue bean="${personaInstance}" field="puntajeTrabajoComunitario"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.puntajeBilingue}">
        <div class="control-group">
            <div>
                <span id="puntajeBilingue-label" class="control-label label label-inverse">
                    Puntaje Bilingue
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntajeBilingue-label">
                    <g:fieldValue bean="${personaInstance}" field="puntajeBilingue"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.puntajePrueba}">
        <div class="control-group">
            <div>
                <span id="puntajePrueba-label" class="control-label label label-inverse">
                    Puntaje Prueba
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntajePrueba-label">
                    <g:fieldValue bean="${personaInstance}" field="puntajePrueba"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.puntajeEntrevista}">
        <div class="control-group">
            <div>
                <span id="puntajeEntrevista-label" class="control-label label label-inverse">
                    Puntaje Entrevista
                </span>
            </div>
            <div class="controls">
        
                <span aria-labelledby="puntajeEntrevista-label">
                    <g:fieldValue bean="${personaInstance}" field="puntajeEntrevista"/>
                </span>
        
            </div>
        </div>
    </g:if>
    
    </form>
</div>
