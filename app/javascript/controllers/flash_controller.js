import { Controller } from 'stimulus';
import toastr from 'toastr';

export default class extends Controller {
  static targets = []

  connect(){
    let messages = this.data.get("messages")
    if(messages) {
      console.log(messages)
      toastr.success(messages)
    }
  }
}