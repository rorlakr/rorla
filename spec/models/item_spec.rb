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

require 'spec_helper'

describe Item do
  pending "add some examples to (or delete) #{__FILE__}"
end
