class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :name, null: false
      t.string :site_url, null: false
      t.integer :service_state
      t.integer :service_type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
