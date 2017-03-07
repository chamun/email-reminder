class MergeDateAndTimeIntoDueDate < ActiveRecord::Migration[5.0]
  def change
    remove_column :reminders, :time, :integer, default: 0
    remove_column :reminders, :date, :date
    add_column :reminders, :due_date, :datetime
  end
end
