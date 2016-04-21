# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "MyString"
    unit_price 1
    total_stock_count 1
    sold_out false
    sold_out_at "2016-04-22 05:56:56"
  end
end
