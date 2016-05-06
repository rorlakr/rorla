# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  summary    :text(65535)
#  tutor_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ActiveRecord::Base

  resourcify
  include Authority::Abilities

  belongs_to :tutor, class_name: "User"
  has_many :lectures, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  accepts_nested_attributes_for :lectures, allow_destroy: true, reject_if: :all_blank

  scope :published, -> { where( published: true ).order(published_at: :desc)}
  scope :my_courses, -> (user) { where(tutor: user).order(updated_at: :desc)}

end
