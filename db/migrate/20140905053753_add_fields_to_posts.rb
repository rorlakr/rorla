class AddFieldsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :sash_id, :integer
    add_column :posts, :level, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :sash_id
    remove_column :posts, :level
  end
end
