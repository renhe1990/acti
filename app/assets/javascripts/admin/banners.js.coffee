 $ ->
  $('.sortable').sortable
    itemSelector: 'tr'
    handle: 'span.glyphicon-move'
    placeholder: "<span class='glyphicon glyphicon-arrow-right'/>"
    onDrop: ($item, container, _super) ->
      sort_url = $item.parent().data('sort_url')
      param_name = $item.parent().data('param_name')

      if sort_url
        data = {}
        data["#{param_name}"] = $.map $('table tbody tr'), (tr, index) ->
          return tr.id.split("_").pop()

        post = $.post sort_url, data
        post.done ->
          console.log("sort successfully")
        post.fail ->
          console.log("failed to sort")

        $('table tbody td.position').each (index, td) ->
          $(td).html(index + 1)

      _super($item, container)
