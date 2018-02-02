# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :newsletter do
    title "MyString"
    greeting "MyText"
    published_at "2016-06-30 21:46:22"
    editor nil
    poster "MyString"
  end
end
