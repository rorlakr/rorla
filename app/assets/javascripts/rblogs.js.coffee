# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('textarea.wmd-input').each (i, input) ->
    attr = $(input).attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    Markdown.Extra.init(converter)
    converter.hooks.chain "postConversion", (text) ->
      text = "<div style='border-bottom:1px dotted #800000;font-weight:bolder;color:#800000;margin-bottom: .5em;'>[Markdown Preview]</div>\n" + text
      text.replace /<pre>/g, "<pre class='prettyprint linenums'>"
    help =
      handler: () ->
        window.open('http://daringfireball.net/projects/markdown/syntax')
        return false
      title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
    editor = new Markdown.Editor(converter, attr, help)
    editor.hooks.chain "onPreviewRefresh", ->
      prettyPrint()
      return
    editor.run()

  $('.markdown-preview').each (i, input) ->
    # converter = new Markdown.getSanitizingConverter()
    converter = new Markdown.Converter()
    Markdown.Extra.init(converter)
    converter.hooks.chain "postConversion", (text) ->
      text.replace /<pre>/g, "<pre class='prettyprint linenums'>"
    # alert $(input).text().trim()
    $(input).html converter.makeHtml($(input).text().trim())
    prettyPrint()