# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :news_section do
    title "MyString"
    description "MyText"
    user nil
  end
end
