$ ->
  $('#menu_category').on 'change', (e) ->
    value = $(e.target).val()
    $('.category_detail').hide()
    $(".category_detail_#{value}").show()

  $('#menu_category').trigger 'change'

  $('#menus-container table tbody.parent-menus').sortable
    itemSelector: 'tr.parent-menu'
    handle: 'span.parent-glyphicon-move'
    placeholder: "<span class='glyphicon glyphicon-arrow-right'/>"
    onDrop: ($item, container, _super, event) ->
      dropMenus($item)
      _super($item, container)

  $('#menus-container table tbody.child-menus').sortable
    itemSelector: 'tr'
    handle: 'span.glyphicon-move'
    placeholder: "<span class='glyphicon glyphicon-arrow-right'/>"
    onDrop: ($item, container, _super, event) ->
      dropMenus($item)
      _super($item, container)

  dropMenus = ($item) ->
    data = {}
    data["menus"] = $.map $item.closest('tbody').find('> tr'), (tr) ->
      return tr.id.split("_").pop()

    sendRequest(data)

  sendRequest = (data) ->
    post = $.post '/admin/menus/sort', data
    post.done ->
      console.log 'sort successfully'
    post.fail ->
      console.log 'failed to sort'

  return
