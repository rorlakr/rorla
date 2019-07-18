import { Controller } from "stimulus";

export default class extends Controller {
  static targets = []

  connect() {
    $('.pagination').hide();
    if ($(".pagination").length && $(this).length) {
      $(window).scroll(function() {
        let url = $(".pagination a[rel='next']").attr("href");
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
          $('.loading_message').html(`
          <div class='h3 text-center text-primary'>Loading more....</div>
          <div class="text-center my-3">
            <div class="spinner-border text-primary" role="status">
              <span class="sr-only">Loading...</span>
            </div>
          </div>
          `)
          return $.getScript(url);
        }
      });
    }
  }
}