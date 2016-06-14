# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :glossary do
    user nil
    term "MyString"
    word_class 1
    idiomatic false
    memo "MyText"
  end
end
