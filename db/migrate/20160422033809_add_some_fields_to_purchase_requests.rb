class AddSomeFieldsToPurchaseRequests < ActiveRecord::Migration
  def change
    add_column :purchase_requests, :delivery, :boolean, default: false
    add_column :purchase_requests, :parcel_zip, :string, limit: 10
    add_column :purchase_requests, :parcel_addr, :string
    add_column :purchase_requests, :parcel_receiver, :string, limit: 10
    add_column :purchase_requests, :memo, :text
  end
end
