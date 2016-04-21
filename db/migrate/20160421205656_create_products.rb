class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :unit_price
      t.integer :total_stock_count
      t.boolean :sold_out, default: false
      t.datetime :sold_out_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
