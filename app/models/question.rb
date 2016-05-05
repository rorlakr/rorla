# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  sash_id    :integer
#  level      :integer          default(0)
#

class Question < ActiveRecord::Base
  has_merit

  resourcify
  include Authority::Abilities

  after_create :set_plaza_question

  has_one :plaza, :as => :postitable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  has_many :answers, dependent: :destroy

  belongs_to :user

  validates_presence_of :title, :content

  default_scope { order(created_at: :desc)}

  is_impressionable

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
