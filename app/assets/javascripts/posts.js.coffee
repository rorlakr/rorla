$(document).on 'turbolinks:load', ->
  $('#posts .gallery').hover ->
    $(this).find('.content').slideDown('fast')
  , ->
    $(this).find('.content').slideUp('fast')

$(document).on "turbolinks:load", ->
  return unless $(".posts.new, .posts.edit").length > 0
  tui_editor = new App.TuiEditor $("[data-editor='tui-editor']")
  tui_editor.render()
  tui_editor.form.submit (event) ->
    tui_editor.el.text $("##{tui_editor.el[0].id}-editor").tuiEditor 'getValue'  

$(document).on "turbolinks:load", ->
  return unless $(".posts.show").length > 0
  tui_viewer = new App.TuiViewer $("[data-viewer='tui-viewer']")
  tui_viewer.render() 