# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # CodeMirror for Textarea tag
  $("textarea.codemirror").each ->
    CodeMirror.fromTextArea $(this).get(0),
      lineNumbers: true
      mode: "ruby"
      tabSize: 2
      theme: "solarized light"
    return

  # CodeMirror for Div tag (readonly)
  $(".code").each ->
    $this = $(this)
    $code = $this.html()
    $unescaped = $("<div/>").html($code).text()
    $this.empty()
    CodeMirror this,
      value: $unescaped
      mode: "ruby"
      lineNumbers: not $this.is(".inline")
      readOnly: true
    return

