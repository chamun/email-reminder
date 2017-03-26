class AddSentToReminder < ActiveRecord::Migration[5.0]
  def change
    add_column :reminders, :sent, :boolean, default: false
  end
end
