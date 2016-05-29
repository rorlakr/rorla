class Applier < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  belongs_to :schedule
  has_many :recommandations, dependent: :destroy
  has_many :recommanders, class_name: 'User', foreign_key: :recommander_id, through: :recommandations
  has_many :categories
  belongs_to :user

  validates :name, :email, presence: true
  validates :user_id, presence: true, uniqueness:  { scope: :schedule_id, message: "이미 신청하셨습니다." }

  scope :accepted, -> { where accepted: true }

  def recommanded_by?(user)
    self.recommanders.include? user
  end

end
