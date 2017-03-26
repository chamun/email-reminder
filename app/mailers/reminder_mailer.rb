class ReminderMailer < ApplicationMailer
  def remind(reminder)
    @reminder = reminder
    mail(
      to: reminder.user_email,
      subject: reminder.title
    )
  end
end
