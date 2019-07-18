import { Controller } from "stimulus";

export default class extends Controller {
  static targets = []

  connect() {
    $('.pagination').hide();
    if ($(".pagination").length && $(this).length) {
      $(window).scroll(function() {
        let url = $(".pagination a[rel='next']").attr("href");
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
          // $(".pagination").text("Loading more...");
          return $.getScript(url);
        }
      });
    }
  }
}