json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :user_id, :name, :info, :venu, :start_date, :end_date, :repeating, :charged
  json.url schedule_url(schedule, format: :json)
end
