require 'rails_helper'

RSpec.describe Reminder, type: :model do
  subject { build(:reminder) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_numericality_of(:time)
                        .is_greater_than_or_equal_to(0)
                        .is_less_than(24)
                        .only_integer }

  it 'validates current date' do
    reminder = build(:reminder, date: Date.yesterday)
    expect(reminder.valid?).to be false
  end
end
