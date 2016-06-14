class CreateGlossaryDefinitions < ActiveRecord::Migration
  def change
    create_table :glossary_definitions do |t|
      t.references :glossary, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :definition, null: false
      t.text :sentence

      t.timestamps null: false
    end
  end
end
