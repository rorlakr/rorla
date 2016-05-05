class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.references :course, index: true, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :youtube_url

      t.timestamps null: false
    end
  end
end
