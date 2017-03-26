# Preview all emails at http://localhost:3000/rails/mailers/reminder
class ReminderPreview < ActionMailer::Preview
  def remind
    ReminderMailer.remind(Reminder.first)
  end
end
