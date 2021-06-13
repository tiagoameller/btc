// https://github.com/hakimel/Ladda
import "ladda/dist/ladda-themeless.min.css"
import * as Ladda from "ladda/js/ladda.js"

// Automatically trigger the loading animation on click and remain for two seconds
$(document).on("turbolinks:load", () => {
  Ladda.bind(".c-loading-button", {
    timeout: 2000
  })
})
