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
require "test_helper"

class UserRoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
