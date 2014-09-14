# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :codebank do
    title "MyString"
    summary "MyText"
    snippet "MyText"
    writer nil
    shared false
  end
end
