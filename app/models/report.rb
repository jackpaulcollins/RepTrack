# == Schema Information
#
# Table name: reports
#
#  id          :bigint           not null, primary key
#  points      :integer
#  rep_count   :integer
#  rep_type    :string
#  report_date :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#  user_id     :bigint           not null
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
  REP_TYPE_VALUES = {
    "push_up" => 2,
    "air_squat" => 2,
    "bar_dip" => 2,
    "bench_dip" => 1,
    "chin_up" => 3,
    "pull_up" => 4,
    "handstand_push_up" => 6,
    "back_extension" => 2,
    "mountain_climber" => 1,
    "burpee" => 3,
    "leg_raise" => 2,
    "body_weight_row" => 3,
    "mile" => 5,
    "plank" => 20
  }.freeze

  belongs_to :user
  belongs_to :account
  acts_as_tenant :account

  validates :rep_type, presence: true, inclusion: {in: REP_TYPE_VALUES.keys}
  validates :rep_count, presence: true, numericality: true
  validates :report_date, presence: true
  validate :report_not_in_future

  before_save do
    self.points = rep_count * REP_TYPE_VALUES[rep_type]
  end

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :reports, partial: "reports/index", locals: {report: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :reports, target: dom_id(self, :index) }

  def report_not_in_future
    if report_date > Date.today
      errors.add(:report_date, "can't be in the future")
    end
  end
end
