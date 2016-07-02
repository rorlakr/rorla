$ ->
  $("body").tooltip { selector: '[data-toggle="tooltip"]', container: 'body'}

$(document).on "page:change", ->
  $("#favlink_tag_tokens, #rblog_tag_tokens, #codebank_tag_tokens, #glossary_tag_tokens").tokenInput '/tags.json',
    hintText: "태그를 입력하세요."
    searchingText: "검색 중..."
    preventDuplicates: true
    theme: 'facebook'
    prePopulate: $("#favlink_tag_tokens, #rblog_tag_tokens, #codebank_tag_tokens, #glossary_tag_tokens").data 'load'
    propertyToSearch: "name"
    resultsFormatter: (tag) ->
      "<li>" + "<span class='fa fa-tag'></span> " + tag.name + "</div></li>"

    tokenFormatter: (tag) ->
      "<li><p>" + tag.name + "</p></li>"
