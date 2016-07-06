json.array!(@websites) do |website|
  json.extract! website, :id, :name, :site_url, :service_state, :service_type, :user_id
  json.url website_url(website, format: :json)
end
