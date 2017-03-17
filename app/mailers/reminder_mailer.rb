class ReminderMailer < ApplicationMailer
  def remind(reminder)
    mail(subject: reminder.title)
  end
end
