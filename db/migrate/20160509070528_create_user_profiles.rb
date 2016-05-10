class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.string :github
      t.text :intro, null: false
      t.string :blog
      t.string :website
      t.string :company
      t.string :title

      t.timestamps null: false
    end
  end
end
