# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_user_roles_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class UserRole < ApplicationRecord
  belongs_to :product

  validates :name, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :user_roles, partial: "user_roles/index", locals: {user_role: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :user_roles, target: dom_id(self, :index) }
end
