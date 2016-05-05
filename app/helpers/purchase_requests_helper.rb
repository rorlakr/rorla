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

module PurchaseRequestsHelper
  def purchase_confirmed(request)
    if user_signed_in? && current_user.can_confirm?(request)
      request.confirmed ?
      link_to( "완료", confirm_purchase_path(request), data:{ confirm: "완료 취소하시겠습니까?"},  remote: true, class:'btn btn-success btn-xs') :
      link_to( "미확인", confirm_purchase_path(request), data:{ confirm: "입금 확인을 원하십니까?"}, remote: true, class:'btn btn-danger btn-xs')
    else
      request.confirmed ?
      content_tag(:div, "완료", class:'btn btn-success btn-xs') :
      content_tag(:div, '미확인', class:'btn btn-danger btn-xs')
    end
  end
end
