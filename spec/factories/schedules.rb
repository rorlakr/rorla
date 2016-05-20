# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    user nil
    name "MyString"
    info "MyText"
    venu "MyString"
    start_date "2016-05-19 15:55:26"
    end_date "2016-05-19 15:55:26"
    repeating false
    charged false
  end
end
