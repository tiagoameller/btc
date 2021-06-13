export const DEFAULT_OPTIONS = {
  processing: true,
  serverSide: true,
  lengthChange: true,
  ordering: true,
  autoWidth: true,
  scrollX: false,
  stateSave: true,
  order: [[0, "asc"]],
  // last item in data has info regarding to row. See app/datatables/customers_datatable.rb
  rowId (data) {
    return data[data.length - 1].row_id
  },
  "rowCallback": (row, data) => $(row).addClass(data[data.length - 1].row_class)
}

export const DEFAULT_COLUMNDEFS = [
  {
    targets: [-1, -2], // last two columns
    orderable: false,
    searchable: false,
    className: "text-center"
  }
]

export class DatatableInit {
  constructor (selector, options, columndefs) {

    if (options == null) { options = DEFAULT_OPTIONS }
    if (columndefs == null) { columndefs = DEFAULT_COLUMNDEFS }

    const self = this
    this.selector = selector
    this.table = $(`#${selector}`)
    const initoptions = Object.assign(
      {
        ajax: self.table.data("url"),
        columnDefs: columndefs,
        fnPreDrawCallback (e, settings) {
          // page length select has up/down and dropdown buttons
          return $("select.custom-select").removeClass("custom-select custom-select-sm")
        },
        fnDrawCallback (data) {
          if ($(this).data("readonly")) { $(".btn_edit, .btn_delete").addClass("disabled") }
          $(`#${self.selector} tbody tr`).removeClass("table-active")
          // if a row was selected, select and display
          for (const tr of Array.from($(`#${self.selector} tbody tr`))) {
            const candidate = $(tr).find("td:first >a:first")
            if ($(candidate).data("id") === self.datatable_api().state()[`${self.selector}_selected_id`]) {
              $(tr).addClass("table-active")
              top
              $("html").scrollTop($(tr).offset().top)
              break
            }
          }
          return $("[data-toggle=\"c-tooltip\"]").tooltip()
        },
        stateSaveCallback (settings, data) {
          return sessionStorage.setItem("DataTables_" + settings.sInstance, JSON.stringify(data))
        },
        stateLoadCallback (settings) {
          return JSON.parse(sessionStorage.getItem("DataTables_" + settings.sInstance))
        },
        language: {
          decimal: "",
          emptyTable: "No hay datos que mostrar",
          info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
          infoEmpty: "Sin registros que mostrar",
          infoFiltered: "(filtrados de un total de _MAX_)",
          infoPostFix: "",
          thousands: ",",
          lengthMenu: "Grupos de _MENU_ entradas",
          loadingRecords: "Cargando...",
          processing: "Procesando...",
          search: "Buscar:",
          zeroRecords: "No se encuentran registros",
          paginate: {
            first: "Primero",
            last: "Último",
            next: "Siguiente",
            previous: "Anterior"
          },
          aria: {
            sortAscending: ": ordenación ascendente",
            sortDescending: ": ordenación descendente"
          }
        }
      },
      options
    )
    this.datatable = self.table.dataTable(
      initoptions
    ).on("stateSaveParams.dt", (e, settings, data) => // save current selected row for restoring when back
      data[`${self.selector}_selected_id`] = self.get_selected_id())

    // set active a row when clicked
    $(`#${this.selector} tbody`).on("click", "tr", function (e) {
      self.set_selected_id($(this).find("td:first >a:first").data("id"))
      $(`#${self.selector} tbody tr`).removeClass("table-active")
      $(this).addClass("table-active")
    })
  }

  set_selected_id (value) { window[`#${this.selector}_selected_id`] = value }

  get_selected_id = () => window[`#${this.selector}_selected_id`]

  datatable_api = () => this.datatable.api()
}
