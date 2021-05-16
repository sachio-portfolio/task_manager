class User < ApplicationRecord
  has_secure_password
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: {maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }
  before_validation { email.downcase! }
  has_many :tasks
end
