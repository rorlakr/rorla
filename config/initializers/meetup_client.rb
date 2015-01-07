MeetupClient.configure do |config|
  config.api_key = Rails.application.secrets.meetup_api_key
end
