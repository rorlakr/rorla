class CreateAppliers < ActiveRecord::Migration
  def change
    create_table :appliers do |t|
      t.references :schedule, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :cellphone
      t.string :remittor
      t.datetime :remit_date
      t.integer :remit_money, default: 0
      t.text :memo

      t.timestamps null: false
    end
  end
end
