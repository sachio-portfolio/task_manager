class Task < ApplicationRecord
  validates :task_name, :discription, presence: true

  private
  before_create do
    self.deadline = Time.now if deadline.blank?
  end
end
