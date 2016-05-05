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

module QuestionsHelper
end
