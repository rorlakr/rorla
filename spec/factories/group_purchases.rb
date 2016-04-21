# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_purchase do
    event_name "MyString"
    event_info "MyText"
    start_date "2016-04-22 05:56:45"
    end_date "2016-04-22 05:56:45"
    user nil
  end
end
