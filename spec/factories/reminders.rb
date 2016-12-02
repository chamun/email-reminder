FactoryGirl.define do
  factory :reminder do
    title "MyString"
    date Date.current
    time Time.current.hour
    message "MyString"
  end
end
