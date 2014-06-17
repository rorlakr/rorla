class AddCaptureLocToFavlinks < ActiveRecord::Migration
  def change
    add_column :favlinks, :capture_loc, :string
  end
end
