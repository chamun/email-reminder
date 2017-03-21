class AddUserReferenceToReminders < ActiveRecord::Migration[5.0]
  def change
    add_reference :reminders, :user, foreign_key: true
  end
end
