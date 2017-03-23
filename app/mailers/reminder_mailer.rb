class ReminderMailer < ApplicationMailer
  def remind(reminder)
    mail(
      to: reminder.user_email,
      subject: reminder.title
    )
  end
end
