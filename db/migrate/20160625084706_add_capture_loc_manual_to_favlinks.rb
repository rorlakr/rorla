class AddCaptureLocManualToFavlinks < ActiveRecord::Migration
  def change
    add_column :favlinks, :capture_loc_manual, :string
  end
end
