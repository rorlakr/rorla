json.array!(@user_profiles) do |user_profile|
  json.extract! user_profile, :id, :user_id, :name, :github, :intro, :blog, :website, :company, :title
  json.url user_profile_url(user_profile, format: :json)
end
