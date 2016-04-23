module PurchaseRequestsHelper
  def purchase_confirmed(request)
    request.confirmed ?
    link_to( "완료", confirm_purchase_path(request), data:{ confirm: "완료 취소하시겠습니까?"},  remote: true, class:'btn btn-success btn-xs') :
    link_to( "미확인", confirm_purchase_path(request), data:{ confirm: "입금 확인을 원하십니까?"}, remote: true, class:'btn btn-danger btn-xs')
  end
end
