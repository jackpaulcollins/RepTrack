# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_products_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Product < ApplicationRecord
  acts_as_tenant :account

  belongs_to :account
  has_many :user_roles, index_errors: true, dependent: :destroy
  has_many :metrics, index_errors: true, dependent: :destroy

  accepts_nested_attributes_for :user_roles, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :metrics, allow_destroy: true, reject_if: :all_blank

  has_rich_text :description

  validates :name, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :products, partial: "products/index", locals: {product: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :products, target: dom_id(self, :index) }
end
