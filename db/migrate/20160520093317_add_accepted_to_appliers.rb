class AddAcceptedToAppliers < ActiveRecord::Migration
  def change
    add_column :appliers, :accepted, :boolean, default: false
  end
end
