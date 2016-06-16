class Glossary < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  as_enum :word_class,
  # %i{noun verb adjective adverb pronoun preposition conjunction determiner exclamation}
  %i{명사 동사 형용사 부사 대명사 전치사 접속사 관형사 감탄사}

  belongs_to :user
  has_many :glossary_definitions, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :glossary_definitions, allow_destroy: true, :reject_if => proc { |attributes| attributes['definition'].blank? }

  validates :term, presence: true, uniqueness: true

  default_scope { order(updated_at: :desc)}

  def self.search(search)
    if search
      where('term LIKE ?', "#{search}%" )
    else
      all
    end
  end

end
