# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  created_at  :datetime
#  updated_at  :datetime
#  post_type   :string(255)      default("general")
#

class Bulletin < ActiveRecord::Base
  resourcify
  include Authority::Abilities

  extend FriendlyId
  friendly_id :title
  validates_length_of :title, maximum: 64
  validates_uniqueness_of :title
  has_many :posts, dependent: :nullify
end
