# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :website do
    name "MyString"
    site_url "MyString"
    service_state 1
    service_type 1
    user nil
  end
end
