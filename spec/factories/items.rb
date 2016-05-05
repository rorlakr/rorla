# == Schema Information
#
# Table name: items
#
#  id                  :integer          not null, primary key
#  purchase_request_id :integer
#  shirts_color        :string(1)
#  shirts_size         :string(3)
#  count               :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    purchage_request nil
    shirts_color "MyString"
    shirts_size "MyString"
    count 1
  end
end
