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
class Report < ApplicationRecord
  belongs_to :user
  belongs_to :account
  acts_as_tenant :account

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :reports, partial: "reports/index", locals: {report: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :reports, target: dom_id(self, :index) }
end
