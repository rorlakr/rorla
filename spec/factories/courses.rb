# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  summary    :text(65535)
#  tutor_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    title "MyString"
    summary "MyText"
    tutor nil
  end
end
