class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :newsletter, index: true, foreign_key: true
      t.references :news_section, index: true, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :poster
      t.string :reference_url
      t.references :reporter, index: true

      t.timestamps null: false
    end
    add_foreign_key :articles, :users, column: :reporter_id
  end
end
