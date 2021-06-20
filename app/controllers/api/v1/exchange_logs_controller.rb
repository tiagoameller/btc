# rubocop:disable Rails/ApplicationController
module Api
  module V1
    class ExchangeLogsController < ActionController::Base
      protect_from_forgery with: :null_session

      # get data from provider:
      # curl https://api.coindesk.com/v1/bpi/currentprice.json > /tmp/btc.json
      #
      # it returns:
      # {
      #   "time": {
      #     "updated": "Jun 19, 2021 06:26:00 UTC",
      #     "updatedISO": "2021-06-19T06:26:00+00:00",
      #     "updateduk": "Jun 19, 2021 at 07:26 BST"
      #   },
      #   "disclaimer": "This data was produced from the CoinDesk Bitcoin Price Index ...",
      #   "chartName": "Bitcoin",
      #   "bpi": {
      #     "USD": {
      #       "code": "USD",
      #       "symbol": "&#36;",
      #       "rate": "35,623.1567",
      #       "description": "United States Dollar",
      #       "rate_float": 35623.1567
      #     },
      #     "GBP": {
      #       "code": "GBP",
      #       "symbol": "&pound;",
      #       "rate": "25,792.3766",
      #       "description": "British Pound Sterling",
      #       "rate_float": 25792.3766
      #     },
      #     "EUR": {
      #       "code": "EUR",
      #       "symbol": "&euro;",
      #       "rate": "30,025.3695",
      #       "description": "Euro",
      #       "rate_float": 30025.3695
      #     }
      #   }
      # }
      #
      # Post to this API:
      # curl -X POST -H "Content-Type: application/json" -d @/tmp/btc.json http://localhost:3000/api/v1/exchange_logs

      def create
        updated = Time.zone.parse(params.dig('time', 'updated') || 'bad date')
        raise ArgumentError unless updated

        ExchangeLog.create!(
          updated: updated,
          usd_rate: params.dig('bpi', 'USD', 'rate_float'),
          gbp_rate: params.dig('bpi', 'GBP', 'rate_float'),
          eur_rate: params.dig('bpi', 'EUR', 'rate_float')
        )
        render json: { ok: 'Exchange log saved' }, stauts: 200
        ActionCable.server.broadcast('background_update_channel', data: { id: 1 })
      rescue ArgumentError
        render json: { error: 'Bad parameters for exchange log. Rejected' }, stauts: 400
      rescue ActiveRecord::NotNullViolation
        render json: { error: 'All rate values are required for exchange log. Rejected' }, stauts: 400
      rescue ActiveRecord::RecordNotUnique
        render json: { error: 'Duplicate timestamp for exchange log. Rejected' }, stauts: :conflict
      end
    end
  end
end
# rubocop:enable Rails/ApplicationController
