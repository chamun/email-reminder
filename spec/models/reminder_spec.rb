require 'rails_helper'

RSpec.describe Reminder, type: :model do
  subject { build(:reminder) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:time) }
  it { is_expected.to validate_numericality_of(:time)
                        .is_greater_than_or_equal_to(0)
                        .is_less_than(24)
                        .only_integer }

  describe 'date and time validation' do
    context 'future date and time' do
      subject { build(:reminder, time: DateTime.current.hour + 1) }

      it 'is valid' do
        expect(subject.valid?).to be true
      end
    end

    context 'date in the past' do
      subject { build(:reminder, date: Date.yesterday) }

      it 'is not valid' do
        expect(subject.valid?).to be false
      end

      it 'adds an error message to the date field' do
        subject.valid?
        expect(subject.errors[:date]).not_to be_empty
      end

      it 'does not add an error message to the time field' do
        subject.valid?
        expect(subject.errors[:time]).to be_empty
      end
    end

    context 'current date but time in the past' do
      subject { build(:reminder, time: 2.hours.ago.hour) }

      it 'is not valid' do
        expect(subject.valid?).to be false
      end

      it 'adds an error message to the date field' do
        subject.valid?
        expect(subject.errors[:date]).to be_empty
      end

      it 'does not add an error message to the time field' do
        subject.valid?
        expect(subject.errors[:time]).not_to be_empty
      end
    end
  end

end
