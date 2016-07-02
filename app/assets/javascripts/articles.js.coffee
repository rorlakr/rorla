$ ->
  $(document).on 'click', '.cancel_article', (event) ->
    event.preventDefault()
    $(this).closest(".add_article_form").hide()
    false
