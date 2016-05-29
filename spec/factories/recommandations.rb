# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommandation do
    applier nil
    recommander nil
    score 1
    letter "MyText"
  end
end
