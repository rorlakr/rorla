class Article < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  mount_uploader :poster, PosterUploader

  belongs_to :newsletter
  belongs_to :news_section
  belongs_to :reporter, class_name: 'User'

  validates :title, presence: true
end
