module ReportPostConcern
  extend ActiveSupport::Concern

  # def post_to_slack(report)
  #   return if Rails.env.development?

  #   message = "#{report.user.first_name} reported #{report.rep_count} #{report.rep_type.humanize.pluralize} for #{report.points} points"

  #   notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK"] do
  #     defaults channel: "#fitnessandhealth",
  #       username: "RepTrack"
  #   end

  #   notifier.ping message
  # end
end
