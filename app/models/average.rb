# == Schema Information
#
# Table name: averages
#
#  kind      :integer
#  key       :string
#  usd_sum   :float            default(0.0)
#  usd_count :integer          default(0)
#  gbp_sum   :float            default(0.0)
#  gbp_count :integer          default(0)
#  eur_sum   :float            default(0.0)
#  eur_count :integer          default(0)
#
# Indexes
#
#  index_averages_on_kind_and_key  (kind,key) UNIQUE
#
class Average < ApplicationRecord
  include AverageCalculator
  self.implicit_order_column = [:kind, :key]

  enum kind: { day: 0, hour: 1, minute: 2 }
end
