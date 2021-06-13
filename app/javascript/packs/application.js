// rails and stimulus runtimes
require("@rails/ujs").start()
require("turbolinks").start()
import "controllers"
import "libraries"
import "framework"
import "@coreui/icons/css/all.min.css"
import "application.scss"

// exit from modals with ESC
$(document).bind("keydown", function (evt) {
  evt = evt || window.event
  if (evt.keyCode === 27) {
    try {
      evt.preventDefault()
    } catch (x) {
      evt.returnValue = false
    }
    $(".modal.fade.show").modal("hide")
    $("body").removeClass("modal-open")
  }
})

