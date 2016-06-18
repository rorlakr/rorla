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

$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless window.fbEventsBound

bindFacebookEvents = ->
  $(document)
  .on('page:fetch', saveFacebookRoot)
  .on('page:change', restoreFacebookRoot)
  .on('page:load', ->
    FB?.XFBML.parse()
  )
  @fbEventsBound = true

saveFacebookRoot = ->
  if $('#fb-root').length
    @fbRoot = $('#fb-root').detach()

restoreFacebookRoot = ->
  if @fbRoot?
    if $('#fb-root').length
      $('#fb-root').replaceWith @fbRoot
    else
      $('body').append @fbRoot

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/en_US/sdk.js")

initializeFacebookSDK = ->
  FB.init
    appId  : '140309816373762'
    status : true
    cookie : true
    xfbml  : true