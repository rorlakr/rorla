class GlossaryDefinition < ActiveRecord::Base
  belongs_to :glossary
  belongs_to :user

  validates :definition, presence: true
end
