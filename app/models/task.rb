class Task < ApplicationRecord
  validates :task_name, :discription, presence: true
end
