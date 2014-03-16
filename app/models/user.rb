class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # See implementation: https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password
  validates_confirmation_of :password, if: lambda { |m| m.password.present? }
  validates :password, length: { minimum: 6 }
end
