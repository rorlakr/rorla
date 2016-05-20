class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.text :info
      t.string :venue
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :repeating
      t.boolean :charged, default: false
      t.integer :charge_amount, default: 0

      t.timestamps null: false
    end
  end
end
