Mailgun.configure do |config|
  config.api_key = ENV['api_key']
  config.domain  = ENV['domain']
end
