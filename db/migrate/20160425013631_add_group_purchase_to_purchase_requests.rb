class AddGroupPurchaseToPurchaseRequests < ActiveRecord::Migration
  def change
    add_reference :purchase_requests, :group_purchase, index: true, foreign_key: true
  end
end
