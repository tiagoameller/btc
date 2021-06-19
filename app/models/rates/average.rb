module Rates
  class Average
    attr_reader :usd, :gbp, :eur

    private

    def initialize(usd, gbp, eur)
      @usd = usd
      @gbp = gbp
      @eur = eur
    end

    class << self
      def add_exchange(exchange)
        SavedAverage.kinds.each_key do |kind|
          key = build_key(kind, exchange.updated)
          create_or_update(kind, key, exchange)
        end
      end

      def day(timestamp)
        candidate = SavedAverage.find_by(kind: :day, key: build_key(:day, timestamp))
        calculate(candidate)
      end

      def hour(timestamp)
        candidate = SavedAverage.find_by(kind: :hour, key: build_key(:hour, timestamp))
        calculate(candidate)
      end

      def minute(timestamp)
        candidate = SavedAverage.find_by(kind: :minute, key: build_key(:minute, timestamp))
        calculate(candidate)
      end

      private

      def calculate(candidate)
        return null_object if candidate.nil?

        new(
          divide_or_zero(candidate.usd_sum, candidate.usd_count),
          divide_or_zero(candidate.gbp_sum, candidate.gbp_count),
          divide_or_zero(candidate.eur_sum, candidate.eur_count)
        )
      end

      def null_object
        new(0, 0, 0)
      end

      def build_key(kind, timestamp)
        case kind.to_sym
        when :day
          timestamp.strftime('%Y%m%d000000')
        when :hour
          timestamp.strftime('%Y%m%d%H0000')
        when :minute
          timestamp.strftime('%Y%m%d%H%M00')
        end
      end

      def create_or_update(kind, key, exchange)
        candidate = SavedAverage.create_or_find_by(kind: kind, key: key)
        candidate.usd_sum += exchange.usd_rate
        candidate.usd_count += 1
        candidate.gbp_sum += exchange.gbp_rate
        candidate.gbp_count += 1
        candidate.eur_sum += exchange.eur_rate
        candidate.eur_count += 1
        candidate.save!
      end

      def divide_or_zero(divident, divisor)
        if divisor.zero?
          0
        else
          divident.fdiv divisor
        end
      end
    end
  end
end
