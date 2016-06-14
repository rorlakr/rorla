class AddWordClassCdGlossaries < ActiveRecord::Migration
  def change
    add_column :glossaries, :word_class_cd, :integer
  end
end
