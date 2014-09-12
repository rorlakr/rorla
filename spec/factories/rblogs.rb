# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rblog do
    title "MyString"
    content "MyText"
    writer nil
    shared false
  end
end
