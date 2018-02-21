window.App ||= {}

App.init = ->
  # you can write code to implement in all pages.

$(document).on "turbolinks:load", ->
  App.init()