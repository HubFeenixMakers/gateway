LetsEncrypt.config do |config|
  # Using Let's Encrypt staging server or not
  # Default only `Rails.env.production? == true` will use Let's Encrypt production server.
  config.use_staging = false

  # Set the private key path
  # Default is locate at config/letsencrypt.key
  config.private_key_path = Rails.root.join('config', 'letsencrypt.key')

  # Use environment variable to set private key
  # If enable, the API Client will use `LETSENCRYPT_PRIVATE_KEY` as private key
  # Default is false
  config.use_env_key = false

end
