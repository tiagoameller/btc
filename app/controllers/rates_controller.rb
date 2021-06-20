class RatesController < ApplicationController
  include HasBreadcrumbs

  def index; end

  def month; end

  def day
    labels = []
    usd_average = []
    gbp_average = []
    eur_average = []

    current_time = Time.current
    23.downto(0) do |i|
      hour = current_time - i.hours
      labels << hour.strftime('%H')
      average = Rates::Average.hour(hour)
      usd_average << average.usd
      gbp_average << average.gbp
      eur_average << average.eur
    end

    render json: {
      labels: labels,
      x_title: 'Hours',
      usd: {
        min_max: Rates::MinMax.usd(current_time - 1.day, current_time),
        average: usd_average
      },
      gbp: {
        min_max: Rates::MinMax.gbp(current_time - 1.day, current_time),
        average: gbp_average
      },
      eur: {
        min_max: Rates::MinMax.eur(current_time - 1.day, current_time),
        average: eur_average
      }
    }
  end

  def hour; end

  private

  def set_breadcrumbs
    add_breadcrumbs(
      [
        ['Home', root_path], ['Exchange rates']
      ]
    )
  end
end
