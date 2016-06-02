# == Schema Information
#
# Table name: appliers
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  user_id     :integer
#  name        :string(255)      not null
#  email       :string(255)      not null
#  cellphone   :string(255)
#  remittor    :string(255)
#  remit_date  :datetime
#  remit_money :integer          default(0)
#  memo        :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  accepted    :boolean          default(FALSE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :applier do
    schedule nil
    user nil
    name "MyString"
    email "MyString"
    cellphone "MyString"
    remittor "MyString"
    remit_date "2016-05-19 15:58:11"
    remit_money 1
    memo "MyText"
  end
end
