# == Schema Information
#
# Table name: favlinks
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)
#  linkurl          :string(255)      not null
#  writer_id        :integer
#  shared           :boolean          default(TRUE)
#  bundlelink_id    :integer
#  created_at       :datetime
#  updated_at       :datetime
#  capture_loc      :string(255)
#  with_screen_shot :boolean          default(TRUE)
#

class Favlink < ActiveRecord::Base

  include TagTokenize

  resourcify
  include Authority::Abilities
  # include AttrSearchable
  include SearchCop

  search_scope :search do
    attributes :title, :description
    attributes :bundlelink => "bundlelink.title"
  end  

  acts_as_taggable

  default_scope { order(created_at: :desc)}

  has_one :plaza, :as => :postitable, :dependent => :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :writer, class_name: 'User'
  belongs_to :bundlelink

  validates :title, presence: true
  validates :writer_id, presence: true
  validates :linkurl, presence: true
  validates :linkurl,
            :format => {:with => URI::regexp, :message => 'Incorrect URL format!'}
  after_save :save_capture_image, if: Proc.new { |link| link.linkurl_changed? && link.with_screen_shot }
  after_create :set_plaza_favlink
  after_update :update_plaza_favlink, if: 'self.shared_changed?'
  after_destroy :delete_capture_image

  scope :shared, -> { Favlink.where(shared: true).order(created_at: :desc)}
  scope :whose, -> (user) { Favlink.where(writer: user).order(created_at: :desc)}

  is_impressionable

  # def tag_tokens=(tokens)
  #   tag_ids = Tag.ids_from_tokens(tokens)
  #   self.tag_list = Tag.where( id: tag_ids).pluck(:name)
  # end

  # def tag_tokens
  #   Tag.order(:name).where( id: self.tag_ids )
  # end

  def capture_image(action)
    kind = action == 'show' ? "" : "thumb_"
    "/uploads/capture_loc/#{id}/#{kind}#{capture_loc}"
  end

  private

  def delete_capture_image
    FileUtils.rm_rf("public/uploads/capture_loc/#{id}")
  end

  def save_capture_image
    tmp_capture_loc = Webshots::Processor.url_to_png linkurl, { 'height' => 768, 'width' => 1024}
    # capture_loc = tmp_capture_loc.split('/').last
    FileUtils.mkdir_p("public/uploads/capture_loc/#{id}") unless Dir.exists?("public/uploads/capture_loc/#{id}")
    FileUtils.rm_rf(Dir.glob("public/uploads/capture_loc/#{id}/*"))
    image = MiniMagick::Image.open(tmp_capture_loc)
    image.resize "200x150"
    image.write  "public/uploads/capture_loc/#{id}/thumb_#{capture_loc}"
    FileUtils.mv(tmp_capture_loc, "public/uploads/capture_loc/#{id}/#{capture_loc}")
  end

  def set_plaza_favlink
    self.create_plaza(visible: self.shared)
  end

  def update_plaza_favlink
    if self.plaza.nil?
      self.create_plaza(visible: self.shared)
    else
      self.plaza.visible = self.shared
      self.plaza.save
    end
  end
end
