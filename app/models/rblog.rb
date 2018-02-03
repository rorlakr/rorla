# == Schema Information
#
# Table name: rblogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  writer_id  :integer
#  shared     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Rblog < ActiveRecord::Base
  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  # Declarations for Model Associations
  belongs_to :writer, class_name: "User"
  has_one :plaza, as: :postitable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  # Definition of Scopes
  default_scope { order(created_at: :desc)}
  scope :shared, -> { where(shared: true)}
  scope :my_blogs, -> (user_id) { where(writer_id: user_id)}
  scope :my_shared_blogs, -> (user_id) { my_blogs(user_id).where(shared: true)}
  scope :my_private_blogs, -> (user_id) { my_blogs(user_id).where(shared: false)}

  # Validators
  validates :title, :content, presence: true

  # Callback
  after_create :set_plaza_rblog
  after_update :update_plaza_rblog, if: :shared_changed?

  # Model Impressionable
  is_impressionable

  # 태그 토큰입력
  include TagTokenize
  acts_as_taggable

  private

  def set_plaza_rblog
    self.create_plaza(visible: self.shared)
  end

  def update_plaza_rblog
    if self.plaza.nil?
      self.create_plaza(visible: self.shared)
    else
      self.plaza.visible = self.shared
      self.plaza.save
    end
  end
end
