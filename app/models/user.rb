# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  inverse_of: :follower,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   inverse_of: :followed,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # See implementation: https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true, if: ->(u) { u.password.present? }
  validates :slug, uniqueness: true

  def to_param
    slug
  end

  def feed
    # NOTE: `tweets.or` doesn't work, so use `Tweet.where`
    Tweet.where(user_id: id).or(Tweet.where(user_id: active_relationships.select(:followed_id)))
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy!
  end

  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def hexdigest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  private
    def create_remember_token
      self.remember_token = User.hexdigest(User.new_remember_token)
    end
end
