$(document).on 'turbolinks:load', ->
  $("#plazas").on
    mouseenter: ->
      $(this).find('.actions').fadeIn('fast')
      $(this).addClass "inside"
      return
    mouseleave: ->
      $(this).find(".actions").fadeOut('fast')
      $(this).removeClass "inside"
      return
    , ".plaza"
