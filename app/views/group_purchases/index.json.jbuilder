json.array!(@group_purchases) do |group_purchase|
  json.extract! group_purchase, :id, :event_name, :event_info, :start_date, :end_date, :user_id
  json.url group_purchase_url(group_purchase, format: :json)
end
