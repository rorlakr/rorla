# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).on 'click', '#add_definition_link', (event) ->
#   event.preventDefault()
#   $("#glossary_definition_form").slideToggle('fast')
#   $(this).fadeOut()

$(document).on 'click', '#cancel_definition_link', (event) ->
  event.preventDefault()
  $("#glossary_definition_form").slideToggle('fast')
  $("#add_definition_link").fadeIn()
