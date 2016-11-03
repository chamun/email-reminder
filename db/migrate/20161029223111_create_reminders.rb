class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.date :date
      t.integer :time
      t.string :message

      t.timestamps
    end
  end
end
