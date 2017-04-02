require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password) }
  it { is_expected.to have_many(:reminders).dependent(:destroy) }

  it "validates email format" do
    user = build(:user, email: "invalid email")
    expect(user.valid?).to be false
    expect(user.errors[:email]).to include("is invalid")
  end
end
