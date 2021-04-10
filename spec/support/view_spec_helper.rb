# frozen_string_literal: true

module ViewSpecHelper
  def log_in_as(user)
    allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(user)
  end
end
