class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  # Determines in what order microposts will be returned in
  # when retrieved from the database.
  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    self.where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
               user_id: user)
  end
end
