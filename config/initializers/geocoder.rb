# Configuration for Rails Geocoder
# https://github.com/alexreisner/geocoder#geocoding-services

Geocoder.configure do |config|
    # Geocoding service
    config.lookup = :google

    # Google Maps V3 API Key
    config.api_key = "AIzaSyAp-FkgYLqaU9Vdze3UYd3X7FGC6oadfQ0"
end