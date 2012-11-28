<g:each in="${cursos}" var="curso">
    <tr>
        <td>
            <g:formatDate date="${curso.fecha}" format="dd-MM-yyyy"/>
        </td>
        <td>
            ${curso.institucion}
        </td>
        <td>
            ${curso.nombre}
        </td>
        <td>
            ${curso.horas}
        </td>
        <td>
            <a href="#" class="btn btn-delete btnDeleteCurso" id="${curso.id}">
                <i class="icon-trash"></i>
            </a>
        </td>
    </tr>
</g:each>

<script type="text/javascript">
    $(".btnDeleteCurso").click(function () {
        if (confirm("Está seguro de querer eliminar este curso?")) {
            var btn = $(this);
            var id = btn.attr("id");
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'deleteCursoPersona')}",
                data    : {
                    id : id
                },
                success : function (msg) {
                    if (msg == "OK") {
                        btn.parents("tr").remove();
                        scroll();
                    }
                }
            });
        }
    });
</script>