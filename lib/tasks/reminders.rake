require "due_reminder_deliverer"
require "timecop"

namespace :reminders do
  desc "Deliver past due reminders"
  task deliver: :environment do
    DueReminderDeliverer.deliver!
  end

  namespace :dev do
    desc "Creates a past due reminder"
    task create: :environment do
      abort('Only to be used in development') unless Rails.env.development?
      Timecop.freeze(DateTime.current.yesterday) do
        FactoryGirl.create(
          :reminder,
          title: "Back to the future",
          message: "I traveled to the past, so this message could "\
                   "be delivered in the present",
          user: User.first
        )
      end
    end
  end
end
