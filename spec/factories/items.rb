# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    purchage_request nil
    shirts_color "MyString"
    shirts_size "MyString"
    count 1
  end
end
