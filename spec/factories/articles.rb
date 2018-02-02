# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :article do
    newsletter nil
    news_section nil
    title "MyString"
    content "MyText"
    poster "MyString"
    reference_url "MyString"
    reporter nil
  end
end
