require "rails_helper"
require "due_reminder_deliverer"

RSpec.describe DueReminderDeliverer do
  describe ".deliver!" do
    subject { described_class.deliver! }
    let!(:reminder) { build(:reminder, :with_user) }

    around do |example|
      reminder.save
      Timecop.travel(current_date) { example.run }
    end

    describe "future reminders" do
      let(:current_date) { DateTime.current - 1.hour }

      it "does not mail these reminders" do
        expect { subject }.not_to change { ActionMailer::Base.deliveries.size }
      end

      it "does not change their sent column to true" do
        expect { subject }.not_to change { reminder.reload.sent?  }
      end
    end

    describe "past due reminders" do
      let(:current_date) { DateTime.current + 1.hour }

      describe "reminders that were not sent" do
        it "mails these reminders" do
          expect { subject }.to change {
            ActionMailer::Base.deliveries.size
          }.from(0).to(1)
        end

        it "change their sent column to true" do
          expect { subject }.to change {
            reminder.reload.sent?
          }.from(false).to(true)
        end
      end

      describe "reminders that were already sent" do
        before do
          reminder.update_attributes(sent: true)
        end

        it "does not mail these reminders" do
          expect { subject }.not_to change {
            ActionMailer::Base.deliveries.size
          }
        end
      end
    end
  end
end
