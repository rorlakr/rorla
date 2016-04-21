class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :purchage_request, index: true, foreign_key: true
      t.string :shirts_color, limit: 1
      t.string :shirts_size, limit: 3
      t.integer :count

      t.timestamps null: false
    end
  end
end
