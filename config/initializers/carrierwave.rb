# Use local storage if in development or test
if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

# Use AWS storage if in production
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                => ENV['AWS_S3_REGION']
    }
  
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_directory  = ENV['AWS_BUCKET_NAME']
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
    config.storage = :fog
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\s\.\-\+]/
