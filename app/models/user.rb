# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  # Not all databases use case-sensitive indices. (?)
  # We want all emails to be saved as lowercase for consistency.
  before_save { |user| user.email = email.downcase }

  # Name must exist and be a string shorter than 51 characters.
  validates :name, presence: true, 
                   length: { maximum: 50 }
  # Email must exist and match the valid email regex.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
# Password and confirmation must be present and longer than 5 characters.
  validates :password, presence: true, 
                       length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
