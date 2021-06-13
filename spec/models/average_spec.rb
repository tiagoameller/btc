# == Schema Information
#
# Table name: averages
#
#  date_time :datetime
#  usd_sum   :float
#  usd_count :integer
#  gbp_sum   :float
#  gbp_count :integer
#  eur_sum   :float
#  eur_count :integer
#
# Indexes
#
#  index_averages_on_date_time  (date_time) UNIQUE
#
require 'rails_helper'

RSpec.describe Average, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
