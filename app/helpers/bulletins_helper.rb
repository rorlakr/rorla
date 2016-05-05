# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  created_at  :datetime
#  updated_at  :datetime
#  post_type   :string(255)      default("general")
#

module BulletinsHelper
end
