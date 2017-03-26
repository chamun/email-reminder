require 'rails_helper'

RSpec.describe Reminder, type: :model do
  subject { build(:reminder) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:due_date) }
  it { is_expected.to belong_to(:user) }

  describe 'due_date' do
    subject { build(:reminder, :with_user, due_date: due_date) }

    context 'future due_date' do
      let(:due_date) { DateTime.current + 1.day }
      it 'is valid' do
        expect(subject.valid?).to be true
      end
    end

    context 'past due_date' do
      shared_context 'for a past due_date' do
        it 'is not valid' do
          expect(subject.valid?).to be false
        end

        it 'adds an error message to the due_date field' do
          subject.valid?
          expect(subject.errors[:due_date]).not_to be_empty
        end
      end

      describe 'due_date day is in the past ' do
        let(:due_date) { DateTime.current - 1.day }
        include_examples 'for a past due_date'
      end

      describe 'due_date time is in the past' do
        let(:due_date) { DateTime.current - 1.hour }
        include_examples 'for a past due_date'
      end
    end

    describe 'past due_date for sent reminders' do
      let(:due_date) { DateTime.current - 1.day }

      before do
        subject.sent = true
      end

      it "does not validate past due_date when reminder is sent" do
        expect(subject.valid?).to be true
      end
    end
  end

  describe 'user_email' do
    context 'user is present' do
      subject { build(:reminder, :with_user) }
      it "returns the user's email" do
        expect(subject.user_email).to eq(subject.user.email)
      end
    end

    context 'user is not present' do
      subject { build(:reminder) }
      it "returns nil" do
        expect(subject.user_email).to eq(nil)
      end
    end
  end

  describe '.not_sent' do
    let!(:not_sent) { create_list(:reminder, 2, :with_user) }

    before do
      create_list(:reminder, 2,
                  :with_user,
                  due_date: DateTime.current - 1.hour,
                  sent: true)
    end

    it 'returns reminders that were not sent' do
      expect(described_class.not_sent).to match_array(not_sent)
    end
  end
end
