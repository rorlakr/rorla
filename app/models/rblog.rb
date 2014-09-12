class Rblog < ActiveRecord::Base
  resourcify
  include Authority::Abilities

  belongs_to :writer, class_name: "User"
  has_one :plaza, :as => :postitable, :dependent => :destroy

  default_scope { order(created_at: :desc)}

  after_create :set_plaza_rblog


  private

  def set_plaza_rblog
    self.create_plaza
  end
end
