class GlossaryDefinition < ActiveRecord::Base

  acts_as_votable

  belongs_to :glossary
  belongs_to :user

  validates :definition, presence: true
  
end
