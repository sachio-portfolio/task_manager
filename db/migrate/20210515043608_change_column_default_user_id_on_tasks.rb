class ChangeColumnDefaultUserIdOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :user_id, from: nil, to: 100
  end
end
