<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 11/20/12
  Time: 12:19 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>
            Título
        </title>
    </head>

    <body>
        <div class="alert">
            <p class="tituloTree tituloGrande">Datos del aspirante</p>

            <strong>Nombres:</strong> ${persona.nombre} ${persona.apellido}<br/>
            <strong>Estado:</strong> <span id="spEstado">${persona.estado?.descripcion}</span><br/>
            %{--<strong>Email:</strong> ${persona.email}--}%

        </div>

        <div class="btn-group" role="navigation" style="margin-bottom: 15px;">
            <g:link action="list" class="btn">
                <i class="icon-list-ul"></i>
                Lista
            </g:link>
            <a href="#" class="btn btn-ajax btn-danger" id="rechazar">
                <i class="icon-remove"></i>
                No aceptar
            </a>
            <a href="#" class="btn btn-ajax btn-new" id="pendiente">
                <i class="icon-pushpin"></i>
                Pendiente
            </a>
            <a href="#" class="btn btn-ajax btn-new" id="subir">
                <i class="icon-certificate"></i>
                Subir título
            </a>
            <a href="#" class="btn btn-ajax btn-success" id="aceptar">
                <i class="icon-ok"></i>
                Aceptar
            </a>
        </div>

        <div class="modal hide fade" id="modal">
            <div class="modal-header" id="modalHeader">
                <button type="button" class="close darker" data-dismiss="modal">
                    <i class="icon-remove-circle"></i>
                </button>

                <h3 id="modalTitle"></h3>
            </div>

            <div class="modal-body" id="modalBody">
            </div>

            <div class="modal-footer" id="modalFooter">
            </div>
        </div>

        <div class="noMargin well">
            <g:if test="${teleh.TituloPersona.findAllByPersona(persona).size() > 0}">
                <ttl:ver class="titulo" id="${persona.id}"/>
            </g:if>
        </div>

        <script type="text/javascript">
            $(function () {
                $("#aceptar").click(function () {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Aceptar</a>');

                    btnSave.click(function () {
                        btnSave.replaceWith(spinner);
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'cambiarEstado')}",
                            data    : {
                                id     : "${persona.id}",
                                estado : 'C'
                            },
                            success : function (msg) {
                                var parts = msg.split("_")
                                if (parts[0] == "OK") {
                                    $("#spEstado").html(parts[1]);
                                } else {
                                    console.log("ERROR");
                                }
                                $("#modal").modal("hide");
                            }
                        });
                        return false;
                    });

                    $("#modalHeader").removeClass("btn-success btn-danger").addClass("btn-success");
                    $("#modalTitle").html("Aceptar Título");
                    $("#modalBody").html("Está seguro de aceptar el título de la persona?");
                    $("#modalFooter").html("").append(btnOk).append(btnSave);
                    $("#modal").modal("show");
                });
                $("#pendiente").click(function () {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Aceptar</a>');

                    btnSave.click(function () {
                        btnSave.replaceWith(spinner);
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'cambiarEstado')}",
                            data    : {
                                id     : "${persona.id}",
                                estado : 'I'
                            },
                            success : function (msg) {
                                var parts = msg.split("_")
                                if (parts[0] == "OK") {
                                    $("#spEstado").html(parts[1]);
                                } else {
                                    console.log("ERROR");
                                }
                                $("#modal").modal("hide");
                            }
                        });
                        return false;
                    });

                    $("#modalHeader").removeClass("btn-success btn-danger");
                    $("#modalTitle").html("Dejar Título como pendiente");
                    $("#modalBody").html("Está seguro de dejar el título de la persona como pendiente?");
                    $("#modalFooter").html("").append(btnOk).append(btnSave);
                    $("#modal").modal("show");
                });
                $("#rechazar").click(function () {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Aceptar</a>');

                    btnSave.click(function () {
                        btnSave.replaceWith(spinner);
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'cambiarEstado')}",
                            data    : {
                                id     : "${persona.id}",
                                estado : 'R'
                            },
                            success : function (msg) {
                                var parts = msg.split("_")
                                if (parts[0] == "OK") {
                                    $("#spEstado").html(parts[1]);
                                } else {
                                    console.log("ERROR");
                                }
                                $("#modal").modal("hide");
                            }
                        });
                        return false;
                    });

                    $("#modalHeader").removeClass("btn-success btn-danger").addClass("btn-danger");
                    $("#modalTitle").html("Rechazar Título");
                    $("#modalBody").html("Está seguro de rechazar el título de la persona?");
                    $("#modalFooter").html("").append(btnOk).append(btnSave);
                    $("#modal").modal("show");
                });
                $("#subir").click(function () {
                    var btnOk = $('<a href="#" data-dismiss="modal" class="btn">Cancelar</a>');
                    var btnSave = $('<a href="#"  class="btn btn-success"><i class="icon-ok"></i> Aceptar</a>');

                    btnSave.click(function () {
                        btnSave.replaceWith(spinner);
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'cambiarEstado')}",
                            data    : {
                                id     : "${persona.id}",
                                estado : 'S'
                            },
                            success : function (msg) {
                                var parts = msg.split("_")
                                if (parts[0] == "OK") {
                                    $("#modalBody").html("El mail ha sido enviado.");
                                } else {
                                    $("#modalBody").html("Ha ocurrido un error al enviar el mail.");
                                }
                                var btnCerrar = $('<a href="#" data-dismiss="modal" class="btn">Cerrar</a>');
                                $("#modalFooter").html("").append(btnCerrar);
                            }
                        });
                        return false;
                    });

                    $("#modalHeader").removeClass("btn-success btn-danger");
                    $("#modalTitle").html("Subir Título");
                    $("#modalBody").html("Está seguro de enviar un mail a la persona para que cargue el archivo del título?");
                    $("#modalFooter").html("").append(btnOk).append(btnSave);
                    $("#modal").modal("show");
                });
            });
        </script>

    </body>
</html>