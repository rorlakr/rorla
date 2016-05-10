class UserProfile < ActiveRecord::Base
  mount_uploader :avatar, UserProfileUploader
  belongs_to :user
end
