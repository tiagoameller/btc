import "./datatables"
import "./ladda"
import "./sweetalert"

// important: all utilities needed by backend generated js must be
// assigned to global window here:
import JQuery from "jquery"
window.$ = window.JQuery = JQuery
import Swal from "sweetalert2"
window.Swal = Swal
import IziToast from "izitoast/dist/js/iziToast.min.js"
window.IziToast = IziToast
import I18n from "./i18n/i18n.js"
window.I18n = I18n
require("./i18n/frontend.js")
