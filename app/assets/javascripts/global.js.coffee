$ ->
  $("body").tooltip { selector: '[data-toggle="tooltip"]', container: 'body'}

  $("#favlink_tag_tokens").tokenInput '/tags.json',
    theme: 'facebook'
    prePopulate: $("#favlink_tag_tokens").data 'load'
