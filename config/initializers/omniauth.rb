Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '206176569535504', '48cf22e8dc1d2f6c82d3ad1fc3716aa6'
  provider :twitter, '83swQvBLNv3XsmAySZqQ', 'SfSgjmo0WR00agppUNIgV3QNvrTKAX0OgjXyoWgg8s'
  provider :google_oauth2, '1064018417609.apps.googleusercontent.com', '0vWLOoxciv2b1N-sSbN1MB39'
end