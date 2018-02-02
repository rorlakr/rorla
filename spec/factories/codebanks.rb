# == Schema Information
#
# Table name: codebanks
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  summary    :text(65535)
#  snippet    :text(65535)      not null
#  writer_id  :integer
#  shared     :boolean
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :codebank do
    title "MyString"
    summary "MyText"
    snippet "MyText"
    writer nil
    shared false
  end
end
