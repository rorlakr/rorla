json.array!(@glossaries) do |glossary|
  json.extract! glossary, :id, :user_id, :term, :word_class, :idiomatic, :memo
  json.url glossary_url(glossary, format: :json)
end
