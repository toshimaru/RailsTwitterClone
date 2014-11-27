class Tweet < ActiveRecord::Base
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    r = Relationship.arel_table
    t = Tweet.arel_table
    sub_query = t[:user_id].in(r.where(r[:follower_id].eq(user.id)).project(r[:followed_id]))
    where(sub_query.or(t[:user_id].eq(user.id)))
    # - No Arel -
    # followed_user_ids = "SELECT followed_id FROM relationships
    # WHERE follower_id = :user_id"
    # where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end
end
