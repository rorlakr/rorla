# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("textarea.codemirror.editable").each ->
    CodeMirror.fromTextArea $(this).get(0),
      lineNumbers: true
      mode: "ruby"
      tabSize: 2
      theme: "solarized light"
    return

  $("textarea.codemirror.readonly").each ->
    CodeMirror.fromTextArea $(this).get(0),
      lineNumbers: true
      mode: "ruby"
      tabSize: 2
      theme: "default"
      readOnly: true
      # viewportMargin: "Infinity"
    return
