<div style="height: 30px;">
    <div id="search" class="pull-right"></div>
</div>
<table class="table table-bordered table-striped table-condensed table-hover" id="tbl">
    <thead>
        <tr>
            <th>Vive en</th>
            <th>Canton</th>
            <th>Formación</th>
            <th>Cédula</th>
            <th>Nombres</th>
            <th>Género</th>
            <th>Estado</th>
        </tr>
    </thead>
    <tbody class="paginate">
        <g:each in="${personaInstanceList}" status="i" var="personaInstance">
            <tr>
                <td>
                    ${fieldValue(bean: personaInstance, field: "provincia")}
                </td>
                <td>
                    ${fieldValue(bean: personaInstance, field: "canton")}
                </td>
                <td>
                    ${personaInstance.titulo?.descripcion}
                </td>
                <td>
                    <g:link action="verTitulo" rel="tooltip" title="Ver titulo" id="${personaInstance.id}">
                        ${personaInstance.cedula}
                    </g:link>
                </td>
                <td>
                    <a class="show btn-ajax" href="#" rel="tooltip" title="Ver" data-id="${personaInstance.id}">
                        ${personaInstance.apellido}, ${personaInstance.nombre}
                    </a>
                </td>
                <td>
                    ${personaInstance.sexo?.capitalize()}
                </td>
                <td>
                    ${personaInstance?.estado?.descripcion}
                </td>
            </tr>
        </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(".paginate").paginate({
        maxRows        : 100,
        searchPosition : $("#search"),
        searchButton   : "Buscar"
    });
</script>
