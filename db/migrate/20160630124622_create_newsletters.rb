class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :title
      t.text :greeting
      t.datetime :published_at
      t.references :editor, index: true, foreign_key: true
      t.string :poster

      t.timestamps null: false
    end
  end
end
