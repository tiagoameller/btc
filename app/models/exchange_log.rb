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
class ExchangeLog < ApplicationRecord
  self.implicit_order_column = 'updated'

  after_save do
    Stats::Average.add_exchange(self)
  end
end
