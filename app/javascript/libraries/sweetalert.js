import Swal from "sweetalert2"
import Rails from "@rails/ujs"

Rails.confirm = function (message, element) {
  //
  // if you want to customize buttons:
  //
  // const swalWithBootstrap = Swal.mixin({
  //   customClass: {
  //       confirmButton: 'btn btn-success',
  //       cancelButton: 'btn btn-info'
  //     },
  //     buttonsStyling: false
  //   })
  // swalWithBootstrap.fire(
  //   {
  //     title: message,
  //     type: 'warning',
  //     showCancelButton: true,
  //     reverseButtons: true
  //   }
  // ).then((result) => {
  //   if (result.value) {
  //     element.removeAttribute('data-confirm')
  //     element.click()
  //   }
  // })
  Swal.fire({
    title: message,
    icon: "warning",
    showCancelButton: true,
    reverseButtons: true
  }).then((result) => {
    if (result.value) {
      element.removeAttribute("data-confirm")
      element.click()
    }
  })
}
