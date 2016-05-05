# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text(65535)
#  writer_id    :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#  hit          :integer          default(0)
#  deleted_at   :datetime
#  bulletin_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#  picture      :string(255)
#  sash_id      :integer
#  level        :integer          default(0)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do

    title "post title"
    content "post content"
    association :writer, factory: :user

    factory :bulletin_post do
      association :bulletin, factory: :bulletin
    end
  end
end
