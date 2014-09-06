class AddWithScreenShotToFavlink < ActiveRecord::Migration
  def change
    add_column :favlinks, :with_screen_shot, :boolean, default: true
  end
end
