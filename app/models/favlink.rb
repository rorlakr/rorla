class Favlink < ActiveRecord::Base
  include Authority::Abilities
  include SearchCop
  include TagTokenize
  acts_as_taggable
  mount_uploader :capture_loc_manual, CaptureUploader
  resourcify
  default_scope { order(created_at: :desc) }

  search_scope :search do
    attributes :title, :description
    attributes bundlelink: 'bundlelink.title'
  end

  has_one :plaza, as: :postitable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :writer, class_name: 'User'
  belongs_to :bundlelink

  validates :title, presence: true
  validates :writer_id, presence: true
  validates :linkurl, presence: true
  validates :linkurl,
            format: { with: URI::regexp, message: 'Incorrect URL format!' }
  after_save :save_capture_image,
             if: proc { |link| link.linkurl_changed? && link.with_screen_shot }
  after_create :set_plaza_favlink
  after_update :update_plaza_favlink, if: :shared_changed?
  after_destroy :delete_capture_image

  scope :shared, -> { Favlink.where(shared: true).order(created_at: :desc)}
  scope :whose, ->(user) { Favlink.where(writer: user).order(created_at: :desc)}

  is_impressionable

  def capture_image(action)
    kind = (action == 'show' ? '' : 'thumb_')
    "/uploads/favlink/capture_loc/#{id}/#{kind}#{capture_loc}"
  end

  private

  def delete_capture_image
    FileUtils.rm_rf("public/uploads/capture_loc/#{id}")
  end

  def save_capture_image
    tmp_capture_loc = Webshots::Processor.url_to_png linkurl,
                                                     'height': 768,
                                                     'width': 1024
    unless Dir.exist? "public/uploads/capture_loc/#{id}"
      FileUtils.mkdir_p("public/uploads/favlink/capture_loc/#{id}")
    end
    FileUtils.rm_rf(Dir.glob("public/uploads/favlink/capture_loc/#{id}/*"))
    image = MiniMagick::Image.open(tmp_capture_loc)
    image.resize '200x150'
    image.write  "public/uploads/favlink/capture_loc/#{id}/thumb_#{capture_loc}"
    FileUtils.mv tmp_capture_loc,
                 "public/uploads/favlink/capture_loc/#{id}/#{capture_loc}"
  end

  def set_plaza_favlink
    create_plaza(visible: shared)
  end

  def update_plaza_favlink
    if plaza.nil?
      create_plaza(visible: shared)
    else
      plaza.visible = shared
      plaza.save
    end
  end
end
