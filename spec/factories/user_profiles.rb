# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile do
    user nil
    name "MyString"
    github "MyString"
    intro "MyText"
    blog "MyString"
    website "MyString"
    company "MyString"
    title "MyString"
  end
end
