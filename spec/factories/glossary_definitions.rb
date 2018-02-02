# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :glossary_definition do
    glossary nil
    user nil
    definition "MyString"
    sentence "MyText"
  end
end
