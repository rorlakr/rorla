class CreateBuyProducts < ActiveRecord::Migration
  def change
    create_table :buy_products do |t|
      t.references :group_purchase, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
