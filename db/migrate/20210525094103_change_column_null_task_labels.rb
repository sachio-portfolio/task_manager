class ChangeColumnNullTaskLabels < ActiveRecord::Migration[5.2]
  def change
    change_column_null :task_labels, :task_id, false
    change_column_null :task_labels, :label_id, false
  end
end
