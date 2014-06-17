class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :writer, index: true
      t.boolean :published, default: false
      t.datetime :published_at
      t.integer :hit, default: 0
      t.datetime :deleted_at
      t.references :bulletin, index: true

      t.timestamps
    end
  end
end
