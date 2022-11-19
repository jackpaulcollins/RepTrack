# == Schema Information
#
# Table name: reports
#
#  id         :bigint           not null, primary key
#  points     :integer
#  rep_count  :integer
#  rep_type   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reports_on_account_id  (account_id)
#  index_reports_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
