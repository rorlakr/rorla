# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  writer_id    :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#  hit          :integer          default(0)
#  deleted_at   :datetime
#  bulletin_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#  picture      :string(255)
#

class Post < ActiveRecord::Base
  has_merit
  
  resourcify
  include Authority::Abilities

  default_scope { order(created_at: :desc)}

  validates :title, presence: true, :length => { :minimum => 3, :maximum => 255 }
  validates :content, presence: true, :length => { :minimum => 0, :maximum => 10000 }

  before_save :set_published_at

  after_create :set_plaza_post

  has_one :plaza, :as => :postitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :bulletin
  belongs_to :writer, class_name: "User"

  mount_uploader :picture, PictureUploader

  private

  def set_published_at
    if (published == true || published == "true" || published == "1") && published_at.nil?
      self.published_at = Time.now
    elsif (published != true && published != "true" && published != "1") && published_at
      self.published_at = nil
    end
  end

  def set_plaza_post
  	self.create_plaza
  end
end
