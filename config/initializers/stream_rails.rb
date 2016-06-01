require 'stream_rails'

# getstream.io
# login: digitalYouth
# pass : ubcokanagan
StreamRails.configure do |config|
  config.api_key     = "nqgwe53qrjhh"
  config.api_secret  = "xbas8tj7a6tc8znq9a9h4ajjezhznqfw4peezbvg6e8gzf4cq6fwvbgpqmxj3xq8"
  config.timeout     = 30               
  config.location    = 'us-west'        
  config.notification_feed = "notifications"
end