class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.references :writer, index: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
