# frozen_string_literal: true

module RequestSpecHelper
  def log_in_as(user)
    post login_path, params: { session: { email: user.email, password: "password" } }
  end
end
