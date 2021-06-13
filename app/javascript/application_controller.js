// https://www.driftingruby.com/episodes/organizing-stimulus-controllers
// this controller is ancestor of all stimulus controllers
import { Controller } from "stimulus"

export default class ApplicationController extends Controller {

  toast (title, msg, kind) {
    App.common_controller.toast(title, msg, kind)
  }

  action (check) {
    if (check) {
      return (document.body.dataset.action === check)
    } else {
      return document.body.dataset.action
    }
  }

  environment () {
    return document.body.dataset.env
  }
}
