class Rblog < ActiveRecord::Base
  resourcify
  include Authority::Abilities

  belongs_to :writer, class_name: "User"
  has_one :plaza, :as => :postitable, :dependent => :destroy

  default_scope { order(created_at: :desc)}
  scope :shared, -> { where(shared: true)}
  scope :my_blogs, -> (user_id) { where(writer_id: user_id)}
  scope :my_shared_blogs, -> (user_id) { my_blogs(user_id).where(shared: true)}
  scope :my_private_blogs, -> (user_id) { my_blogs(user_id).where(shared: false)}

  validates :title, :content, presence: true

  after_create :set_plaza_rblog
  after_update :update_plaza_rblog, if: 'self.shared_changed?'


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
