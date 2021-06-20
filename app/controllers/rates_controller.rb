class RatesController < ApplicationController
  include HasBreadcrumbs

  def index; end

  def month
    process_request(:month)
  end

  def day
    process_request(:day)
  end

  def hour
    process_request(:hour)
  end

  private

  def process_request(time_frame)
    request =
      case time_frame
      when :month
        Services::Graph::Month.call
      when :day
        Services::Graph::Day.call
      when :hour
        Services::Graph::Hour.call
      end
    if request.success?
      render json: request.result, status: :ok
    else
      render json: { error: request.erors }, status: :service_unavailable
    end
  end

  def set_breadcrumbs
    add_breadcrumbs(
      [
        ['Home', root_path], ['Exchange rates']
      ]
    )
  end
end
