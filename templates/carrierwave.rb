# Uncomment for Google Cloud Storage
# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     provider:                         'Google',
#     google_storage_access_key_id:     Rails.application.secrets.cw_access_key_id,
#     google_storage_secret_access_key: Rails.application.secrets.cw_secret_access_key
#   }
#   config.fog_directory = Rails.application.secrets.cw_bucket
# end

# Uncomment for Amazon AWS
# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider               => 'AWS',
#     :aws_access_key_id      => Rails.application.secrets.cw_access_key_id,     # required
#     :aws_secret_access_key  => Rails.application.secrets.cw_secret_access_key, # required
#     #:region                 => Rails.application.secrets.cw_region            # optional, defaults to 'us-east-1'
#   }
#   config.fog_directory  = Rails.application.secrets.cw_bucket                  # required
# end