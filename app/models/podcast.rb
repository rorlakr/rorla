class Podcast < ActiveRecord::Base
  has_many :comments, as: :commentable, dependent: :destroy

  is_impressionable
end
