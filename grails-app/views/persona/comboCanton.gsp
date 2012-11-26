<g:select  name="canton.id" from="${teleh.Canton.findAllByProvincia(prov)}" optionKey="id" class="many-to-one  required"
          value="${personaInstance?.canton?.id}" noSelection="['': '']" id="cmb_canton"/>
<span class="mandatory">*</span>
<p class="help-block ui-helper-hidden"></p>
<script type="text/javascript">
    $("#cmb_canton").change(function(){
        var id= $(this).val()
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'comboParr')}",
            data    : {
                id : id
            },
            success : function (msg) {
                $("#div_parr").html(msg);
            }
        });
    });
</script>