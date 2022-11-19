# == Schema Information
#
# Table name: metrics
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  timeframe           :string           not null
#  unit_of_measurement :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  product_id          :bigint           not null
#
# Indexes
#
#  index_metrics_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
require "test_helper"

class MetricTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
