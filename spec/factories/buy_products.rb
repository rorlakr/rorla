# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :buy_product do
    group_purchase nil
    product nil
  end
end
