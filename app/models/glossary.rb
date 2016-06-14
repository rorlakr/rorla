class Glossary < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  belongs_to :user
  has_many :glossary_definitions, dependent: :destroy

  accepts_nested_attributes_for :glossary_definitions, allow_destroy: true, :reject_if => :all_blank
  validates :term, presence: true
end
