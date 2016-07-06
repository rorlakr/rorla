class AddMemoToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :memo, :text
  end
end
