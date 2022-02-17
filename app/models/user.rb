# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  inverse_of: :follower,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   inverse_of: :followed,
                                   dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save { self.email = email.downcase }

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

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def remember
    self.remember_token = self.class.new_token
    update_attribute(:remember_digest, self.class.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
