class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :author
      t.text :description
      t.text :enclosure_url
      t.integer :enclosure_size, default: 0
      t.string :duration

      t.timestamps
    end
  end
end
