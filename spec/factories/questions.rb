# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "Question Title"
    content "Question Content"
    user

    trait :newbie_question do
      title "ROR?"
      content "What is ROR?"
    end
  
    factory :newbie_question, traits: [:newbie_question]
  end

end
