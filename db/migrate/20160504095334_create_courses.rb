class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :summary
      t.references :tutor, index: true

      t.timestamps null: false
    end
    add_foreign_key :courses, :users, column: :tutor_id
  end
end
