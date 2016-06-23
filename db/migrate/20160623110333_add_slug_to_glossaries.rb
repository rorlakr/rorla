class AddSlugToGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :slug, :string
    add_index :glossaries, :slug, unique: true
  end
end
