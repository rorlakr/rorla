# == Schema Information
#
# Table name: items
#
#  id                  :integer          not null, primary key
#  purchase_request_id :integer
#  shirts_color        :string(1)
#  shirts_size         :string(3)
#  count               :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Item < ActiveRecord::Base
  belongs_to :purchage_request
end
