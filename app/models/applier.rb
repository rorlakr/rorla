class Applier < ActiveRecord::Base

  resourcify
  include Authority::Abilities
  
  belongs_to :schedule
  belongs_to :user

  validates :name, :email, presence: true
  validates :user_id, presence: true, uniqueness:  { scope: :schedule_id, message: "이미 신청하셨습니다." }
end
