# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.production?
  Rails.logger = Le.new(Rails.application.secrets.logentries_token)
end