class AddLimitDateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :limit_date, :date
  end
end
