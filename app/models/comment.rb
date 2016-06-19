# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  writer_id        :integer
#  content          :text(65535)      not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Comment < ActiveRecord::Base

  # Rolify and Authroization
  resourcify
  include Authority::Abilities

  belongs_to :writer, class_name: 'User'
  belongs_to :commentable, polymorphic: true, touch: true
  validates :content, presence: { message: '댓글 내용을 입력하신 후 제출 버튼을 클릭하세요.'}, :length => { :maximum => 255, too_long: "댓글의 글자수가 255자를 넘었습니다." }

end
