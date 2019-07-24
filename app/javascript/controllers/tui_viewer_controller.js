import $ from 'jquery';
import {
  Controller
} from 'stimulus'

export default class extends Controller {
  static targets = []

  connect() {
    console.log("tuiViewer connected!")
    $("[data-viewer='tui-viewer']").hide().after("<div id='viewSection'></div>")
    $("#viewSection").tuiEditor({
      initialValue: $("[data-viewer='tui-viewer']").text(),
      height: '500px',
      viewer: true
    })
  }
}