class AddUserToLecture < ActiveRecord::Migration
  def change
    add_reference :lectures, :user, index: true, foreign_key: true
  end
end
