<div class="hide" id="divError">
    <div class="alert alert-error" role="status">
        <a class="close" data-dismiss="alert" href="#">×</a>
        <span id="spError">
            ERROR
        </span>
    </div>
</div>

<table class="table table-bordered table-striped table-condensed table-hover">
    <thead>
        <tr>
            <th>Texto</th>
            <th style="width: 60px;">Correcta</th>
            <th></th>
        </tr>
        <tr>
            <td>
                <g:textArea name="respuesta" cols="40" rows="1" maxlength="1024" class="span8"/>
            </td>
            <td style="text-align: center; vertical-align: middle;">
                <input type="checkbox" name="correcta" id="correcta"/>
            </td>
            <td style="text-align: center; vertical-align: middle;">
                <a href="#" id="btnAddRes" class="btn btn-success" rel="tooltip" tooltip="Agregar">
                    <i class="icon-plus"></i>
                </a>
            </td>
        </tr>
    </thead>
    <tbody id="tbResp">
        <g:each in="${preguntaInstance?.respuestas ?}" var="r">
            <tr class="${r.correcta == 1 ? 'success correcta' : ''}">
                <td>${r.respuesta}</td>
                <td>${r.correcta == 1 ? 'Correcta' : 'Incorrecta'}</td>
                <td style="text-align: center; vertical-align: middle;">
                    <a href="#" data-id="${r.id}" class="btn btn-delete btn-small delRes ">
                        <i class="icon-trash icon-large"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </tbody>
</table>

<script type="text/javascript">

    function del(btn) {
        var id = btn.data("id");
        if (confirm("Está seguro de querer eliminar esta respuesta?")) {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'delRespuesta_ajax')}",
                data    : {
                    id : id
                },
                success : function (msg) {
                    if (msg == "OK") {
                        btn.parents("tr").remove();
                    }
                }
            });
        }
    }

    $(".delRes").click(function () {
        var btn = $(this);
        del(btn);
        %{--var id = btn.data("id");--}%
        %{--if (confirm("Está seguro de querer eliminar esta respuesta?")) {--}%
        %{--$.ajax({--}%
        %{--type    : "POST",--}%
        %{--url     : "${createLink(action:'delRespuesta_ajax')}",--}%
        %{--data    : {--}%
        %{--id : id--}%
        %{--},--}%
        %{--success : function (msg) {--}%
        %{--if (msg == "OK") {--}%
        %{--btn.parents("tr").remove();--}%
        %{--}--}%
        %{--}--}%
        %{--});--}%
        %{--}--}%
        return false;
    });

    $("#btnAddRes").click(function () {
        if ($(".correcta").size() != 0 && $("#correcta").is(":checked")) {
            $("#spError").text("Solamente puede haber una respuesta correcta por pregunta...");
            $("#divError").show();
        } else {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'addRespuesta_ajax')}",
                data    : {
                    pregunta  : "${preguntaInstance.id}",
                    respuesta : $("#respuesta").val(),
                    correcta  : $("#correcta").is(":checked")
                },
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        var $tr = $("<tr></tr>");
                        if ($("#correcta").is(":checked")) {
                            $tr.addClass("success")
                        }
                        var $tdTexto = $("<td></td>");
                        $tdTexto.text($("#respuesta").val());
                        var $tdCorrecta = $("<td></td>");
                        $tdCorrecta.text($("#correcta").is(":checked") ? "Correcta" : "Incorrecta");

                        var $tdDel = $("<td></td>");
                        $tdDel.css({
                            textAlign     : "center",
                            verticalAlign : "middle"
                        });
                        var $btnDel = $("<a href='#' class='btn btn-delete btn-small delRes '><i class='icon-trash icon-large'></i></a>");
                        $btnDel.data("id", parts[1]);

                        $btnDel.click(function () {
                            del($btnDel);
                        });

                        $tdDel.append($btnDel);

                        $tr.append($tdTexto).append($tdCorrecta).append($tdDel);

                        $("#tbResp").prepend($tr);

                        $("#respuesta").val("");
                        $("#correcta").removeAttr("checked");
                    }
                }
            });
        }
        return false;
    });
</script>