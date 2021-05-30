class Task < ApplicationRecord
  before_validation :set_default_expired, on: %i[ create update ]
  validates :task_name, :discription, :status, presence: true
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label

  require './app/commonclass/status'
  enum status: Status.options_for_enum

  scope :search_task_name, -> (task_name) { where('task_name LIKE ?', "%#{task_name}%") }
  scope :search_status, -> (status) { where(status: status) }
  scope :search_label, -> (label_id) { joins(:task_labels).where(task_labels: {label_id: label_id}) }

  require './app/commonclass/priority'
  enum priority: Priority.options_for_enum

  private
  def set_default_expired
    self.expired_at = Time.now if expired_at.blank?
  end
end
