import Chart from "chart.js/auto"
export default class extends ApplicationController {

  connect () {
    if (myChart != undefined) {
      myChart.destroy()
    }

    var myChart = new Chart(document.getElementById('my-chart'),{
        type: 'line',
        data: {
            labels: ['a','b','c','d','e','f','g', 'a','b','c','d','e','f','g', 'a','b','c','d','e','f','g', 'a','b','c','d','e','f','g'],
            datasets: [{
                label: 'My First dataset',
                backgroundColor: 'transparent',
                borderColor: '#321fdb',
                pointHoverBackgroundColor: '#fff',
                borderWidth: 2,
                data: [165, 180, 70, 69, 77, 57, 125, 165, 172, 91, 173, 138, 155, 89, 50, 161, 65, 163, 160, 103, 114, 185, 125, 196, 183, 64, 137, 95, 112, 175]
            }, {
                label: 'My Second dataset',
                backgroundColor: 'transparent',
                borderColor: '#2eb85c',
                pointHoverBackgroundColor: '#fff',
                borderWidth: 2,
                data: [92, 97, 80, 100, 86, 97, 83, 98, 87, 98, 93, 83, 87, 98, 96, 84, 91, 97, 88, 86, 94, 86, 95, 91, 98, 91, 92, 80, 83, 82]
            }, {
                label: 'My Third dataset',
                backgroundColor: 'transparent',
                borderColor: '#e55353',
                pointHoverBackgroundColor: '#fff',
                borderWidth: 1,
                // borderDash: [8, 5],
                data: [42, 47, 83, 133, 86, 47, 83, 48, 87, 48, 43, 83, 87, 48, 46, 84, 41, 47, 88, 86, 44, 86, 45, 41, 48, 41, 42, 83, 83, 82]
                //data: [65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65]
            }]
        },
        options: {
            mytainAspectRatio: false,
            legend: {
                display: false
            },
            scales: {
                xAxes: [{
                    gridLines: {
                        drawOnChartArea: false
                    }
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        maxTicksLimit: 5,
                        stepSize: Math.ceil(250 / 5),
                        max: 250
                    }
                }]
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

    myChart.update()
  }
}
