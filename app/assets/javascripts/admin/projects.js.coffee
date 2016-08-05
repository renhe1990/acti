 $ ->
   $("#import-modal form").bind "ajax:success", (e, data, status, xhr) ->
     $('#project_user_ids').multiSelect('addOption', data)
     $('#project_user_ids').multiSelect('select', $.map(data, (user) -> user.value.toString() ))
     $('#import-modal').modal('hide')

   $("#project_template_preview").on "click", (e) ->
     url = $(e.target).data('url')
     template = $('#project_template').val()
     if !!template
       window.open("#{url}?template=#{template}", "_blank", "width=320, scrollbars=yes, toolbars=no")

   $(".project_template").on "change", (e) ->
     value = $(e.target).val()
     if value == 'mode04' || value == 'mode05'
       $('.project_wechat_background').show()
     else
       $('.project_wechat_background').hide()

   value = $(".project_template").val()
   unless value == 'mode04' || value == 'mode05'
     $('.project_wechat_background').hide()

