require 'rails_helper'

RSpec.describe Reminder, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date) }
end
