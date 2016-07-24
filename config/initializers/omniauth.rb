OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '314376425571858', '775c2203c5f783a0ad2df6957b09ed54'
end