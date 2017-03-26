class DueReminderDeliverer
  def self.deliver!
    Reminder
      .not_sent
      .past_due
      .each do |reminder|
      ReminderMailer.remind(reminder).deliver_now
      reminder.update_attributes!(sent: true)
    end
  end
end
