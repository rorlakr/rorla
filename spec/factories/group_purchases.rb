# == Schema Information
#
# Table name: group_purchases
#
#  id         :integer          not null, primary key
#  event_name :string(255)      not null
#  event_info :text(65535)
#  start_date :datetime         not null
#  end_date   :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
