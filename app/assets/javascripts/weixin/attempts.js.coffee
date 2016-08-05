$ ->
  $("input[type='submit'][data-loading-text]").on 'click', ->
    $(@).button('loading')

  $('li.rating-circle').on 'click',(e) ->
    rating = $(e.target).data('rating')
    ul = $(e.target).parent()
    $(ul).find('li.rating-circle').each((index, li) ->
      if(index > (rating - 1))
        $(li).addClass('rating-unselected')
        $(li).removeClass('rating-selected')
      else
        $(li).addClass('rating-selected')
        $(li).removeClass('rating-unselected')
    )
    $(e.target).removeClass('rating-unselected')
    $(e.target).addClass('rating-selected')
    $(ul).parent().find('input').val(rating)

  $("input.slider").slider
    min: 0
    max: 100
    step: 1
    tooltip: 'always'
