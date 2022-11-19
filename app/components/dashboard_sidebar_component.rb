# frozen_string_literal: true

class DashboardSidebarComponent < ViewComponent::Base
  def before_render
    @links = [
      {text: "Dashboard", icon: "house", path: user_root_path},
      {text: "Accounts", icon: "user", path: accounts_path}
    ]
  end
end
