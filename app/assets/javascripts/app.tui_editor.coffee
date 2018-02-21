class App.TuiEditor
  constructor: (@el) ->
    @el.hide().after "<div id='#{@el[0].id}-editor'></div>"
    @form = @el.closest('form')
    # console.log @form

  render: ->
    $("##{@el[0].id}-editor").tuiEditor
      initialEditType: 'markdown'
      initialValue: @el.text()
      viewer: false
      # previewStyle: 'vertical'
      height: 500,       
      exts: ['scrollSync'] 