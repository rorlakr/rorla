json.array!(@plazas) do |plaza|
  json.extract! plaza, :id
  json.url plaza_url(plaza, format: :json)
end
