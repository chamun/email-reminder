FactoryGirl.define do
  factory :reminder do
    title "MyString"
    due_date DateTime.current + 1.hour
    message "MyString"
  end
end
