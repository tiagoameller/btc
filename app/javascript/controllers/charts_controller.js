import Chart from "chart.js/auto"
import Rails from "@rails/ujs"
export default class extends ApplicationController {
  static targets = ["chart", "month", "day", "hour"]

  connect() {
    this.fetchGraphData(this.dayTarget)
    setInterval(() => { this.fetchSelectedGraph() }, 60000)
  }

  fetchSelectedGraph () {
    const btn = document.querySelectorAll('.time-nav.active')[0]
    if (btn) btn.click()
  }

  fetchGraphData (e) {
    const btn = (e.type === "click" ? e.currentTarget : e)
    this.toggleActive(btn)

    Rails.ajax({
      url: btn.getAttribute('data-url'),
      type: "get",
      dataType: "json",
      error: (_jqXHR, textStatus, errorThrown) => App.common_controller.toast(`AJAX Error: ${textStatus}`, errorThrown || "Lost connection to server", "error"),
      success: (data, _textStatus, _jqXHR) => { this.drawGraph(data) }
    })
  }

  drawGraph (data) {
    if (this.btcChart != undefined) {
      this.btcChart.destroy()
    }

    this.btcChart = new Chart(this.chartTarget, {
      type: 'line',
      data: {
        labels: data.labels,
        datasets: [
          this.buildDataset(data, 'usd', '#321fdb'),
          this.buildDataset(data, 'gbp', '#f79f0f'),
          this.buildDataset(data, 'eur', '#dd4141')
        ]
      },
      options: {
        mytainAspectRatio: false,
        responsive: true,
        plugins: {
          legend: {
            display: true,
            position: 'top',
            align: 'start'
          }
        },
        scales: {
          y: {
            suggestedMin: 20000,
            suggestedMax: 40000
          },
          x: {
            title: {
              display: true,
              text: data.x_title
            }
          }
        },
        elements: {
          point: {
            radius: 0,
            hitRadius: 10,
            hoverRadius: 4,
            hoverBorderWidth: 3
          }
        }
      }
    });

    this.btcChart.update()
  }

  buildDataset (data, currency, color) {
    return {
      label: `${currency.toUpperCase()} - Min: ${data[currency].min_max.min} Max: ${data[currency].min_max.max}`,
      backgroundColor: color,
      borderColor: color,
      pointHoverBackgroundColor: '#fff',
      borderWidth: 2,
      data: data[currency].average
    }
  }

  toggleActive (btn) {
    document.querySelectorAll('.time-nav').forEach((e) => e.classList.remove('active'))
    btn.classList.add('active')
  }
}
