require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe '.remind' do
    let(:reminder) { create(:reminder, :with_user) }
    subject(:mail) { ReminderMailer.remind(reminder) }

    it 'renders the title in the subject' do
      expect(mail.subject).to eq(reminder.title)
    end
  end
end
