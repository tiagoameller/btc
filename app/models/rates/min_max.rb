module Rates
  class MinMax
    attr_reader :min, :max

    private

    def initialize(min, max)
      @min = min
      @max = max
    end

    class << self
      def usd(start, finish)
        calculate(:usd, start, finish)
      end

      def gbp(start, finish)
        calculate(:gbp, start, finish)
      end

      def eur(start, finish)
        calculate(:eur, start, finish)
      end

      private

      def calculate(currency, start, finish)
        result = ExchangeLog.where('updated between ? and ?', start, finish).pluck("#{currency}_rate")
        if result.empty?
          null_object
        else
          new(
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
