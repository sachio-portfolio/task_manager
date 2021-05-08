class Task < ApplicationRecord
  before_validation :set_default_expired, on: %i[ create update ]
  validates :task_name, :discription, :status, presence: true

  require './app/commonclass/status'
  enum status: Status.options_for_enum

  scope :search_task_name, -> (task_name) { where('task_name LIKE ?', "%#{task_name}%") }
  scope :search_status, -> (status) { where(status: status) }

  private
  def set_default_expired
    self.expired_at = Time.now if expired_at.blank?
  end
end
