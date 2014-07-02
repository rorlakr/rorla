json.array!(@bundlelinks) do |bundlelink|
  json.extract! bundlelink, :id
  json.url bundlelink_url(bundlelink, format: :json)
end
