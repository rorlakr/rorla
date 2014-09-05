class RemoveSlugFromBundlelinks < ActiveRecord::Migration
  def change
    remove_column :bundlelinks, :slug, :string
  end
end
