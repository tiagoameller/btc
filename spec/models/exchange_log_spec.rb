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
require 'rails_helper'

RSpec.describe ExchangeLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
