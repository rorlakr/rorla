# == Schema Information
#
# Table name: labnotes
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  summary     :text(65535)
#  codesnippet :text(65535)      not null
#  writer_id   :integer
#  shared      :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

class Labnote < ActiveRecord::Base
  belongs_to :writer, class_name: 'User'
end
