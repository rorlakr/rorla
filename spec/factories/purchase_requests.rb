# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_request do
    user nil
    req_date "2016-04-21"
    send_date "2016-04-21"
    sender_name "MyString"
    amount 1
    confirmed false
    confirmed_at "2016-04-21 12:06:52"
  end
end
