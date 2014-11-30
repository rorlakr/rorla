class AddSendedAtIndexToWeeklynews < ActiveRecord::Migration
  def change
    add_index :weeklynews, :sended_at
  end
end
