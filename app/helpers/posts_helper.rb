# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text(65535)
#  writer_id    :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#  hit          :integer          default(0)
#  deleted_at   :datetime
#  bulletin_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#  picture      :string(255)
#  sash_id      :integer
#  level        :integer          default(0)
#

module PostsHelper
end
