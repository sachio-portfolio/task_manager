class User < ApplicationRecord
  has_secure_password
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: {maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }
  before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy
  after_update :ensure_admin
  after_destroy :ensure_admin

  private
  def ensure_admin
    if User.where(admin: true).count.zero?
      raise "最後の管理者は削除できません"
    end
  end
end
