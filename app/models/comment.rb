# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  writer_id        :integer
#  content          :text             not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  belongs_to :writer, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  validates :content, presence: true, :length => { :minimum => 0, :maximum => 10000 }

end
