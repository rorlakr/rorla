# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Question < ActiveRecord::Base
  after_create :set_plaza_question

  has_one :plaza, :as => :postitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  has_many :answers, dependent: :destroy

  belongs_to :user

  validates_presence_of :title, :content

  def is_owner?(user)
    self.user == user 
  end

  def questioner
    user.email
  end

  def no_answers
    answers.count
  end

  private
    def set_plaza_question
      self.create_plaza
    end

end
