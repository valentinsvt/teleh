<div id="create-PreguntaEntrevista" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave-PreguntaEntrevista" action="copy" id="${conv.id}">
        <div class="alert alert-error">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>Atención!</strong>
            Al copiar la entrevista se eliminarán todas las preguntas ya existentes en la convocatoria
            <strong>${conv.descripcion}</strong>
        </div>

        <div class="row">
            Copiar la entrevista de la convocatoria
        </div>

        <div class="row">
            <g:select name="convocatoria" from="${convs}" optionKey="id" optionValue="descripcion" class="span5"/>
        </div>

        <div class="row">
            a la convocatoria <strong>${conv.descripcion}</strong>
        </div>
    </g:form>
</div>