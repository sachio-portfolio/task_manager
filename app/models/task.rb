class Task < ApplicationRecord
  before_validation :set_default_expired, on: %i[ create update ]
  validates :task_name, :discription, presence: true

  private
  def set_default_expired
    self.expired_at = Time.now if expired_at.blank?
  end
end
