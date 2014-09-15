class AddFieldsToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :sash_id, :integer
    add_column :questions, :level, :integer, :default => 0
  end

  def self.down
    remove_column :questions, :sash_id
    remove_column :questions, :level
  end
end
