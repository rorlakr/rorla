class AddPublishedToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :published, :boolean, default: false
    add_column :courses, :published_at, :datetime
  end
end
