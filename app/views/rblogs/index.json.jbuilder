json.array!(@rblogs) do |rblog|
  json.extract! rblog, :id, :title, :content, :writer_id, :shared
  json.url rblog_url(rblog, format: :json)
end
