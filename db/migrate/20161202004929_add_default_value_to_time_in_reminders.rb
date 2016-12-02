class AddDefaultValueToTimeInReminders < ActiveRecord::Migration[5.0]
  def up
    change_column_default :reminders, :time, 0
  end

  def down
    change_column_default :reminders, :time, nil
  end
end
