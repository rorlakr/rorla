# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  sash_id    :integer
#  level      :integer          default(0)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
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
