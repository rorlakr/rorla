class CreateGlossaries < ActiveRecord::Migration
  def change
    create_table :glossaries do |t|
      t.references :user, index: true, foreign_key: true
      t.string :term, null: false
      t.integer :word_class
      t.boolean :idiomatic
      t.text :memo

      t.timestamps null: false
    end
  end
end
