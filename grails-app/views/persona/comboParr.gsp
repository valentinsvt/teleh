<g:select  name="parroquia.id" from="${teleh.Parroquia.findAllByCanton(canton)}" optionKey="id" class="many-to-one "
          value="${personaInstance?.parroquia?.id}" noSelection="['': '']" id="cmb_parr"/>

