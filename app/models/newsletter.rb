class Newsletter < ActiveRecord::Base
  
  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  mount_uploader :poster, PosterUploader

  belongs_to :editor, class_name: 'User'

  validates :title, presence: true
end
