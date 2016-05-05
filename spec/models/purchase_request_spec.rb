# == Schema Information
#
# Table name: purchase_requests
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  send_date         :date
#  sender_name       :string(10)
#  send_total_price  :integer          default(0)
#  confirmed         :boolean          default(FALSE)
#  confirmed_at      :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  delivery          :boolean          default(FALSE)
#  parcel_zip        :string(10)
#  parcel_addr       :string(255)
#  parcel_receiver   :string(10)
#  memo              :text(65535)
#  group_purchase_id :integer
#

require 'spec_helper'

describe PurchaseRequest do
  pending "add some examples to (or delete) #{__FILE__}"
end
