class GroupPurchase < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  belongs_to :user
  has_many :purchase_requests, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :event_name, :start_date, presence: true
end
