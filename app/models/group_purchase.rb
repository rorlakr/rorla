# == Schema Information
#
# Table name: group_purchases
#
#  id         :integer          not null, primary key
#  event_name :string(255)      not null
#  event_info :text(65535)
#  start_date :datetime         not null
#  end_date   :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupPurchase < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  belongs_to :user
  has_many :purchase_requests, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :event_name, :start_date, presence: true
end
