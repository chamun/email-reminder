FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }

    after(:build) { |user| user.password = 'password' }
  end
end
