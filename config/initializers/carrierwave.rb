require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = 'estreak-bucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:s3_access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:s3_secret_access_key],
      region: Rails.application.credentials.aws[:s3_region],
      path_style: true
    }
    config.fog_public = false
    config.asset_host = 'https://dfpop0kc0xyhe.cloudfront.net'
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
