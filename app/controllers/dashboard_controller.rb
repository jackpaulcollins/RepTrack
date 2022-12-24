class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    users = current_account.users

    @totals = users.each_with_object(Hash.new(0)) do | u, memo|
      memo[u.first_name] = u.reports.group(:rep_type).sum(:rep_count)
    end
  end
end
