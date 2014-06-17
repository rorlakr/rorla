json.array!(@favlinks) do |favlink|
  json.extract! favlink, :id
  json.url favlink_url(favlink, format: :json)
end
