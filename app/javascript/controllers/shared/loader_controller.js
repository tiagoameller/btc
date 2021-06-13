// this controller is attached at layout level, every page loads it
import CommonController from "controllers/shared/common_controller"

export default class extends ApplicationController {
  static targets = ["rightSidebar"]

  connect () {
    // console.log('DEBUG. initialized loader controller')

    if (!window.App) { window.App = {} }
    window.App.common_controller = new CommonController()

    this.focusInvalidFields()

    window.setTimeout(
      () => $(".alert-dimissable").fadeTo(500, 0).slideUp(500),
      4000)
  }

  takeFocus (selector) {
    if ($(selector).length > 0) {
      $(selector)[0].focus()
      $(selector)[0].select()
    }
  }

  focusInvalidFields () {
    if (["new", "create"].includes(this.action())) {
      if ($("input.is-invalid").length > 0) {
        $("input.is-invalid").first().trigger("focus")
      } else {
        this.takeFocus(".action_new_autofocus")
      }
    } else {
      if (["edit", "update"].includes(this.action())) {
        if ($("input.is-invalid").length > 0) {
          $("input.is-invalid").first().trigger("focus")
        } else {
          this.takeFocus(".action_edit_autofocus")
        }
      }
    }
  }

  closeRightSidebar () {
    // sometimes coreui class toggler don't work. force to close right side bar when clicking to body
    this.rightSidebarTarget.classList.remove("c-sidebar-show")
  }

}
