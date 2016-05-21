class Schedule < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  belongs_to :user
  has_many :appliers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
