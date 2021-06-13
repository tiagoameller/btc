// coreui pro 3.4.0
import "./coreui.min.css"
import { activateTooltips, activatePopovers } from "libraries/data-toggles"

$(document).on("turbolinks:load", () => {
  if(!window.coreui) {
    window.pooper = require("@popperjs/core/dist/cjs/popper.js")
    window.coreui = require("./coreui.bundle.min.js")

    activateTooltips()
    activatePopovers()
  }
})
