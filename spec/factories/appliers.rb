# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :applier do
    schedule nil
    user nil
    name "MyString"
    email "MyString"
    cellphone "MyString"
    remittor "MyString"
    remit_date "2016-05-19 15:58:11"
    remit_money 1
    memo "MyText"
  end
end
