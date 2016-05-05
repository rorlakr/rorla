# == Schema Information
#
# Table name: podcasts
#
#  id             :integer          not null, primary key
#  uid            :string(255)
#  title          :string(255)
#  author         :string(255)
#  description    :text(65535)
#  enclosure_url  :text(65535)
#  enclosure_size :integer          default(0)
#  duration       :string(255)
#  published_at   :date
#  created_at     :datetime
#  updated_at     :datetime
#

class Podcast < ActiveRecord::Base
  has_many :comments, as: :commentable, dependent: :destroy

  is_impressionable
end
