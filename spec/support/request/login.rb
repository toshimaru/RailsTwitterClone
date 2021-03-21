# frozen_string_literal: true

def log_in_as(user)
  post login_path, params: { session: { email: user.email, password: "password" } }
end
