class GlossaryDefinition < ActiveRecord::Base

  resourcify
  include Authority::Abilities  

  acts_as_votable

  belongs_to :glossary
  belongs_to :user

  validates :definition, presence: true

end
