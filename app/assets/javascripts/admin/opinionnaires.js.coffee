$ ->
  $(".opinionnaire_form select[name='draw_id']").on 'change',  (e) ->
    draw_id = $(e.target).val()

    return unless !!draw_id

    url = $(e.target).data('url')

    $.get(url, draw_id: draw_id).done (data) ->
      $.each data, (index, id) ->
        $("option[value='" + id + "']", bsmSelect.$original).each ->
          $(@).attr 'selected', true
          $(@).detach().appendTo(bsmSelect.$original)

      bsmSelect.$original.trigger 'change'
