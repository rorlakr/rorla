class PurchaseRequest < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities


  belongs_to :user
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
