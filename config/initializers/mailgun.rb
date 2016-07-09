Mailgun.configure do |config|
  config.api_key = Rails.application.secrets.rorla_mailgun_api_key
  config.domain  = 'rorlab.org'
end
