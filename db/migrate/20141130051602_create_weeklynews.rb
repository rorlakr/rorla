class CreateWeeklynews < ActiveRecord::Migration
  def change
    create_table :weeklynews do |t|
      t.string :uid, null: false
      t.string :subject, null: false
      t.datetime :sended_at, null: false
      t.text :url, null: false

      t.timestamps
    end
  end
end
