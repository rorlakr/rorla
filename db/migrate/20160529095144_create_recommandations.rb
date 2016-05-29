class CreateRecommandations < ActiveRecord::Migration
  def change
    create_table :recommandations do |t|
      t.references :schedule, index: true, foreign_key: true
      t.references :applier, index: true, foreign_key: true
      t.references :recommander, index: true
      t.integer :score, default: 0
      t.text :letter

      t.timestamps null: false
    end
    add_foreign_key :recommandations, :users, column: :recommander_id
  end

end
