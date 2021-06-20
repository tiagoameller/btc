import Chart from "chart.js/auto"
import Rails from "@rails/ujs"
export default class extends ApplicationController {
  static targets = ["chart", "month", "day", "hour"]

  connect() {
    this.fetchGraphData(this.dayTarget)
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
        datasets: [{
            label: 'USD',
            backgroundColor: '#321fdb',
            borderColor: '#321fdb',
            pointHoverBackgroundColor: '#fff',
            borderWidth: 2,
            data: data.usd.average
          },
          {
            label: 'GBP',
            backgroundColor: '#F79F0F',
            borderColor: '#F79F0F',
            pointHoverBackgroundColor: '#fff',
            borderWidth: 2,
            data: data.gbp.average
          },
          {
            label: 'EUR',
            backgroundColor: '#DD4141',
            borderColor: '#DD4141',
            pointHoverBackgroundColor: '#fff',
            borderWidth: 2,
            data: data.eur.average
          }
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

  toggleActive (btn) {
    document.querySelectorAll('.time-nav').forEach((e) => e.classList.remove('active'))
    btn.classList.add('active')
  }
}
