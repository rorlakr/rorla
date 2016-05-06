class AddPublishedToLecture < ActiveRecord::Migration
  def change
    add_column :lectures, :published, :boolean, default: false
    add_column :lectures, :published_at, :datetime
  end
end
