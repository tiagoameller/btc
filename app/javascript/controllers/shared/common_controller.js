export default class extends ApplicationController {
  notImplementedAlert (evt) {
    if (evt) { evt.preventDefault() }
    window.Swal.fire(
      { title: window.I18n.t("frontend.common.not_implemented"), icon: "info" }
    )
  }

  toast (title, msg, kind) {
    const IZITOAST_SETTINGS =
      {
        class: "mt-4",
        position: "topCenter",
        displayMode: "1",
        layout: "2",
        titleSize: "1.4em",
        messageSize: "1.1em",
        titleLineHeight: "1.4em"
      }
    const kind_values = {
      success: { icon: "check", color: "#4dbd74" },
      error: { icon: "fire", color: "#f86c6b" },
      alert: { icon: "bell", color: "#ffc107" },
      notice: { icon: "info", color: "#63c2de" }
    }
    window.IziToast.settings(IZITOAST_SETTINGS)
    window.IziToast.show({
      title: title,
      message: msg,
      icon: `cil-icon cil-${kind_values[kind].icon}`,
      color: kind_values[kind].color
    })
  }

  syntaxHighlight (json) {
    if (typeof json == "object") { json = JSON.stringify(json) }
    json = json.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+-]?\d+)?)/g, function (match) {
      var cls = "json-number"
      if (/^"/.test(match)) {
        if (/:$/.test(match)) {
          cls = "json-key"
        } else {
          cls = "json-string"
        }
      } else if (/true|false/.test(match)) {
        cls = "json-boolean"
      } else if (/null/.test(match)) {
        cls = "json-null"
      }
      return "<span class=\"" + cls + "\">" + match + "</span>"
    }).replace(/,/g, "<br>")
  }

  removeBackdrops () {
    document.querySelectorAll(".modal-backdrop").forEach(e => e.remove())
  }

  configureDatepicker () {
    // https://bootstrap-datepicker.readthedocs.io/en/stable/index.html
    $(".datepicker").datepicker({
      "language": "es",
      "weekStart": 1,
      "autoclose": true,
      "todayBtn":  true,
      "todayHighlight": true,
      "format": "dd/mm/yyyy"
    })
  }
}