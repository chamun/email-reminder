require "due_reminder_deliverer"

namespace :reminders do
  desc "Deliver past due reminders"
  task deliver: :environment do
    DueReminderDeliverer.deliver!
  end
end
