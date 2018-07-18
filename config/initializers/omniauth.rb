Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  # provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  # provider :google, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  # provider :soundcloud, ENV['SOUNDCLOUD_KEY'], ENV['SOUNDCLOUD_SECRET']
end
