module Stats
  class MinMax
    attr_reader :min, :max

    private

    def initialize(min, max)
      @min = min
      @max = max
    end

    class << self
      def min_usd(start, finish)
        calculate(:usd, start, finish)
      end

      def max_usd(start, finish)
        calculate(:usd, start, finish)
      end

      def min_gbp(start, finish)
        calculate(:gbp, start, finish)
      end

      def max_gbp(start, finish)
        calculate(:gbp, start, finish)
      end

      def min_eur(start, finish)
        calculate(:eur, start, finish)
      end

      def max_eur(start, finish)
        calculate(:eur, start, finish)
      end

      private

      def calculate(currency, start, finish)
        result = ExchangeLog.where('updated between ? and ?', start, finish).pluck("#{currency}_rate")
        if result.empty?
          null_object
        else
          mew(
            result.min,
            result.max
          )
        end
      end

      def null_object
        new(0, 0)
      end
    end
  end
end
