$ ->
  $("body").tooltip { selector: '[data-toggle="tooltip"]', container: 'body'}

  $("#favlink_tag_tokens, #rblog_tag_tokens, #codebank_tag_tokens").tokenInput '/tags.json',
    hintText: "태그를 입력하세요."
    searchingText: "검색 중..."
    preventDuplicates: true
    theme: 'facebook'
    prePopulate: $("#favlink_tag_tokens, #rblog_tag_tokens, #codebank_tag_tokens").data 'load'
    propertyToSearch: "name"
    resultsFormatter: (tag) ->
      if tag.taggings_count?
        "<li>" + "<span class='fa fa-tag'></span> " + tag.name + " (" + tag.taggings_count + ")</div></li>"
      else
        "<li>" + "<span class='fa fa-tag'></span> " + tag.name + "</div></li>"

    tokenFormatter: (tag) ->
      if tag.taggings_count?
        "<li><p>" + tag.name + " (<b title='태그갯수' data-toggle='tooltip' style='color: red'>" + tag.taggings_count + "</b>)</p></li>"
      else
        "<li><p>" + tag.name + " (<b title='태그갯수' data-toggle='tooltip' style='color: red'>0</b>)</p></li>"

