$ ->
  $("body").tooltip { selector: '[data-toggle="tooltip"]', container: 'body'}

  $("#favlink_tag_tokens").tokenInput '/tags.json',
    hintText: "태그를 입력하세요."
    searchingText: "검색 중..."
    preventDuplicates: true
    theme: 'facebook'
    prePopulate: $("#favlink_tag_tokens").data 'load'
