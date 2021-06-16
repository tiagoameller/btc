# == Schema Information
#
# Table name: exchange_logs
#
#  updated  :datetime
#  usd_rate :float            default(0.0)
#  gbp_rate :float            default(0.0)
#  eur_rate :float            default(0.0)
#
# Indexes
#
#  index_exchange_logs_on_updated  (updated) UNIQUE
#
FactoryBot.define do
  factory :exchange_log do
    usd_rate { 1.1 }
    gbp_rate { 2.2 }
    eur_rate { 3.3 }
    factory :exchange_log_higher do
      usd_rate { 3.1 }
      gbp_rate { 4.2 }
      eur_rate { 5.3 }
    end
  end
end
