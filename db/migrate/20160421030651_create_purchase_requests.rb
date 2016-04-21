# 티셔츠 공동구매 신청

class CreatePurchaseRequests < ActiveRecord::Migration
  def change
    create_table :purchase_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.date :req_date, default: Date.today
      t.date :send_date
      t.string :sender_name, limit: 10
      t.integer :amount, default: 0
      t.boolean :confirmed, default: false
      t.datetime :confirmed_at

      t.timestamps null: false
    end
  end
end
