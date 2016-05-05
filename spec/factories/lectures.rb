# == Schema Information
#
# Table name: lectures
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  title       :string(255)      not null
#  content     :text(65535)
#  youtube_url :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture do
    course nil
    title "MyString"
    content "MyText"
    youtube_url "MyString"
  end
end
