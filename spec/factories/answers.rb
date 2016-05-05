# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text(65535)
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  sash_id     :integer
#  level       :integer          default(0)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    content "Answer Content"
  end
end
