Mailgun.configure do |config|
  config.api_key = Rails.application.credentials.dig(:mailgun, :api_key)
  config.domain  = Rails.application.credentials.dig(:mailgun, :domain)
end
