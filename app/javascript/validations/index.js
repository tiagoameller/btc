// https://github.com/DavyJonesLocker/client_side_validations#heads-up-for-turbolinks-users
require("./rails.validations.js")
require("./rails.validations.simple_form.js")
require("./rails.validations.simple_form.bootstrap4.js")

// client side validations callbacks
 window.ClientSideValidations.callbacks.element.after = (element, eventData) => {
  $(".validable_form_submit").prop("disabled", ($(".is-invalid").length > 0))
}
