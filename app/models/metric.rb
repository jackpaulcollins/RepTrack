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
class Metric < ApplicationRecord
  belongs_to :product

  validates :name, presence: true
  validates :unit_of_measurement, presence: true
  validates :timeframe, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :metrics, partial: "metrics/index", locals: {metric: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :metrics, target: dom_id(self, :index) }
end
