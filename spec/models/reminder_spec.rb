require 'rails_helper'

RSpec.describe Reminder, type: :model do
  subject { build(:reminder) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date) }

  it 'validates current date' do
    reminder = build(:reminder, date: Date.yesterday)
    expect(reminder.valid?).to be false
  end
end
