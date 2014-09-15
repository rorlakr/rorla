class CreateLabnotes < ActiveRecord::Migration
  def change
    create_table :labnotes do |t|
      t.string :title, null: false
      t.text :summary
      t.text :codesnippet, null: false
      t.references :writer, index: true
      t.boolean :shared

      t.timestamps
    end
  end
end
