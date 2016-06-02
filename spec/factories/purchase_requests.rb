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
#  deleted           :boolean          default(FALSE)
#  deleted_at        :datetime
#  deleted_by_id     :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_request do
    user nil
    req_date "2016-04-21"
    send_date "2016-04-21"
    sender_name "MyString"
    amount 1
    confirmed false
    confirmed_at "2016-04-21 12:06:52"
  end
end
