class AddDeletedToPurchaseRequests < ActiveRecord::Migration
  def change
    add_column :purchase_requests, :deleted, :boolean, default: false
    add_column :purchase_requests, :deleted_at, :datetime
    add_reference :purchase_requests, :deleted_by, index: true
    add_foreign_key :purchase_requests, :users, column: :deleted_by_id
  end
end
