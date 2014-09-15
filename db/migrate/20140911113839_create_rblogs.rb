class CreateRblogs < ActiveRecord::Migration
  def change
    create_table :rblogs do |t|
      t.string :title
      t.text :content
      t.references :writer, index: true
      t.boolean :shared

      t.timestamps
    end
  end
end
