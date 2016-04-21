json.array!(@purchase_requests) do |purchase_request|
  json.extract! purchase_request, :id, :user_id, :req_date, :send_date, :sender_name, :amount, :confirmed, :confirmed_at
  json.url purchase_request_url(purchase_request, format: :json)
end
