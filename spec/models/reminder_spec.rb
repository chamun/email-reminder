require 'rails_helper'

RSpec.describe Reminder, type: :model do
  subject { build(:reminder) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:due_date) }
  it { is_expected.to belong_to(:user) }

  describe 'due_date' do
    context 'future due_date' do
      subject { build(:reminder, :with_user, due_date: DateTime.current + 1.day) }

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
        subject { build(:reminder, due_date: DateTime.current - 1.day) }
        include_examples 'for a past due_date'
      end

      describe 'due_date time is in the past' do
        subject { build(:reminder, due_date: DateTime.current - 1.hour) }
        include_examples 'for a past due_date'
      end
    end
  end
end
