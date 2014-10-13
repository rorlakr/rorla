class Codebank < ActiveRecord::Base
  resourcify
  include Authority::Abilities

  belongs_to :writer, class_name: "User"
  has_one :plaza, :as => :postitable, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :snippet, presence: true

  default_scope { order(created_at: :desc)}
  scope :shared, -> { where(shared: true)}
  scope :my_snippets, -> (user_id) { where(writer_id: user_id)}
  scope :my_shared_snippets, -> (user_id) { my_snippets(user_id).where(shared: true)}
  scope :my_private_snippets, -> (user_id) { my_snippets(user_id).where(shared: false)}

  after_create :set_plaza_codebank
  after_update :update_plaza_codebank, if: 'self.shared_changed?'

  # Model Impressionable
  is_impressionable

  # 태그 토큰입력
  include TagTokenize
  acts_as_taggable

  private

  def set_plaza_codebank
    self.create_plaza(visible: self.shared)
  end

  def update_plaza_codebank
    if self.plaza.nil?
      self.create_plaza(visible: self.shared)
    else
      self.plaza.visible = self.shared
      self.plaza.save
    end
  end

end
