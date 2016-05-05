# == Schema Information
#
# Table name: favlinks
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)
#  linkurl          :string(255)      not null
#  writer_id        :integer
#  shared           :boolean          default(TRUE)
#  bundlelink_id    :integer
#  created_at       :datetime
#  updated_at       :datetime
#  capture_loc      :string(255)
#  with_screen_shot :boolean          default(TRUE)
#

module FavlinksHelper
  include ActsAsTaggableOn::TagsHelper
end
