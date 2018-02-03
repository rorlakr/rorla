# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#cancel_product_registration', (event) ->
  $("#product_addition").show()
  $("#product_addition_form").html("")
  false
