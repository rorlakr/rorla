class CreateUsefulAnswers < ActiveRecord::Migration
  def change
    create_table :useful_answers, id: false do |t|
      t.references :user
      t.references :answer
    end

    add_index :useful_answers, [:user_id, :answer_id], unique: true
    add_index :useful_answers, [:answer_id, :user_id], unique: true
  end
end
