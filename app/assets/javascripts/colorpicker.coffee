$(document).on 'turbolinks:load', ->
  bootstrapColorpicker = ->
    $('[data-minicolors]').each (i, elem) ->
      input = $(this)
      input.minicolors input.data('minicolors')
      return
    return

  $ bootstrapColorpicker
  $(document).on 'page:load', bootstrapColorpicker
