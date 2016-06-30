json.array!(@newsletters) do |newsletter|
  json.extract! newsletter, :id, :title, :greeting, :published_at, :editor_id, :poster
  json.url newsletter_url(newsletter, format: :json)
end
