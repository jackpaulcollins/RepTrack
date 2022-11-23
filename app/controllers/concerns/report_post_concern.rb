module ReportPostConcern
  extend ActiveSupport::Concern

  def post_to_slack(report)
    return if Rails.env.development?

    message = "#{report.user.first_name} reported #{report.rep_count} #{report.rep_type.humanize.pluralize} for #{report.points} points"

    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
      defaults channel: "#api-test",
        username: "RepTrack"
    end

    notifier.ping message
  end
end
