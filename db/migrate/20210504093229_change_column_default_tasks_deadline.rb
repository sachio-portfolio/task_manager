class ChangeColumnDefaultTasksDeadline < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :deadline, from: "now()", to: nil
  end
end
