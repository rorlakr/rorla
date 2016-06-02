# == Schema Information
#
# Table name: purchase_requests
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  send_date         :date
#  sender_name       :string(10)
#  send_total_price  :integer          default(0)
#  confirmed         :boolean          default(FALSE)
#  confirmed_at      :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  delivery          :boolean          default(FALSE)
#  parcel_zip        :string(10)
#  parcel_addr       :string(255)
#  parcel_receiver   :string(10)
#  memo              :text(65535)
#  group_purchase_id :integer
#  deleted           :boolean          default(FALSE)
#  deleted_at        :datetime
#  deleted_by_id     :integer
#

class PurchaseRequest < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  validates :user_id, :uniqueness => {:scope => :group_purchase_id, message: "이미 신청하셨습니다."}

  belongs_to :user
  belongs_to :deleted_by, class_name: "User"
  belongs_to :group_purchase
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  before_save :cal_total_price

  accepts_nested_attributes_for :items, :reject_if => proc { |attributes| attributes['count'] == '0' }, :allow_destroy => true

  def human_total_price
    send_total_price.to_s.reverse.scan(/\d{1,3}/).join(",").reverse
  end

  private

  def cal_total_price
    self.send_total_price = self.items.map do | item |
      unit_price = 12_500 if item.shirts_color == 'W'
      unit_price = 17_000 if item.shirts_color == 'B'
      unit_price * item.count
    end.sum
  end

end
