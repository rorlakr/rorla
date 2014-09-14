json.array!(@codebanks) do |codebank|
  json.extract! codebank, :id, :title, :summary, :snippet, :writer_id
  json.url codebank_url(codebank, format: :json)
end
