import { Controller } from "stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  dialog(event) {
    function confirmFunc(){
      $("#${target_id_attr}").slideUp(1000);
      Swal.fire("Successfully deleted.");
    }

    function cancelFunc(){
      Swal.fire("Error occurred.");
    }

    event.preventDefault();
    let originLink = event.target.href;
    let target_id_attr = event.target.closest("tr").id;

    Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, delete it!"
    }).then((result) => {
      if (result.value) {
        let promise = $.ajax({
          type: "DELETE",
          url: originLink + ".json"
        }); 

        promise.fail(cancelFunc);
        promise.done(confirmFunc);
      }
    });
  }
}