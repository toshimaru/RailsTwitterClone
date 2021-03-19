# frozen_string_literal: true

def log_in(user, options = {})
  visit login_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end
