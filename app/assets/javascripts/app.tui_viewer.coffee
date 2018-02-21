class App.TuiViewer
  constructor: (@el) ->
    @el.hide().after "<div id='#{@el[0].id}-viewer'></div>"

  render: ->
    $("##{@el[0].id}-viewer").tuiEditor
      viewer: true
      initialValue: @el.text()
      height: 500