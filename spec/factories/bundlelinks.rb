# == Schema Information
#
# Table name: bundlelinks
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text(65535)
#  writer_id   :integer          not null
#  shared      :boolean          default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :bundlelink do
    title "MyString"
    description "MyText"
    writer
    factory :bundlelink_not_shared do
      shared false
    end
  end
end
