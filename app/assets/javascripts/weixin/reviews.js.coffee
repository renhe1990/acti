$ ->
  $('#new_review').submit ->
    stop = false
    $(@).find("input[name^='review[answers_attributes]']").each (i, e)->
      if !$(e).val()
        stop = true
    if stop
      alert('请给所有学员打分')
      $(@).find('input[type=submit]').button('reset')
      false
