$ ->
  $("input[type='submit'][data-loading-text]").on 'click', ->
    $(@).button('loading')

  $('.date_time_picker').datetimepicker(
    language: 'zh'
    format: 'YYYY-MM-DD'
    pickTime: false
  )
