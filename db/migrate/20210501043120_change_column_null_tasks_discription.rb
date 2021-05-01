class ChangeColumnNullTasksDiscription < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :discription, false
  end
end
