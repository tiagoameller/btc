module AverageCalculator
  extend ActiveSupport::Concern

  module ClassMethods
    def add_exchange(exchange)
      Average.kinds.each_key do |kind|
        key = build_key(kind, exchange.updated)
        create_or_update(kind, key, exchange)
      end
    end

    def by_day(timestamp)
      candidate = find_by(kind: :day, key: build_key(:day, timestamp))
      Calculator.new(candidate)
    end

    def by_hour(timestamp)
      candidate = find_by(kind: :hour, key: build_key(:hour, timestamp))
      Calculator.new(candidate)
    end

    def by_minute(timestamp)
      candidate = find_by(kind: :minute, key: build_key(:minute, timestamp))
      Calculator.new(candidate)
    end

    private

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
      candidate = Average.create_or_find_by(kind: kind, key: key)
      candidate.usd_sum += exchange.usd_rate
      candidate.usd_count += 1
      candidate.gbp_sum += exchange.gbp_rate
      candidate.gbp_count += 1
      candidate.eur_sum += exchange.eur_rate
      candidate.eur_count += 1
      candidate.save!
    end
  end

  class Calculator
    attr_reader :usd_rate, :gbp_rate, :eur_rate

    def initialize(average)
      return null_object if average.nil?

      @usd_rate = divide_or_zero(average.usd_sum, average.usd_count)
      @gbp_rate = divide_or_zero(average.gbp_sum, average.gbp_count)
      @eur_rate = divide_or_zero(average.eur_sum, average.eur_count)
    end

    private

    def null_object
      OpenStruct.new(
        usd_rate: 0,
        gbp_rate: 0,
        eur_rate: 0
      )
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
