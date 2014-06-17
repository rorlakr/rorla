# == Schema Information
#
# Table name: bundlelinks
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text
#  writer_id   :integer          not null
#  shared      :boolean          default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#

class Bundlelink < ActiveRecord::Base
  belongs_to :writer, class_name: 'User'
  has_many :favlinks, dependent: :nullify

  validates :title, presence: true
  validates :writer_id, presence: true
end
