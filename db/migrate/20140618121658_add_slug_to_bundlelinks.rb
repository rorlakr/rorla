class AddSlugToBundlelinks < ActiveRecord::Migration
  def change
    add_column :bundlelinks, :slug, :string
    add_index :bundlelinks, :slug
  end
end
