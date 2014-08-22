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
  extend FriendlyId
  friendly_id :title

  belongs_to :writer, class_name: 'User'
  has_many :favlinks, dependent: :nullify

  validates :title, presence: true
  validates :writer_id, presence: true

  scope :shared_bundles, -> { Bundlelink.where(shared: true) }
  scope :my_bundles, -> (user) { Bundlelink.where(writer: user)}
  if Rails.env == "production"
    scope :as_collection, -> (user) { Bundlelink.where("shared = 1 or (writer_id = ? and shared = 0)", user.id)} 
  else
    scope :as_collection, -> (user) { Bundlelink.where("shared = 't' or (writer_id = ? and shared = 'f')", user.id)}
  end

end
