json.array!(@answers) do |answer|
  json.id answer.id
  json.content answer.content
  json.created_at answer.created_at
end
