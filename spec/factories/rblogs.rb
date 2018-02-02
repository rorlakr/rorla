# == Schema Information
#
# Table name: rblogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  writer_id  :integer
#  shared     :boolean
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :rblog do
    title "MyString"
    content "MyText"
    writer nil
    shared false
  end
end
