$ ->
  $("input[type='submit'][data-loading-text]").on 'click', ->
    $(@).button('loading')

  $('#filter-collapse').on 'hidden.bs.collapse', ->
    $(".filter a[data-toggle='collapse']").html("展开")

  $('#filter-collapse').on 'shown.bs.collapse', ->
    $(".filter a[data-toggle='collapse']").html("收起")

  $('table select').on 'change', (e) ->
    value = $(e.target).val()
    user_id = $(e.target).data('user_id')

    $(e.target).addClass('disabled')
    $(e.target).prop('disabled', true)

    $.ajax(
      dataType: 'json'
      url: "/admin/users/" + user_id
      data:
        'user[role_id]': value
      method: 'PUT'
    ).done( ->

    ).fail( ->

    ).always( ->
      $(e.target).prop('disabled', false)
      $(e.target).removeClass('disabled')
    )
