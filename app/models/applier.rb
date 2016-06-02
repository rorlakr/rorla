# == Schema Information
#
# Table name: appliers
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  user_id     :integer
#  name        :string(255)      not null
#  email       :string(255)      not null
#  cellphone   :string(255)
#  remittor    :string(255)
#  remit_date  :datetime
#  remit_money :integer          default(0)
#  memo        :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  accepted    :boolean          default(FALSE)
#

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
