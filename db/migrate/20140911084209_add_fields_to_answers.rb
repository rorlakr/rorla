class AddFieldsToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :sash_id, :integer
    add_column :answers, :level, :integer, :default => 0
  end

  def self.down
    remove_column :answers, :sash_id
    remove_column :answers, :level
  end
end
