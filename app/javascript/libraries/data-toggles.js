export function activateTooltips () {
  document.querySelectorAll("[data-toggle=\"c-tooltip\"]").forEach((e) => new window.coreui.Tooltip(e))
}

export function activatePopovers () {
  document.querySelectorAll("[data-toggle=\"popover\"]").forEach((e) => new window.coreui.Popover(e))
}