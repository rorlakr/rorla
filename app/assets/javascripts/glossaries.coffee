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

$(document).on 'click', '#cancel_tag_link', (event) ->
  event.preventDefault()
  $(".tag_list_form_of_glossary").slideToggle('fast')
  $("#add_tag_link").fadeIn()

$(document).on 'click', "#add_tag_link", (event) ->
  event.preventDefault()
  $(".tag_list_form_of_glossary").slideToggle('fast')
  $(this).fadeOut()

$(document).on 'turbolinks:load', ->

  ((d, s, id) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    if d.getElementById(id)
      return
    js = d.createElement(s)
    js.id = id
    js.src = '//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.8&appId=140309816373762'
    fjs.parentNode.insertBefore js, fjs
    return
  ) document, 'script', 'facebook-jssdk'

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
