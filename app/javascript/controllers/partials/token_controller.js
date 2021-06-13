export default class extends ApplicationController {
  static targets = ["input"]

  copyToClipboard () {
    this.inputTarget.select()
    document.execCommand("copy")
    this.toast(
      "",
      window.I18n.t("frontend.token.copied_to_clipboard"),
      "notice"
    )
  }
}
