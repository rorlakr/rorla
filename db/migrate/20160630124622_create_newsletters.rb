class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :title, null: false
      t.text :greeting
      t.datetime :published_at
      t.references :editor, index: true
      t.string :poster

      t.timestamps null: false
    end
    add_foreign_key :newsletters, :users, column: :editor_id
  end
end
