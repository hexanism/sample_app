class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  # Determines in what order microposts will be returned in
  # when retrieved from the database.
  default_scope order: 'microposts.created_at DESC'
end
