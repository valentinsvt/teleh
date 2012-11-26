<g:select  name="parroquia.id" from="${teleh.Parroquia.findAllByCanton(canton)}" optionKey="id" class="many-to-one required"
          value="${personaInstance?.parroquia?.id}" noSelection="['': '']" id="cmb_parr"/>
<span class="mandatory">*</span>
<p class="help-block ui-helper-hidden"></p>

