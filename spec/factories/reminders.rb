FactoryGirl.define do
  factory :reminder do
    title "MyString"
    due_date DateTime.current + 1.hour
    message "MyString"
    user { create(:user) }
  end
end
