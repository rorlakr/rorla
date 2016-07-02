$ ->
  $(document).on 'click', '.cancel_article', (event) ->
    event.preventDefault()
    $add_article_form = $(this).closest(".add_article_form")
    $add_article_form.hide()
    $section_articles = $(this).closest(".section_articles")
    $section_articles.find(".add_article_link").show()
    false