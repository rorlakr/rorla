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

  belongs_to :commentable, :polymorphic => true

	validates_presence_of :content
	validates :content, presence: true, :length => { :minimum => 0, :maximum => 10000 }

  belongs_to :commentable, :polymorphic => true
  belongs_to :writer

  validates :content, presence: true, :length => { :minimum => 0, :maximum => 10000 }

end
