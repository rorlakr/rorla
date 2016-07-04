$ ->
  $(document).on 'click', '.cancel_article', (event) ->
    event.preventDefault()
    $add_article_form = $(this).closest(".article_form")
    $add_article_form.slideUp(200, this.remove)
    $section_articles = $(this).closest(".section_articles")
    $section_articles.find(".add_article_link").show()
    $article_id = $(this).data("article")
    $("#article_#{$article_id}").slideDown()
    false
