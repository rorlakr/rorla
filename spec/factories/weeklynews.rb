# == Schema Information
#
# Table name: weeklynews
#
#  id         :integer          not null, primary key
#  uid        :string(255)      not null
#  subject    :string(255)      not null
#  sended_at  :datetime         not null
#  url        :text(65535)      not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weeklynews do
    uid "MyString"
    subject "MyString"
    sended_at "2014-11-30 14:16:02"
    url "MyText"
  end
end
