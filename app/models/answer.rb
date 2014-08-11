# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  created_at  :datetime
#  updated_at  :datetime
#  question_id :integer
#  user_id     :integer
#

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_and_belongs_to_many :useful_users, class_name: "User", join_table: :useful_answers

  validates_presence_of :content

  def answerer
    user.email
  end

  def is_owner?(user)
    self.user == user
  end

  def was_useful?(user)
    useful_users.find_by(id: user.id)
  end

  def is_useful(user)
    useful_users << user
  end

  def is_not_useful(user)
    useful_users.delete(user)
  end

end

