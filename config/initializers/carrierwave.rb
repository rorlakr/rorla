
# Use local storage if in development or test
if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

# Use AWS storage if in production
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_S3_REGION']
    }
    config.storage = :fog
    config.fog_directory  = ENV['AWS_BUCKET_NAME']
    config.fog_public     = true
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }      
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\s\.\-\+]/
