# frozen_string_literal: true

module SystemSpecHelper
  def log_in_as(user)
    visit login_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
