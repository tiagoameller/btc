export default class extends ApplicationController {
  static targets = ["password", "confirmation", "submit", "eye"]

  check () {
    if ((this.passwordTarget.value !== "") && (this.passwordTarget.value !== this.confirmationTarget.value)) {
      this.confirmationTarget.classList.add("is-invalid")
      this.submitButton.setAttribute("disabled", "true")
    } else {
      this.confirmationTarget.classList.remove("is-invalid")
      this.submitButton.removeAttribute("disabled")
    }
  }

  eyeToggle () {
    this.eyeTarget.classList.toggle("font-weight-bold")
    const password = this.passwordTarget
    if (password.getAttribute("type") == "password") {
      password.setAttribute("type", "text")
    } else {
      password.setAttribute("type", "password")
    }
  }

  get submitButton () {
    return document.querySelector("[type=submit]") || this.submitTarget
  }
}
