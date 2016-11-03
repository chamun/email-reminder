FactoryGirl.define do
  factory :reminder do
    title "MyString"
    date Date.current
    time 1
    message "MyString"
  end
end
