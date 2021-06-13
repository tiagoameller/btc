# == Schema Information
#
# Table name: exchange_logs
#
#  updated  :datetime
#  usd_rate :float
#  gbp_rate :float
#  eur_rate :float
#
# Indexes
#
#  index_exchange_logs_on_updated  (updated) UNIQUE
#
class ExchangeLog < ApplicationRecord
end
