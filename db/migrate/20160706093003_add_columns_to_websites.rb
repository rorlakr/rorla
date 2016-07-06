class AddColumnsToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :service_type_cd, :integer
    add_column :websites, :service_state_cd, :integer
  end
end
