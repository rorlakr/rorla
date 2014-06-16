json.array!(@bulletins) do |bulletin|
  json.extract! bulletin, :id
  json.url bulletin_url(bulletin, format: :json)
end
