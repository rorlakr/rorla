class CreateGroupPurchases < ActiveRecord::Migration
  def change
    create_table :group_purchases do |t|
      t.string :event_name, null: false
      t.text :event_info
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
