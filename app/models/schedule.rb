class Schedule < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  belongs_to :user
  has_many :appliers, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
