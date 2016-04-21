class BuyProduct < ActiveRecord::Base
  belongs_to :group_purchase
  belongs_to :product
end
