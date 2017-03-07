FactoryGirl.define do
  factory :reminder do
    title "MyString"
    date DateTime.current + 1.hour
    time (DateTime.current + 1.hour).hour
    message "MyString"
  end
end
