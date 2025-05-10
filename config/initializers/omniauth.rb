# https://console.cloud.google.com/apis/credentials?inv=1&invt=Abw_VA&project=xkcd-iterator-395806
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials['GOOGLE_CLIENT_ID'], Rails.application.credentials['GOOGLE_CLIENT_SECRET']
end
