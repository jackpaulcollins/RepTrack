class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    users = current_account.users
    leader_board = users.sort_by { |u| u.reports.sum(:points)}
    @leader_board = leader_board.reverse
  end
end
