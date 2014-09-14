class CreateCodebanks < ActiveRecord::Migration
  def change
    create_table :codebanks do |t|
      t.string :title, null: false
      t.text :summary
      t.text :snippet, null: false
      t.references :writer, index: true
      t.boolean :shared

      t.timestamps
    end
  end
end
