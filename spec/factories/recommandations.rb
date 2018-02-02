# == Schema Information
#
# Table name: recommandations
#
#  id             :integer          not null, primary key
#  schedule_id    :integer
#  applier_id     :integer
#  recommander_id :integer
#  score          :integer          default(0)
#  letter         :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :recommandation do
    applier nil
    recommander nil
    score 1
    letter "MyText"
  end
end
