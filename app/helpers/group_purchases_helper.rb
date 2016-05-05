# == Schema Information
#
# Table name: group_purchases
#
#  id         :integer          not null, primary key
#  event_name :string(255)      not null
#  event_info :text(65535)
#  start_date :datetime         not null
#  end_date   :datetime
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module GroupPurchasesHelper
end
