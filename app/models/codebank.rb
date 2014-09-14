class Codebank < ActiveRecord::Base
  resourcify
  include Authority::Abilities

  belongs_to :writer, class_name: "User"

  validates :title, :snippet, presence: true
end
